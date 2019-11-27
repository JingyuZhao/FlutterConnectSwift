import 'package:flutter/material.dart';
import 'dart:ui' as UI;

import 'package:flutter/services.dart';

void main() => runApp(_findWidget());
Widget _findWidget() {
  print(UI.window.defaultRouteName);
  if (UI.window.defaultRouteName == "/") {
    return MyApp();
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  static const methodChannel = MethodChannel("com.flutterConnectApp.method");
  static const eventChannel = EventChannel("com.flutterConnectApp.event");

  var appSendInfo = "";
  void _incrementCounter() async {
    var info = await methodChannel.invokeMethod("callFlutter");
    setState(() {
      _counter++;
      appSendInfo = info;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventChannel.receiveBroadcastStream().listen((data) {
      setState(() {
        appSendInfo = data.toString();
      });
    }, onDone: () {
      print("Done");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(appSendInfo),
            RaisedButton(
              child: Text("CallIosApp"),
              onPressed: () async {
                var callBack = await methodChannel
                    .invokeMethod("goTestVC", {"title": "Test1VC"});
                print("callBack:$callBack");
                setState(() {
                  appSendInfo = callBack;
                });
              },
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
