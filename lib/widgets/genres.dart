import 'package:flutter/material.dart';
import 'package:movies/bloc/get_genres_bloc.dart';
import 'package:movies/model/genre.dart';
import 'package:movies/model/genre_response.dart';
import 'package:movies/widgets/error_widget.dart';
import 'package:movies/widgets/genres_list.dart';
import 'package:movies/widgets/loading_widget.dart';

class Genres extends StatefulWidget {
  const Genres({Key key}) : super(key: key);

  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> {

  @override
  void initState() {
    super.initState();
    genresBloc.getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreResponse>(
      stream: genresBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return CustomErrorWidget(error: snapshot.data.error,);
          }
          return _buildGenreWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return CustomErrorWidget(error: snapshot.data.error,);
        } else {
          return CustomLoadingWidget();
        }
      },
    );
  }

  Widget _buildGenreWidget(GenreResponse data){
    List<Genre> genres = data.genres;
    if(genres.isEmpty){
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('No genres'),
          ],
        ),
      );
    } else {
      return GenresList(genres: genres,);
    }
  }
}
