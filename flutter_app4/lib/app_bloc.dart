import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app4/api/http.dart';
import 'package:flutter_app4/screens/genres/genres_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/genres.dart';

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
      BlocProvider<AppBloc>(
        builder: (context) => AppBloc(),
      )
    ],
    child: app,
  );
}

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc();

  @override
  AppState get initialState => AppState();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {

    print("AppBloc:mapEventToState ${event}");


    if (event is AppEventNewData) {

      yield currentState.copyWith(genres: event.genres);
    } else {
      yield currentState;
    }
  }
}

class AppEvent {}

class AppEventInitialize extends AppEvent {}

class AppEventNewData extends AppEvent {
  Genres genres;

  AppEventNewData({Genres genres});
}

class AppState {
  Genres genres;

  AppState copyWith({Genres genres}) {
    return AppState()..genres = genres;
  }
}
