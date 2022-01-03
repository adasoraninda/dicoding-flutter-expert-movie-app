import 'package:core/data/models/tv_shows/tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = tTvShowListMap;
      // act
      final result = TvShowResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvShowResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = tTvShowListMap;
      // act
      final result = tTvShowResponse.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });
}
