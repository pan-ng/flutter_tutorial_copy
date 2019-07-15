import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app4/api/http.dart';
import 'package:flutter_app4/model/genres.dart';
import 'package:flutter_app4/model/state.dart';
import 'package:flutter_app4/res.dart';
import 'package:flutter_app4/screens/genres/genres_bloc.dart';
import 'package:flutter_app4/utils/date_time.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

class GenresPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GenresPageState();
}

class GenresPageState extends State<GenresPage> {
  GenresBloc _genresBloc;
  int id;

  @override
  void initState() {
    id = Random().nextInt(100000);
    _genresBloc = GenresBloc(genresAPI: GenresAPI());
    _genresBloc.dispatch(OnBuild());
    super.initState();
  }

  @override
  void dispose() {
    print("instance:${id} _buildBody: dispose");
    _genresBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("instance:${id} build");
    return Scaffold(
      appBar: AppBar(title: Text(R.string.genres(context))),
      body: Container(
        child: Column(
          children: <Widget>[
            _buildBody(context),
            R.style.createTextRaisedButton(context, "Reload", () {
              _genresBloc.dispatch(OnRefresh());
            })
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    print("instance:${id} _buildBody");
    final buillderId = Random().nextInt(100000);
    return BlocBuilder(
        bloc: _genresBloc,
        builder: (context, genreState) {
          print("buillderId = ${buillderId} instance:${id} _buildBody: genreState = ${genreState}");
          if (genreState is BlocLoadingState) {
            return _buildLoadingGenres(context);
          } else if (genreState is GenresMessageState) {
            return _buildReloadGenres(context, (context, [args]) {
              return genreState.displayMessage(context);
            });
          } else if (genreState is GenresVisibleState) {
            return _buildListGenres(context, genreState.genres);
          } else {
            return _buildLoadingGenres(context);
          }
        });
  }

  Widget _buildListGenres(BuildContext context, Genres genres) {
    return Text(
      "${genres.toJson().toString()}",
      style: TextStyle(fontSize: R.fontSize.textField.px),
    );
  }

  Widget _buildLoadingGenres(BuildContext context) {
    return Text(
      "Loading...",
      style: TextStyle(fontSize: R.fontSize.textField.px),
    );
  }

  Widget _buildReloadGenres(BuildContext context, ContextString message) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              "${message(context)}",
              style: TextStyle(fontSize: R.fontSize.textField.px),
            ),
            SizedBox(height: R.dimen.margin),
            R.style.createTextRaisedButton(context, R.string.retry(context), () {
              _genresBloc.dispatch(OnRefresh());
            })
          ],
        ),
      ),
    );
  }
}
