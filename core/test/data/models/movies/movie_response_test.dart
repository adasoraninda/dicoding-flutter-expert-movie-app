import 'package:core/data/models/movies/movie_model.dart';
import 'package:core/data/models/movies/movie_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  const tMovieResponseModel =
      MovieResponse(movieList: <MovieModel>[tMovieModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = tMovieListMap;
      // act
      final result = MovieResponse.fromJson(jsonMap);
      // assert
      expect(result, tMovieResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = tMovieListMap;
      // act
      final result = tMovieResponseModel.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });
}
