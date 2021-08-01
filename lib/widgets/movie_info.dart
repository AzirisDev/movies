import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/bloc/get_movie_detail.dart';
import 'package:movies/model/movie_detail.dart';
import 'package:movies/model/movie_detail_response.dart';
import 'package:movies/style/theme.dart' as Style;
import 'package:movies/widgets/error_widget.dart';
import 'package:movies/widgets/loading_widget.dart';

class MovieInfo extends StatefulWidget {
  final int id;

  const MovieInfo({Key key, this.id}) : super(key: key);

  @override
  _MovieInfoState createState() => _MovieInfoState(id);
}

class _MovieInfoState extends State<MovieInfo> {
  final int id;

  _MovieInfoState(this.id);

  @override
  void initState() {
    super.initState();
    movieDetailBloc.getMovieDetail(id);
  }

  @override
  void dispose() {
    super.dispose();
    movieDetailBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieDetailResponse>(
      stream: movieDetailBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.isNotEmpty) {
            return CustomErrorWidget(error: snapshot.data.error,);
          }
          return _buildInfoWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return CustomErrorWidget(error: snapshot.data.error,);
        } else {
          return CustomLoadingWidget();
        }
      },
    );
  }

  Widget _buildInfoWidget(MovieDetailResponse data) {
    MovieDetail movieDetail = data.movieDetail;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'BUDGET',
                    style: TextStyle(
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    movieDetail.budget.toString() + '\$',
                    style: const TextStyle(
                      color: Style.Colors.secondColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DURATION',
                    style: TextStyle(
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    movieDetail.runTime.toString() + ' min',
                    style: const TextStyle(
                      color: Style.Colors.secondColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'REALISE DATE',
                    style: TextStyle(
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    movieDetail.releaseDate,
                    style: const TextStyle(
                      color: Style.Colors.secondColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GENRES',
                style: TextStyle(
                  color: Style.Colors.titleColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                height: 30,
                padding: EdgeInsets.only(
                  right: 5,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movieDetail.genres.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: 5,
                        right: 10,
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.white,
                          ),
                        ),
                        child: Text(
                          movieDetail.genres[index].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
