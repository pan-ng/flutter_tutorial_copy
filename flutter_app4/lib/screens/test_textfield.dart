import 'package:flutter/material.dart';
import 'package:flutter_app4/res.dart';

class TestTextFieldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: pop,
        child: Scaffold(
            appBar: AppBar(title: Text(R.string.testAction1(context))),
            body: Container(
                child: Padding(
              padding: R.dimen.margins(l: 2, r: 2, t: 10),
              child: Column(
                children: <Widget>[TextField()],
              ),
            ))));
  }

  Future<bool> pop() async {
    return true;
  }
}
