import 'package:flutter/material.dart';
import 'package:flutter_app4/meta/meta.dart';
import 'package:flutter_app4/model/note.dart';
import 'package:flutter_app4/screens/test_textfield.dart';
import 'package:flutter_app4/utils/db.dart';

import '../exception.dart';
import '../main.dart';
import '../res.dart';

class NoteDetail extends StatefulWidget {
  final bool addMode;
  final Note note;

  NoteDetail(this.note, this.addMode);

  @override
  State<StatefulWidget> createState() {
    return _NoteDetailState(this.note ?? Note('', 0, 0, Priority.normal.id), this.addMode);
  }
}

class _NoteDetailState extends State<NoteDetail> {
  bool addMode;

  // not null
  Note note;

  DatabaseHelper dbHelper = DatabaseHelper();

  _NoteDetailState(this.note, this.addMode);

  /// the [Text] used for [AppBar]
  Text _appBarTitle() {
    return Text(addMode ? R.string.titleAddNote(context) : R.string.titleNoteDetail(context));
  }

  Priority get notePriority => Priority.findById(note.priority);

  set notePriority(Priority value) {
    note.priority = value.id;
  }

  TextEditingController titleTEC = TextEditingController();
  TextEditingController descriptionTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = R.style.textfieldStyle(context);

    titleTEC.text = note.title;
    descriptionTEC.text = note.description;

    InputDecoration inputDecoration(String label, String hint) => InputDecoration(labelText: label, hintText: hint);

    var scaffold;
    final appBar = AppBar(
      title: _appBarTitle(),
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            goBack();
          }),
    );

    final topRow = Row(children: <Widget>[
      notePriority.createIcon(),
      Container(
        width: R.dimen.margin * 3,
      ),
      Expanded(
        child: DropdownButton(
          icon: Icon(Icons.keyboard_arrow_down),
          style: textStyle,
          value: notePriority,
          items: Priority.asMap.entries.map((entry) {
            return DropdownMenuItem<Priority>(
              value: entry.value,
              child: Text(entry.value.displayString(context)),
            );
          }).toList(),
          onChanged: (selectedPriority) {
            setState(() {
              notePriority = selectedPriority;
            });
          },
        ),
      )
    ]);

    final titleRow = Padding(
        padding: R.dimen.margins(t: 2),
        child: TextField(
          keyboardAppearance: Theme.of(context).brightness,
          style: textStyle,
          controller: titleTEC,
          onChanged: (value) {
            setState(() {
              note.title = titleTEC.text;
            });
          },
          decoration: inputDecoration(R.string.labelNoteTitle(context), R.string.hintNoteTitle(context)),
        ));

    final descriptionRow = Padding(
        padding: R.dimen.margins(t: 2),
        child: TextField(
          keyboardAppearance: Theme.of(context).brightness,
          minLines: 4,
          maxLines: 10000,
          style: textStyle,
          controller: descriptionTEC,
          onChanged: (value) {
            setState(() {
              note.description = descriptionTEC.text;
            });
          },
          decoration: inputDecoration(R.string.labelNoteDescription(context), R.string.hintNoteDescription(context)),
        ));

    final buttonsRow = Padding(
        padding: R.dimen.margins(t: 2),
        child: Row(
          children: <Widget>[
            Expanded(
                child: RaisedButton(
              padding: R.dimen.margins(all: 2),
              color: R.color.buttonColor,
              textColor: R.color.buttonTextColor,
              onPressed: () {
                _save();
              },
              child: Text(R.string.save(context), style: R.style.raisedButtonTextStyle(context)),
            )),
//            Container(
//              width: R.dimen.margin * 2,
//            ),
//            Expanded(
//                child: RaisedButton(
//              padding: R.dimen.margins(all: 2),
//              color: R.color.buttonColor,
//              textColor: R.color.buttonTextColor,
//              onPressed: () {
//                _launchAgain();
//              },
//              child: Text(R.string2.testAction1, style: R.style.raisedButtonTextStyle(context)),
//            )),
            Container(
              width: R.dimen.margin * 2,
            ),
            Expanded(
                child: RaisedButton(
              padding: R.dimen.margins(all: 2),
              color: R.color.buttonColor,
              textColor: R.color.buttonTextColor,
              onPressed: () {
                _delete();
              },
              child: Text(R.string.delete(context), style: R.style.raisedButtonTextStyle(context)),
            ))
          ],
        ));

    final scaffoldBody = Builder(builder: (scaffoldContext) {
      return Padding(
        padding: EdgeInsets.all(R.dimen.margin * 2),
        child: Padding(
            padding: R.dimen.margins(all: 1),
            child: ListView(
              children: <Widget>[topRow, titleRow, descriptionRow, buttonsRow],
            )),
      );
    });

    scaffold = Scaffold(appBar: appBar, body: scaffoldBody);

    return WillPopScope(onWillPop: goBack, child: scaffold);
  }

  Future<bool> goBack({WidgetExtras result}) async {
    Navigator.pop(context, result);
  }

  void _launchAgain() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TestTextFieldPage();
    }));
  }

  void _save() async {
    int dbResult;
    if (addMode) {
      note.createdAt = DateTime.now().millisecondsSinceEpoch;
      dbResult = await dbHelper.insert(note);
    } else {
      note.updatedAt = DateTime.now().millisecondsSinceEpoch;
      dbResult = await dbHelper.update(note);
    }

    WidgetExtras result;
    if (dbResult != 0) {
      result = WidgetExtras(WidgetResult.ok)..msg = "Note saved";
    } else {
      var msg = "Error saving note ${dbResult}";
      result = WidgetExtras(WidgetResult.cancel)
        ..error = AppException(msg)
        ..msg = msg;
    }
    goBack(result: result);
  }

  void _delete() async {
    WidgetExtras result;

    if (note.id == null) {
      String msg = "Note was deleted";
      result = WidgetExtras(WidgetResult.ok)
        ..error = AppException(msg)
        ..msg = msg;
    } else {
      int dbResult = await dbHelper.delete(note);
      if (dbResult != 0) {
        result = WidgetExtras(WidgetResult.ok)..msg = "Note deleted";
      } else {
        var msg = "Error deleting note ${dbResult}";
        result = WidgetExtras(WidgetResult.cancel)
          ..error = AppException(msg)
          ..msg = msg;
      }
    }
    goBack(result: result);
  }
}

//  void _showAlertDialog(String title, String msg) {
//    AlertDialog alertDialog = AlertDialog(
//      title: Text(title),
//      content: Text(msg),
//    );
//
//    showDialog(context: context, builder: (_) => alertDialog);
//  }
//  void _showAlertDialog(BuildContext context, String title, String msg) {
//    showSnackBarMsg(context, msg);
//  }
//}
