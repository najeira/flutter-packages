import 'package:flutter/material.dart';

import 'package:dialog/dialog.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Examples"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              child: new RaisedButton(
                child: new Text("Timer dialog"),
                onPressed: () {
                  showDialogEx(
                    context: context,
                    child: new Dialog(
                      child: new Text("Hello!"),
                    ),
                    timeout: const Duration(seconds: 3),
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
