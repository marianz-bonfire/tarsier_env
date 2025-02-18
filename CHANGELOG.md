## 1.0.6

* Optimized parsing for better readability.
* Improved parsing or `.env` content
    - Keeps `#` inside values if there’s no space before it
    - Removes inline comments only when a space exists before `#`
    - Trims surrounding double quotes
    - Supports variable referencing (`${VAR_NAME}`)
    - Handles concatenation (e.g., `"${APP_URL}${APP_PATH}"`)
    - Removes quotes & skips comments properly
+ Added function to get value dynamically for any type while providing a valid default fallback. 
+ Added pubspec topics
+ Modified README file for newly added enhancement

## 1.0.5

* Enabled package to support global activate
+ Fixed issue on loading `.env` file
+ Added `.env` as flutter assets on pubspec
+ Loaded `.env` file as assets
+ Added capability to auto add `WidgetFlutterBinding`
* Enhanced flutter example
+ Upgrade SDK constraint
+ Added flutter example screenshot

## 1.0.4

+ Added pubspec screenshot

## 1.0.3

- Fixed wrong command entries
+ Added more detailed library docs

## 1.0.2

-  Fixed pub analysis warning
+  Added package logo

## 1.0.1

-  Fixed placeholder of app name in the `.env` file

## 1.0.0

- Initial version.
