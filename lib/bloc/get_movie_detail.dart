import 'package:flutter/material.dart';
import 'package:movies/model/movie_detail_response.dart';
import 'package:movies/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc{
  final MovieRepository _movieRepository = MovieRepository();
  final BehaviorSubject<MovieDetailResponse> _subject = BehaviorSubject<MovieDetailResponse>();

  getMovieDetail(int id) async {
    MovieDetailResponse response = await _movieRepository.getMovieDetail(id);
    _subject.sink.add(response);
  }

  void drainStream(){
    _subject.value = null;
  }
  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieDetailResponse> get subject => _subject;
}

final movieDetailBloc = MovieDetailBloc();