library dialog;

import 'dart:async';

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
Future<void> showTimerDialog({
  required BuildContext context,
  bool barrierDismissible = true,
  required WidgetBuilder builder,
  required Duration duration,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return _FutureDialog(
        child: builder(context),
        future: Future<void>.delayed(duration),
      );
    },
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
Future<void> showFutureDialog({
  required BuildContext context,
  bool barrierDismissible = true,
  required WidgetBuilder builder,
  required Future future,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return _FutureDialog(
        child: builder(context),
        future: future,
      );
    },
  );
}

class _FutureDialog extends StatefulWidget {
  const _FutureDialog({
    Key? key,
    required this.child,
    required this.future,
  }) : super(key: key);

  final Widget child;

  final Future future;

  @override
  State<StatefulWidget> createState() {
    return _FutureDialogState();
  }
}

class _FutureDialogState extends State<_FutureDialog>
    with WidgetsBindingObserver {
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
    foreground = state == AppLifecycleState.resumed;
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
