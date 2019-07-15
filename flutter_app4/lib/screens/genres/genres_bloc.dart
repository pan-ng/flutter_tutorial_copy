import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app4/api/http.dart';
import 'package:flutter_app4/app_bloc.dart';
import 'package:flutter_app4/exception.dart';
import 'package:flutter_app4/model/genre.dart';
import 'package:flutter_app4/model/genres.dart';
import 'package:flutter_app4/res.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  @override
  GenresState get initialState => GenresStateContent(appBloc.currentState.genres);

  final GenresAPI genresAPI;
  final AppBloc appBloc;

  GenresBloc({@required this.appBloc, @required this.genresAPI});

  @override
  Stream<GenresState> mapEventToState(GenresEvent event) async* {
//    if(currentState is GenresStateContent){
//      GenresStateContent state = currentState;
//      print("mapEventToState : already has data, ${state.genres?.pop?.name?.en}");
//    }
    print("mapEventToState : currentState = ${currentState} ${event}");
    if (event is GenresEventInit || event is GenresEventRefresh) {
      yield* _loadGenre(currentState);
    } else {
      yield currentState;
    }
  }

  Stream<GenresState> _loadGenre(GenresState state) async* {
    try {
      print("_loadGenre : loading ");
      yield GenresStateLoading();
      //  print("_loadGenre : wait 2 sec");
      // await Future.delayed(Duration(seconds: 2));
      print("_loadGenre : getGenres");
      var genres = await genresAPI.getGenres();

      print("_loadGenre : visible");
      yield GenresStateContent(genres);

      appBloc.dispatch(AppEventNewData(genres: genres));
    } catch (e) {
      print("_loadGenre : error $e");
      if (e is AppException) {
        yield GenresStateError(e);
      }
    }
  }
}

class GenresState {}

class GenresStateLoading extends GenresState {
  int id;

  GenresStateLoading() {
    id = Random().nextInt(1000000);
  }

  @override
  String toString() {
    return "GenresLoadingState:${id.toString()}";
  }
}

class GenresStateError extends GenresState {
  final AppException exception;

  GenresStateError(this.exception);

  @override
  String displayMessage(BuildContext context) {
    return exception.displayMessage(context: context);
  }
}

class GenresStateContent extends GenresState {
  final Genres genres;

  GenresStateContent(this.genres);

  GenresState copyWith({Genres genres}) {
    return GenresStateContent(genres ?? this.genres);
  }
}

class GenresEvent {}

class GenresEventInit extends GenresEvent {}

class GenresEventRefresh extends GenresEvent {}
