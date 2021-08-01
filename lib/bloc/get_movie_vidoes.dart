import 'package:flutter/material.dart';
import 'package:movies/model/video_response.dart';
import 'package:movies/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieVideosBloc{
  final MovieRepository _movieRepository = MovieRepository();
  final BehaviorSubject<VideoResponse> _subject = BehaviorSubject<VideoResponse>();

  getMovieVideo(int id) async {
    VideoResponse response = await _movieRepository.getMovieVideos(id);
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

  BehaviorSubject<VideoResponse> get subject => _subject;
}

final movieVideosBloc = MovieVideosBloc();