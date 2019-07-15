import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app4/api/http.dart';
import 'package:flutter_app4/app_bloc.dart';
import 'package:flutter_app4/model/genres.dart';
import 'package:flutter_app4/res.dart';
import 'package:flutter_app4/screens/genres/genres_bloc.dart';
import 'package:flutter_app4/utils/date_time.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

class GenresPage extends StatefulWidget {
  final AppBloc appBloc;

  GenresPage(this.appBloc);

  @override
  State<StatefulWidget> createState() => GenresPageState();
}

class GenresPageState extends State<GenresPage> {
  GenresBloc _genresBloc;
  int id;

  @override
  void initState() {
    id = Random().nextInt(100000);
    _genresBloc = GenresBloc(appBloc: widget.appBloc, genresAPI: GenresAPI());
    _genresBloc.dispatch(GenresEventInit());
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
              _genresBloc.dispatch(GenresEventRefresh());
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
          if (genreState is GenresStateLoading) {
            return _buildLoadingGenres(context);
          } else if (genreState is GenresStateError) {
            return _buildGenresLoadError(context, genreState);
          } else if (genreState is GenresStateContent) {
            return _buildListGenres(context, genreState.genres);
          } else {
            return _buildLoadingGenres(context);
          }
        });
  }

  Widget _buildListGenres(BuildContext context, Genres genres) {
    if (genres == null) {
      return _buildReloadGenres(context, "No data, tap to reload");
    } else {
      return Text(
        "${genres.pop.name.en}",
        style: TextStyle(fontSize: R.fontSize.textField.px),
      );
    }
  }

  Widget _buildLoadingGenres(BuildContext context) {
    return Text(
      "Loading...",
      style: TextStyle(fontSize: R.fontSize.textField.px),
    );
  }

  Widget _buildGenresLoadError(BuildContext context, GenresStateError errorState) {
    return _buildReloadGenres(context, errorState.displayMessage(context));
  }

  Widget _buildReloadGenres(BuildContext context, String message) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              message,
              style: TextStyle(fontSize: R.fontSize.textField.px),
            ),
            SizedBox(height: R.dimen.margin),
            R.style.createTextRaisedButton(context, R.string.retry(context), () {
              _genresBloc.dispatch(GenresEventRefresh());
            })
          ],
        ),
      ),
    );
  }
}
