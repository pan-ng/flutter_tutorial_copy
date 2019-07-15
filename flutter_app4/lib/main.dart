import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app4/pref.dart';
import 'package:flutter_app4/screens/genres/genres_screen.dart';
import 'package:flutter_app4/screens/test_screen.dart';
import 'package:flutter_app4/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import './res.dart';
import './screens/note_list.dart';
import 'generated/i18n.dart';
import 'package:flutter/services.dart';

import 'package:bloc/bloc.dart';

//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
Prefs prefs;

Future<void> main() async {
  final ssp = await StreamingSharedPreferences.instance;
  prefs = Prefs("notes", ssp);
  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
//  Crashlytics.instance.enableInDevMode = true;
//
//  // Pass all uncaught errors to Crashlytics.
//  FlutterError.onError = (FlutterErrorDetails details) {
//    Crashlytics.instance.onError(details);
//  };
  BlocSupervisor.delegate = SimpleBlocDelegate();

  return runApp(createAppBlocProviderTree(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    BlocProvider.of<AppBloc>(context).dispatch(AppEventInitialize());

    return MaterialApp(
      locale: Locale("en"),
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      debugShowCheckedModeBanner: false,
      title: "Notes",
      onGenerateTitle: (BuildContext context) => R.string.appName(context),
      theme: R.style.appTheme(),
      home: GenresPage(BlocProvider.of<AppBloc>(context)),
      //  home: NoteList(),
    );
  }
}

showSnackBarMsg(BuildContext context, String msg) {
  Scaffold.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
        backgroundColor: R.color.snackBarBackgroundColor, content: Text(msg)));
}

enum WidgetResult { ok, cancel }

class WidgetExtras {
  final WidgetResult result;

  WidgetExtras(this.result);

  String msg;
  Exception error;
}
