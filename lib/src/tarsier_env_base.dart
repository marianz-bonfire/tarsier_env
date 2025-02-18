import 'dart:io';

/// Loads and parses a `.env` file to retrieve environment variables.
///
/// This function reads a `.env` file from the specified [filePath] and parses it
/// into a `Map<String, String>` containing the environment variables as key-value pairs.
///
/// - Lines starting with `#` or empty lines are ignored.
/// - Surrounding quotes (`"`, `'`) are stripped from values.
/// - Handles inline comments that start with `#` but only if they have a preceding space.
///
/// Example usage:
/// ```dart
/// final envVars = await loadEnvFile('.env');
/// print(envVars['APP_KEY']); // Access a specific variable
/// ```
///
/// Throws:
/// - [FileSystemException] if the `.env` file does not exist.
/// - [FormatException] if a line in the `.env` file has an invalid format.
Future<Map<String, String>> loadEnvFile(String filePath) async {
  final Map<String, String> envVars = {};

  // Check if the file exists
  final file = File(filePath);
  if (!await file.exists()) {
    throw FileSystemException("The .env file was not found.", filePath);
  }

  try {
    // Read the file line by line
    final lines = await file.readAsLines();

    for (var line in lines) {
      // Trim whitespace from the line
      line = line.trim();

      // Skip empty lines and comments
      if (line.isEmpty || line.startsWith('#')) continue;

      // Check for a valid key-value pair
      final separatorIndex = line.indexOf('=');
      if (separatorIndex == -1) {
        throw FormatException(
            "Invalid format in .env file at line: $line", filePath);
      }

      final key = line.substring(0, separatorIndex).trim();
      var value = line.substring(separatorIndex + 1).trim();

      // Remove surrounding quotes from the value, if present
      if ((value.startsWith('"') && value.endsWith('"')) ||
          (value.startsWith("'") && value.endsWith("'"))) {
        value = value.substring(1, value.length - 1);
      }

      // Add the key-value pair to the map
      envVars[key] = value;
    }
  } catch (e) {
    // Catch and rethrow any unexpected errors with additional context
    throw Exception("Failed to parse the .env file: $e");
  }

  return envVars;
}

/// Parses the `.env` file content into a `Map<String, String>`.
///
/// - Ignores empty lines and comments starting with `#`.
/// - Handles inline comments, but only if there's a preceding space before `#`.
/// - Removes surrounding double quotes from values.
///
/// Example:
/// ```dart
/// String content = 'APP_NAME="My App"\nAPP_DEBUG=true\nAPP_KEY=12345';
/// final envVars = parseEnv(content);
/// print(envVars['APP_NAME']); // Output: My App
/// ```
Map<String, String> parseEnv(String content) {
  final envMap = <String, String>{};

  for (var line in content.split('\n')) {
    line = line.trim();
    if (line.isEmpty || line.startsWith('#')) continue;

    final parts = line.split('=');
    if (parts.length < 2) continue;

    final key = parts[0].trim();
    var value = parts.sublist(1).join('=').trim();

    // Handle inline comments only if there's a space before `#`
    final commentIndex = value.indexOf(' #');
    if (commentIndex != -1) {
      value = value.substring(0, commentIndex).trim();
    }

    // Remove surrounding double quotes
    if (value.startsWith('"') && value.endsWith('"')) {
      value = value.substring(1, value.length - 1);
    }

    envMap[key] = value;
  }

  return resolveReferences(envMap);
}

/// Resolves variable references within the environment map.
///
/// If a value contains `${VAR_NAME}`, it is replaced with the actual value of `VAR_NAME`.
/// If the referenced variable does not exist, it is replaced with an empty string.
///
/// Example:
/// ```dart
/// final env = {'APP_URL': 'http://localhost', 'API_PATH': '${APP_URL}/api'};
/// final resolved = resolveReferences(env);
/// print(resolved['API_PATH']); // Output: http://localhost/api
/// ```
Map<String, String> resolveReferences(Map<String, String> envMap) {
  final regex = RegExp(r'\$\{([A-Z0-9_]+)\}'); // Match ${VAR_NAME}

  envMap.updateAll((key, value) {
    return value.replaceAllMapped(regex, (match) {
      String refKey = match.group(1) ?? '';
      return envMap[refKey] ??
          ''; // Replace with referenced value or empty string
    });
  });

  return envMap;
}

/// Returns a default value of type `T` if none is provided.
///
/// Supports:
/// - `String`: Defaults to `''`
/// - `int`: Defaults to `0`
/// - `double`: Defaults to `0.0`
/// - `bool`: Defaults to `false`
/// - `List`: Defaults to `[]`
/// - `Map`: Defaults to `{}`
///
/// Throws [ArgumentError] if no valid fallback is found.
///
/// Example:
/// ```dart
/// int defaultInt = resolvedDefaultValue<int>(null); // Returns 0
/// ```
T resolvedDefaultValue<T>(T? defaultValue) {
  if (defaultValue != null) return defaultValue;

  if (T == String) return '' as T;
  if (T == int) return 0 as T;
  if (T == double) return 0.0 as T;
  if (T == bool) return false as T;
  if (T == List) return [] as T;
  if (T == Map) return {} as T;

  throw ArgumentError(
      'No default value provided and no valid fallback for type $T');
}

/// Converts a `String` value to the specified type `T`.
///
/// Supported conversions:
/// - `String` → `String`
/// - `String` → `int`
/// - `String` → `double`
/// - `String` → `bool` (`"true"` → `true`, `"false"` → `false`)
///
/// Returns `null` if conversion is not possible.
///
/// Example:
/// ```dart
/// int? value = convertType<int>('42'); // Output: 42
/// bool? isDebug = convertType<bool>('true'); // Output: true
/// ```
T? convertType<T>(String value) {
  if (T == String) return value as T;
  if (T == int) return int.tryParse(value) as T?;
  if (T == double) return double.tryParse(value) as T?;
  if (T == bool) return (value.toLowerCase() == 'true') as T?;
  return null; // Fallback for unsupported types
}
