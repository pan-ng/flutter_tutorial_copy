import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app4/res.dart';
import 'package:flutter_app4/utils/date_time.dart';

class TestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TestScreenState();
}

class TestScreenState extends State<TestScreen> {
  static const defaultMethodChannel = const MethodChannel('pan.flutter.dev/default_method_channel');

  String message = 'No result yet';

  Future<int> random() async {
    return await DateTime.now().millisecondsSinceEpoch % 1000;
  }

  Future<void> _getDebugMsg() async {
    String msg;
    try {
      final channel = defaultMethodChannel;
      channel.setMethodCallHandler((methodCall) {
        switch (methodCall.method) {
          case "getDartNumber":
            {
              return random();
            }
          default:
            {
              return null;
            }
        }
      });

      msg =
          await channel.invokeMethod("getDebugMsg", {"a": "A", "sent_time": "${now().toString()}"});

      debugPrint("msg = $msg");
    } on PlatformException catch (e) {
      msg = e.message;
    }
    setState(() {
      message = msg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(R.string.titleTestScreen(context))),
      body: ListView(
        padding: R.dimen.margins(all: 5),
        children: <Widget>[
          Text(
            "$message",
            style: TextStyle(fontSize: R.fontSize.textField.px),
          ),
          Container(
            padding: R.dimen.margins(t: 2.0),
          ),
          R.style.createTextRaisedButton(context, R.string.debugTestAction1(context), () {
            debugPrint("Do some test action here");
            _getDebugMsg();
          })
        ],
      ),
    );
  }
}
