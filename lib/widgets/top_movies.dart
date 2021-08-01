import 'package:flutter/material.dart';
import 'package:movies/bloc/get_movies_bloc.dart';
import 'package:movies/model/movie_response.dart';
import 'package:movies/style/theme.dart' as Style;
import 'package:movies/widgets/error_widget.dart';
import 'package:movies/widgets/loading_widget.dart';
import 'package:movies/widgets/movies_list_with_rating.dart';

class TopMovies extends StatefulWidget {
  const TopMovies({Key key}) : super(key: key);

  @override
  _TopMoviesState createState() => _TopMoviesState();
}

class _TopMoviesState extends State<TopMovies> {

  @override
  void initState() {
    super.initState();
    moviesBloc.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 20),
          child: Text(
            'TRENDING MOVIES ON THIS WEEK',
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
          stream: moviesBloc.subject.stream,
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
