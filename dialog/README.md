# dialog

Dialog utilities for Flutter.

## Install

add `dialog` to your pubspec.yaml:

```yaml
dependencies:
  dialog:
    git:
      url: git@github.com:najeira/flutter-packages.git
      path: dialog
```

## Usage

```dart
// show dialog while 3 seconds
showTimerDialog(
  context: context,
  timeout: const Duration(seconds: 3),
  child: new SimpleDialog(
    ...
  ),
);
```
