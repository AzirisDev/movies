import 'package:movies/model/genre_response.dart';
import 'package:movies/model/movie_response.dart';
import 'package:movies/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  getNowPlaying() async{
    MovieResponse response = await _repository.getPlayingMovies();
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final nowPlayingBloc = NowPlayingBloc();