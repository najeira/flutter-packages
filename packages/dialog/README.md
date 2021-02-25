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
  duration: const Duration(seconds: 3),
  child: new SimpleDialog(
    ...
  ),
);
```

```dart
// show dialog until future completed
showFutureDialog(
  context: context,
  future: yourFuture,
  child: new SimpleDialog(
    ...
  ),
);
```
