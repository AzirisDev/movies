import 'package:flutter/material.dart';
import 'package:movies/bloc/get_movies_by_genre_bloc.dart';
import 'package:movies/model/movie_response.dart';
import 'package:movies/widgets/error_widget.dart';
import 'package:movies/widgets/loading_widget.dart';
import 'package:movies/widgets/movies_list_with_rating.dart';

class GenreMovies extends StatefulWidget {
  final int genreId;

  const GenreMovies({Key key, this.genreId}) : super(key: key);

  @override
  _GenreMoviesState createState() => _GenreMoviesState(genreId);
}

class _GenreMoviesState extends State<GenreMovies> {
  final int genreId;

  _GenreMoviesState(this.genreId);

  @override
  void initState() {
    super.initState();
    movieListByGenreBloc.getMoviesByGenre(genreId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: movieListByGenreBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.isNotEmpty) {
            return CustomErrorWidget(error: snapshot.data.error,);
          }
          return MovieListWithRatings(data: snapshot.data,);
        } else if (snapshot.hasError) {
          return CustomErrorWidget(error: snapshot.data.error,);
        } else {
          return const CustomLoadingWidget();
        }
      },
    );
  }
}
