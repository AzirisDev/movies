import 'package:movies/model/person.dart';

class PersonResponse{
  final List<Person> people;
  final String error;

  PersonResponse(
      this.people,
      this.error,
      );

  PersonResponse.fromJson(Map<String, dynamic> json)
      : people = (json['results'] as List)
      .map((e) => Person.fromJson(e))
      .toList(),
        error = '';

  PersonResponse.withError(String errorValue)
      : people = [],
        error = errorValue;
}