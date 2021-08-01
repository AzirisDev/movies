import 'dart:ffi';

import 'package:movies/model/movie_detail.dart';

class MovieDetailResponse {
  final MovieDetail movieDetail;
  final error;

  MovieDetailResponse(this.movieDetail, this.error);

  MovieDetailResponse.fromJson(Map<String, dynamic> json)
      : movieDetail = MovieDetail.fromJson(json),
        error = '';

  MovieDetailResponse.withError(String errorValue)
      : movieDetail = null,
        error = errorValue;
}
