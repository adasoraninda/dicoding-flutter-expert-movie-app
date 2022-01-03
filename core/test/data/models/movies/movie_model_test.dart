import 'package:core/data/models/movies/movie_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  test('should be a subclass of Movie entity', () async {
    final result = tMovieModel.toEntity();
    expect(result, tMovie);
  });

  test('should be a subclass of Map json', () async {
    final result = tMovieModel.toJson();
    expect(result, tMovieModelMap);
  });

  test('should be a subclass of Movie Model', () async {
    final result = MovieModel.fromJson(tMovieModelMap);
    expect(result, tMovieModel);
  });
}
