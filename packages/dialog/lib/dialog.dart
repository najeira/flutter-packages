library dialog;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Displays a dialog above the current contents of the app.
///
/// This function typically receives a [Dialog] widget as its child argument.
/// Content below the dialog is dimmed with a [ModalBarrier].
///
/// The `context` argument is used to look up the [Navigator] and [Theme] for
/// the dialog. It is only used when the method is called. Its corresponding
/// widget can be safely removed from the tree before the dialog is closed.
///
/// Returns a [Future] that resolves to the value (if any) that was passed to
/// [Navigator.pop] when the dialog was closed.
///
/// See also:
///  * [AlertDialog], for dialogs that have a row of buttons below a body.
///  * [SimpleDialog], which handles the scrolling of the contents and does
///    not show buttons below its body.
///  * [Dialog], on which [SimpleDialog] and [AlertDialog] are based.
///  * <https://material.google.com/components/dialogs.html>
Future<T> showTimerDialog<T>({
  @required BuildContext context,
  bool barrierDismissible: true,
  @required Widget child,
  @required Duration duration,
}) {
  if (duration != null) {
    child = new _FutureDialog(
      child: child,
      future: new Future.delayed(duration),
    );
  }
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    child: child,
  );
}

/// Displays a dialog above the current contents of the app.
///
/// This function typically receives a [Dialog] widget as its child argument.
/// Content below the dialog is dimmed with a [ModalBarrier].
///
/// The `context` argument is used to look up the [Navigator] and [Theme] for
/// the dialog. It is only used when the method is called. Its corresponding
/// widget can be safely removed from the tree before the dialog is closed.
///
/// Returns a [Future] that resolves to the value (if any) that was passed to
/// [Navigator.pop] when the dialog was closed.
///
/// See also:
///  * [AlertDialog], for dialogs that have a row of buttons below a body.
///  * [SimpleDialog], which handles the scrolling of the contents and does
///    not show buttons below its body.
///  * [Dialog], on which [SimpleDialog] and [AlertDialog] are based.
///  * <https://material.google.com/components/dialogs.html>
Future<T> showFutureDialog<T>({
  @required BuildContext context,
  bool barrierDismissible: true,
  @required Widget child,
  @required Future<T> future,
}) {
  if (future != null) {
    child = new _FutureDialog(
      child: child,
      future: future,
    );
  }
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    child: child,
  );
}

class _FutureDialog<T> extends StatefulWidget {
  final Widget child;
  final Future<T> future;
  
  _FutureDialog({
    this.child,
    this.future,
  });
  
  @override
  State<StatefulWidget> createState() {
    return new _FutureDialogState<T>();
  }
}

class _FutureDialogState<T> extends State<_FutureDialog> with WidgetsBindingObserver {
  bool foreground = true;
  bool complete = false;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.future.whenComplete(() {
      complete = true;
      _closeDialog();
    });
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    foreground = (state == AppLifecycleState.resumed);
    if (foreground && complete) {
      _closeDialog();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
  
  void _closeDialog() {
    if (mounted && foreground && complete) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
