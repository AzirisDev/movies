import 'package:movies/model/genre_response.dart';
import 'package:movies/model/movie_response.dart';
import 'package:movies/model/person_response.dart';
import 'package:movies/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class PeopleBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<PersonResponse> _subject = BehaviorSubject<PersonResponse>();

  getPeople() async{
    PersonResponse response = await _repository.getPeople();
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject => _subject;
}

final peopleBloc = PeopleBloc();