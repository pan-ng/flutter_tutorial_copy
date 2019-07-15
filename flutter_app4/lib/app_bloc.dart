import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app4/api/http.dart';
import 'package:flutter_app4/screens/genres/genres_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
  //  print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
   /// print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
  //  print(error);
  }
}

BlocProviderTree createAppBlocProviderTree(Widget app) {
  return BlocProviderTree(
    blocProviders: [
      BlocProvider<GenresBloc>(
        builder: (context) => GenresBloc(genresAPI: GenresAPI()),
      )
    ],
    child: app,
  );
}
