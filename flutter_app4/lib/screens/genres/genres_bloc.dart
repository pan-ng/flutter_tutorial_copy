import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app4/api/http.dart';
import 'package:flutter_app4/exception.dart';
import 'package:flutter_app4/model/genre.dart';
import 'package:flutter_app4/model/genres.dart';
import 'package:flutter_app4/model/state.dart';
import 'package:flutter_app4/res.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  @override
  GenresState get initialState => GenresMessageState(R.string.retry);

  final GenresAPI genresAPI;

  GenresBloc({@required this.genresAPI});

  @override
  Stream<GenresState> mapEventToState(GenresEvent event) async* {
    print("mapEventToState : ${event}");
    if (event is OnBuild || event is OnRefresh) {
      yield* _loadGenre(currentState);
    } else {
      yield currentState;
    }
  }

  Stream<GenresState> _loadGenre(GenresState state) async* {
    try {
      print("_loadGenre : loading");
      yield GenresLoadingState();
    //  print("_loadGenre : wait 2 sec");
     // await Future.delayed(Duration(seconds: 2));
      print("_loadGenre : getGenres");
      var genres = await genresAPI.getGenres();

      print("_loadGenre : visible");
      yield GenresVisibleState(genres);

    } catch (e) {
      print("_loadGenre : error");
      if(e is AppException) {
        yield GenresMessageState((context, [args]) {
          return e.displayMessage(context: context);
        });
      }
    }
  }
}

class GenresState {}

class GenresLoadingState extends GenresState implements BlocLoadingState {
  int id;
  GenresLoadingState(){
    id = Random().nextInt(1000000);
  }

  @override
  String toString() {
    return "GenresLoadingState:${id.toString()}";
  }
}

class GenresMessageState extends GenresState implements BlocMessageState {
  final ContextString message;

  GenresMessageState(this.message);

  @override
  String displayMessage(BuildContext context) {
    return message(context);
  }
}





class GenresVisibleState extends GenresState implements BlockContentState {
  final Genres genres;

  GenresVisibleState(this.genres);

  GenresState copyWith({Genres genres}) {
    return GenresVisibleState(genres ?? this.genres);
  }
}

class GenresEvent {}

class OnBuild extends GenresEvent {}

class OnRefresh extends GenresEvent {}
