import 'package:flutter/material.dart';
import 'package:flutter_app4/api/http.dart';
import 'package:flutter_app4/exception.dart';
import 'package:flutter_app4/meta/meta.dart';
import 'package:flutter_app4/model/note.dart';
import 'package:flutter_app4/screens/note_detail.dart';
import 'package:flutter_app4/utils/db.dart';
import 'package:flutter_app4/utils/json.dart';

import '../main.dart';
import '../res.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    prefs.streams.lastTappedTimeMs.listen((v) {
      debugPrint("lastTappedTimeMs has been changed ${v}");
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(R.string.titleNoteList(context)),
      ),
      body: getListView(),
      floatingActionButton: Builder(builder: (scaffoldContext) {
        return FloatingActionButton(
            tooltip: R.string.tooltipAddFab(context),
            child: Icon(Icons.add),
            onPressed: () {
              prefs.lastTappedTimeMs = 1;
              gotoNoteDetail(scaffoldContext, add: true);
              debugPrint("FAB tabbled");
            });
      }),
    );
  }

  ListView getListView() {
    R.style.appTheme();
    TextStyle listTileTextStyle = R.style.listTileTextStyle(context);

    Note getNoteAt(int pos) => noteList[pos];

    //
    return ListView.builder(
        itemCount: count,
        itemBuilder: (context, pos) {
          Note note = getNoteAt(pos);
          Priority priority = Priority.findById(note.priority);
          return Card(
            margin: R.dimen.margins(l: 2, r: 2, t: (pos == 0 ? 2 : 1), b: (pos == count - 1 ? 2 : 1)),
            color: R.color.cardBackgroundColor,
            elevation: R.dimen.cardElevation,
            child:

            NoteListTile(context, priority, note, (){ delete(context, note); }, (){gotoNoteDetail(context, note: note);}),
//            ListTile(
//              leading: priority.createIcon(),
//              title: Text(note.title, style: listTileTextStyle),
//              subtitle: Text(note.displayDateTimeText),
//              trailing: GestureDetector(
//                  child: Icon(Icons.delete, color: R.color.iconTintColor),
//                  onTap: () {
//                    delete(context, note);
//                  }),
//              onTap: () {
//                gotoNoteDetail(context, note: note);
//              },
//            ),
//

          );
        });
  }

  gotoNoteDetail(BuildContext context, {Note note, bool add = false}) async {
    testApi(context);

    WidgetExtras extras = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, add);
    }));

    if (extras != null) {
      if (extras.result == WidgetResult.ok) {
        updateListView();
      }
      var msg = extras.msg;
      var e = extras.error;
      if (e != null) {
        msg = e.toString();
        if (e is AppException) {
          msg = e.displayMessage(context: context);
        }
      }
      if (msg != null) {
        showSnackBarMsg(context, msg);
      }
    }
  }

  delete(BuildContext context, Note note) async {
    int result = await dbHelper.delete(note);
    if (result != null) {
      showSnackBarMsg(context, "Note deleted!");
    }
    updateListView();
  }

  void updateListView() {
    dbHelper.createDb().then((db) {
      dbHelper.getNoteList().then((notes) {
        setState(() {
          this.noteList = notes;
          this.count = notes.length;
        });
      });
    });
  }

  void testApi(BuildContext context) async {
    print("testApi: begin");
    try {
      print("testApi: before call");
      var genres = await GenresAPI().getGenres();
      print("testApi: after call");
      print(Json.toJsonString(genres));
    } on AppException catch (e) {
      showSnackBarMsg(context, e.displayMessage(context: context));
    } catch (e, st) {
      print(st);
    }
    print("testApi: end");
  }
}

class NoteListTile extends ListTile {
  NoteListTile(BuildContext context, Priority priority, Note note, onTrailingTap(), onTileTap())
      : super(
            leading: priority.createIcon(),
            title: Text(note.title, style: R.style.listTileTextStyle(context)),
            subtitle: Text(note.displayDateTimeText),
            trailing: GestureDetector(child: Icon(Icons.delete, color: R.color.iconTintColor), onTap: onTrailingTap), onTap : onTileTap);
}
