import 'dart:io';

/// Loads and parses a `.env` file to retrieve environment variables.
///
/// This function reads a `.env` file from the specified [filePath] and parses it
/// into a `Map<String, String>` containing the environment variables as key-value pairs.
///
/// - Lines starting with `#` or empty lines are ignored.
/// - Surrounding quotes (`"`, `'`) are stripped from values.
///
/// Example usage:
/// ```dart
/// final envVars = await loadEnvFile('.env');
/// print(envVars['APP_KEY']); // Access a specific variable
/// ```
///
/// Throws:
/// - [FileSystemException]: If the `.env` file does not exist.
/// - [FormatException]: If a line in the `.env` file has an invalid format.
Future<Map<String, String>> loadEnvFile(String filePath) async {
  final Map<String, String> envVars = {};

  // Check if the file exists
  final file = File(filePath);
  if (!await file.exists()) {
    throw FileSystemException(
      "The .env file was not found.",
      filePath,
    );
  }

  try {
    // Read the file line by line
    final lines = await file.readAsLines();

    for (var line in lines) {
      // Trim whitespace from the line
      line = line.trim();

      // Skip empty lines and comments
      if (line.isEmpty || line.startsWith('#')) {
        continue;
      }

      // Check for a valid key-value pair
      final separatorIndex = line.indexOf('=');
      if (separatorIndex == -1) {
        throw FormatException(
          "Invalid format in .env file at line: $line",
          filePath,
        );
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

// Load .env file from assets for all platforms (mobile, web, desktop)
Future<Map<String, String>> loadEnvFromAssets() async {
  try {
    final content = ''; //await rootBundle.loadString('assets/.env');
    return parseEnv(content.split('\n'));
  } catch (e) {
    print('Error loading .env file from assets: $e');
    return {};
  }
}

// Parse .env file lines into a Map
Map<String, String> parseEnv(List<String> lines) {
  final envMap = <String, String>{};

  for (var line in lines) {
    if (line.trim().isEmpty || line.startsWith('#')) continue;
    final parts = line.split('=');
    if (parts.length == 2) {
      envMap[parts[0].trim()] = parts[1].trim();
    }
  }
  return envMap;
}
