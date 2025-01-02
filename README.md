<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->
<p align="center">
  <a href="https://pub.dev/packages/tarsier_env">
    <img height="260" src="https://raw.githubusercontent.com/marianz-bonfire/tarsier_env/master/assets/logo.png">
  </a>
  <h1 align="center">Tarsier ENV</h1>
</p>

<p align="center">
  <a href="https://pub.dev/packages/tarsier_env">
    <img src="https://img.shields.io/pub/v/tarsier_env?label=pub.dev&labelColor=333940&logo=dart">
  </a>
  <a href="https://pub.dev/packages/tarsier_env/score">
    <img src="https://img.shields.io/pub/points/tarsier_env?color=2E8B57&label=pub%20points">
  </a>
  <a href="https://github.com/marianz-bonfire/tarsier_env/actions/workflows/dart.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/marianz-bonfire/tarsier_env/dart.yml?branch=main&label=tests&labelColor=333940&logo=github">
  </a>
  <a href="https://app.codecov.io/gh/marianz-bonfire/tarsier_env">
    <img src="https://img.shields.io/codecov/c/github/marianz-bonfire/tarsier_env?logo=codecov&logoColor=fff&labelColor=333940&flag=tarsier_env">
  </a>
  <a href="https://pub.dev/packages/tarsier_env/publisher">
    <img src="https://img.shields.io/pub/publisher/tarsier_env.svg">
  </a>
  <a href="https://tarsier-marianz.blogspot.com">
    <img src="https://img.shields.io/static/v1?label=website&message=tarsier-marianz&labelColor=135d34&logo=blogger&logoColor=white&color=fd3a13">
  </a>
</p>

<p align="center">
  <a href="https://pub.dev/documentation/tarsier_env/latest/">Documentation</a> •
  <a href="https://github.com/marianz-bonfire/tarsier_env/issues">Issues</a> •
  <a href="https://github.com/marianz-bonfire/tarsier_env/tree/master/example">Example</a> •
  <a href="https://github.com/marianz-bonfire/tarsier_env/blob/master/LICENSE">License</a> •
  <a href="https://pub.dev/packages/tarsier_env">Pub.dev</a>
</p>

A Dart/Flutter package for creating/loading `.env` files and generating a Dart file containing environment variables with static getters. This package simplifies the management of environment variables and helps automate the process of accessing them within your project.

## ✨ Features

- Creates `.env` file if not existed with pre-defined keys and values.
- Loads `.env` files and parses them into a `Map<String, String>`.
- Generates a `env.dart` file with static getters for each environment variable.
- Automatically inserts the import statement and `Env.init()` initialization in `main.dart`.
- Supports custom paths for the `env.dart` file.

## 🚀 Installation

### Add Dependency

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  tarsier_env: ^1.0.4
```
Then run this command:

```sh
flutter pub get
```

### 🖥️ Commands

The `dart run tarsier_env <parameters> <options>` syntax maps directly with required parameters (`generate`, `new`). Options is when you use command `generate` for custom path.

```
dart run tarsier_env new
dart run tarsier_env generate
dart run tarsier_env generate custom_path_for_env/env.dart
```

### 📒 Usage Example

#### 1. Generates a default `.env` file with basic content, including a placeholder for your app name. Automatically checks if `.env` is listed in `.gitignore` and adds it if not already present.
```sh
dart run tarsier_env new
```
This will generate a `.env` file in the root directory with the following pre-defined content:
```sh
# AUTO-GENERATED FILE. 
# YOU CAN EDIT/ADD MORE KEYS AND ITS VALUE.
# Generated by tarsier_env script.

APP_NAME="Tarsier"
APP_ENV=local
APP_KEY=null
APP_DEBUG=true
APP_URL=http://localhost

...
```
The project directory structure will look like this.
```sh
your_project_name/
├── lib/
│   └── name.dart
├── test/
├── .env  #This is the created file upon running the command
├── pubspec.yaml
├── ...
```


#### 2. Generates a `env.dart` file containing static getters for environment variables from your `.env` file. Automatically imports `env.dart`. Inserts `await Env.init();` in the `main()` function of `main.dart`.
```sh
dart run tarsier_env generate common/environment
```
  - If no path is provided, the generated file will be placed in `lib/env.dart`.
  - If a relative path under the `lib` directory is provided, the file will be placed in the corresponding subfolder.



This will create `lib/common/environment/env.dart` with the environment. After running above code, you can access the environment variables in your Flutter app.
The `env.dart` file generated by the package would look like this:
```dart
class Env {
  static Map<String, String> _variables = {};

  static init() async {
    _variables = await loadEnvFile('.env');
  }

  static Map<String, String> get vars => _variables;
  static String? get appName => _variables['APP_NAME'];
  static String? get appKey => _variables['APP_KEY'];
}
```

In your `main.dart`, ensure the `Env.init()` method is called before using any environment variable.

```dart
import 'package:flutter/material.dart';
import 'common/environment/env.dart'; // Automatically generated import

void main() async {
  await Env.init(); // Initialize environment variables

  String appName = Env.appName; // You can use the generated static getter
  String appKey = Env.vars['APP_KEY']; // Or you can use the key in the Map<String,String>

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Env.appName ?? 'Flutter App',
      home: Scaffold(
        appBar: AppBar(
          title: Text(Env.vars['APP_NAME'] ?? 'Flutter App'),
        ),
      ),
    );
  }
}
```

### 🎖️ License
This package is licensed under the [MIT License](https://mit-license.org/).

### 🐞Suggestions for Improvement?
Feel free to open an issue or submit a pull request on [GitHub](https://github.com/marianz-bonfire/tarsier_env).

#### Why "Tarsier ENV"?
The tarsier, one of the smallest primates, symbolizes simplicity and adaptability—just like this package! 🐒
