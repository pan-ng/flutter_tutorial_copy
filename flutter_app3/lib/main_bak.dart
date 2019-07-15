//
//
//
//
//import 'package:flutter/material.dart';
//import 'package:flutter_app3/res.dart';
//
//void main() {
//  runApp(MaterialApp(
//    title: "state example",
//    home: FavCity(),
//  ));
//}
//
//class FavCity extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => _FavCityState();
//}
//
//class _FavCityState extends State<FavCity> {
//  String cityName = "";
//  String currency = "USD";
//
//
////  String a(String Function(String) callback) {
////
////  }
////
////  String b(String callback(String)) {
////    return callback("a").length.toString();
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    debugPrint("_FavCityState.build 1");
//
//
//
//
//
//
//    return Scaffold(
//        appBar: AppBar(
//            title: Text(
//              "Stateful app example!!",
//            )),
//        body: Container(
//
//          margin: EdgeInsets.all(RDimen.margin*5),
//          child: Column(
//            children: <Widget>[
//              TextField(
//                onSubmitted: (String userInput) {
//                  debugPrint("_FavCityState.TextField.onSubmitted");
//                  setState(() {
//                    cityName = userInput;
//                  });
//                },
//              ),
//              DropdownButton<String>(
//                value: currency,
//                items: RMap.currencies().entries.map((entry) {
//                  return DropdownMenuItem<String>(
//                    value: entry.key,
//                    child: Text(entry.value),
//                  );
//                }).toList(),
//                onChanged: _onCurrencySelected,
//              ),
//              Container(
//                  padding: EdgeInsets.all(RDimen.margin*0),
//                  child: Text(
//                    "Yousr next city is $cityName",
//                    style: TextStyle(fontSize: 20.0),
//                  )),
//            ],
//          ),
//        ));
//  }
//
//  void _onCurrencySelected(String selectedCurrency) {
//    debugPrint("_onCurrencySelected");
//    setState(() {
//      currency = selectedCurrency;
//    });
//  }
//}
