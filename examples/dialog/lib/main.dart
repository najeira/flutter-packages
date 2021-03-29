import 'dart:async';

import 'package:flutter/material.dart';

import 'package:dialog/dialog.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Examples"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RaisedButton(
                child: const Text("Timer dialog"),
                onPressed: () {
                  showTimerDialog(
                    context: context,
                    builder: (BuildContext context) => const SimpleDialog(
                      children: [
                        Center(child: Text("Hello!")),
                      ],
                    ),
                    duration: const Duration(seconds: 3),
                  );
                },
              ),
            ),
            Container(
              child: RaisedButton(
                child: const Text("Future dialog"),
                onPressed: () {
                  showFutureDialog(
                    context: context,
                    builder: (BuildContext context) => const SimpleDialog(
                      children: [
                        Center(child: Text("Hello!")),
                      ],
                    ),
                    future: Future<void>.delayed(const Duration(seconds: 3)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
