import "package:flutter/material.dart";
import 'package:flutter_app3/app_screens/home.dart';

void main() => runApp(MaterialApp(
    title: "Exploring UI widget",
    home: Scaffold(
        appBar: AppBar(
          title: Text("Long List"),
        ),
        floatingActionButton: FloatingActionButton(
            tooltip: "Add one more item",
            child: Icon(Icons.add),
            onPressed: () {
              debugPrint("FAB  print");
            }),
        body: getListView())));

void showSnackBar(BuildContext context, Text msgText,
    {String actionLabel, Function action}) {
  Scaffold.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: msgText,
      action: (actionLabel != null)
          ? SnackBarAction(
              label: actionLabel,
              onPressed: () {
                action?.call();
              },
            )
          : null,
    ));
}

List<String> getListElements() {
  var item = List<String>.generate(50, (counter) => "Item ${counter}");
  return item;
}

Widget getListView() {
  var listItems = getListElements();
  var _scrollController = ScrollController();

 
  var listView = ListView.builder(
      controller: _scrollController,
      itemCount: listItems.length,
      itemBuilder: (context, index) {
        debugPrint("building for index=${index}");
        var listItemLayout = ListTile(
          leading: Icon(Icons.landscape),
          subtitle: Text("Nice view!"),
          title: Text(listItems[index]),
          onTap: () {
            showSnackBar(context, Text(listItems[index]), actionLabel: null,
                action: () {
              debugPrint("Snackbar OK");
            });
            debugPrint("${listItems[index]} tapped");
          },
        );

        return listItemLayout;
      });


  _scrollController.addListener(() {
    var sc = _scrollController;
    if (sc.offset >= sc.position.maxScrollExtent && !sc.position.outOfRange) {
      debugPrint("reached the bottom");
    }
    if (sc.offset <= sc.position.minScrollExtent && !sc.position.outOfRange) {
      debugPrint("reached the top");
    }
  });

  return listView;
}
//
//
//Widget getListView() {
//  return ListView(
//    children: <Widget>[
//      ListTile(
//        leading: Icon(Icons.landscape),
//        title: Text("Landscape"),
//        subtitle: Text("Nice view!"),
//        trailing: Icon(Icons.wb_sunny),
//        onTap: () {
//          debugPrint("clicked");
//        },
//      ),
//      ListTile(
//        leading: Icon(Icons.desktop_mac),
//        title: Text("Mac"),
//        onTap: () {
//          debugPrint("clicked");
//        },
//      ),
//      ListTile(
//        leading: Icon(Icons.phone_iphone),
//        title: Text("iPhone"),
//        onTap: () {
//          debugPrint("clicked");
//        },
//      ),
//      Text("..."),
//      Container(
//        color: Colors.purple,
//        height: 54,
//      )
//    ],
//  );
//}
