import 'package:dio/dio.dart';
import 'package:movies/model/cast_response.dart';
import 'package:movies/model/genre_response.dart';
import 'package:movies/model/movie_detail_response.dart';
import 'package:movies/model/movie_response.dart';
import 'package:movies/model/person_response.dart';
import 'package:movies/model/video_response.dart';

class MovieRepository{
  final String apiKey = '78d3123629506c2fd18aea6a5d3f65a8';
  static String mainUrl = 'https://api.themoviedb.org/3';
  final Dio _dio = Dio();
  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = '$mainUrl/genre/movie/list';
  var getPeopleUrl = '$mainUrl/trending/person/week';
  var movieUrl = '$mainUrl/movie';

  Future<MovieResponse> getMovies() async {
    var params = {
      'api_key' : apiKey,
      'language' : 'en_US',
      'page' : 1,
    };
    try{
      Response response = await _dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch(e){
      print('Exception occured: $e');
      return MovieResponse.withError(e.toString());
    }
  }

  Future<MovieResponse> getPlayingMovies() async {
    var params = {
      'api_key' : apiKey,
      'language' : 'en_US',
      'page' : 1,
    };
    try{
      Response response = await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch(e){
      print('Exception occured: $e');
      return MovieResponse.withError(e.toString());
    }
  }

  Future<GenreResponse> getGenres() async {
    var params = {
      'api_key' : apiKey,
      'language' : 'en_US',
      'page' : 1,
    };
    try{
      Response response = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch(e){
      print('Exception occured: $e');
      return GenreResponse.withError(e.toString());
    }
  }

  Future<PersonResponse> getPeople() async {
    var params = {
      'api_key' : apiKey,
    };
    try{
      Response response = await _dio.get(getPeopleUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch(e){
      print('Exception occured: $e');
      return PersonResponse.withError(e.toString());
    }
  }

  Future<MovieResponse> getMovieByGenre(int id) async {
    var params = {
      'api_key' : apiKey,
      'language' : 'en_US',
      'page' : 1,
      'with_genres' : id,
    };
    try{
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch(e){
      print('Exception occured: $e');
      return MovieResponse.withError(e.toString());
    }
  }

  Future<MovieDetailResponse> getMovieDetail(int id) async {
    var params = {
      'api_key' : apiKey,
      'language' : 'en_US',
    };
    try{
      Response response = await _dio.get(movieUrl + '/$id', queryParameters: params);
      return MovieDetailResponse.fromJson(response.data);
    } catch(e){
      print('Exception occured: $e');
      return MovieDetailResponse.withError(e.toString());
    }
  }

  Future<CastResponse> getCasts(int id) async {
    var params = {
      'api_key' : apiKey,
      'language' : 'en_US',
    };
    try{
      Response response = await _dio.get(movieUrl + '/$id' + '/credits', queryParameters: params);
      return CastResponse.fromJson(response.data);
    } catch(e){
      print('Exception occured: $e');
      return CastResponse.withError(e.toString());
    }
  }

  Future<MovieResponse> getSimilarMovies(int id) async {
    var params = {
      'api_key' : apiKey,
      'language' : 'en_US',
    };
    try{
      Response response = await _dio.get(movieUrl + '/$id' + '/similar', queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch(e){
      print('Exception occured: $e');
      return MovieResponse.withError(e.toString());
    }
  }

  Future<VideoResponse> getMovieVideos(int id) async {
    var params = {
      'api_key' : apiKey,
      'language' : 'en_US',
    };
    try{
      Response response = await _dio.get(movieUrl + '/$id' + '/videos', queryParameters: params);
      return VideoResponse.fromJson(response.data);
    } catch(e){
      print('Exception occured: $e');
      return VideoResponse.withError(e.toString());
    }
  }
}