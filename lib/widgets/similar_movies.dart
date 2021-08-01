import 'package:flutter/material.dart';
import 'package:movies/bloc/get_similar_movies.dart';
import 'package:movies/model/movie_response.dart';
import 'package:movies/style/theme.dart' as Style;
import 'package:movies/widgets/error_widget.dart';
import 'package:movies/widgets/loading_widget.dart';
import 'package:movies/widgets/movies_list_with_rating.dart';

class SimilarMovies extends StatefulWidget {
  final int id;
  const SimilarMovies({Key key, this.id}) : super(key: key);

  @override
  _SimilarMoviesState createState() => _SimilarMoviesState(id);
}

class _SimilarMoviesState extends State<SimilarMovies> {
  final int id;

  _SimilarMoviesState(this.id);


  @override
  void initState() {
    super.initState();
    similarMoviesBloc.getSimilarMovies(id);
  }

  @override
  void dispose() {
    super.dispose();
    similarMoviesBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            'SIMILAR MOVIES',
            style: TextStyle(
              color: Style.Colors.titleColor,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        StreamBuilder<MovieResponse>(
          stream: similarMoviesBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.isNotEmpty) {
                return CustomErrorWidget(error: snapshot.data.error,);
              }
              return MovieListWithRatings(data: snapshot.data,);
            } else if (snapshot.hasError) {
              return CustomErrorWidget(error: snapshot.data.error,);
            } else {
              return const CustomLoadingWidget();
            }
          },
        )
      ],
    );
  }
}
