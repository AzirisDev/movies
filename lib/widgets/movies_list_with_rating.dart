import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/model/movie_detail.dart';
import 'package:movies/model/movie_response.dart';
import 'package:movies/screens/detail.dart';
import 'package:movies/style/theme.dart' as Style;

class MovieListWithRatings extends StatelessWidget {
  final MovieResponse data;
  const MovieListWithRatings({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Movie> movies = data.movies;
    if (movies.isEmpty) {
      return const Center(
        child: Text('No movies'),
      );
    } else {
      return Container(
        height: 270,
        padding: const EdgeInsets.only(left: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(movie: movies[index],)
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (movies[index].poster == null) Container(
                      width: 120,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Style.Colors.secondColor,
                        borderRadius: BorderRadius.circular(2.0),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            EvaIcons.filmOutline,
                            color: Colors.white,
                            size: 50,
                          ),
                        ],
                      ),
                    ) else Container(
                      width: 120,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w200/' +
                                  movies[index].poster),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        movies[index].title,
                        maxLines: 2,
                        style: const TextStyle(
                          height: 1.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Text(
                          movies[index].rating.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        RatingBar.builder(
                            unratedColor: Colors.white,
                            itemSize: 8.0,
                            initialRating: movies[index].rating / 2,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => const Icon(
                              EvaIcons.star,
                              color: Style.Colors.secondColor,
                            ),
                            onRatingUpdate: (e) {}),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
