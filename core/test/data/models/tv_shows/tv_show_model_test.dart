import 'package:core/data/models/tv_shows/tv_show_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  test('should be a subclass of Tv Show entity', () async {
    final result = tTvShowModel.toEntity();
    expect(result, tTvShow);
  });

  test('should be a subclass of Map json', () async {
    final result = tTvShowModel.toJson();
    expect(result, tTvShowModelMap);
  });

  test('should be a subclass of Tv Show Model', () async {
    final result = TvShowModel.fromJson(tTvShowModelMap);
    expect(result, tTvShowModel);
  });
}
