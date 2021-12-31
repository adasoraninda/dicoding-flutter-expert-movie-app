import 'package:ditonton/data/models/tv_shows/tv_show_model.dart';
import 'package:ditonton/domain/entities/tv_shows/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvShowModel = TvShowModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvShow = TvShow(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvShowMap = {
    "backdrop_path": 'backdropPath',
    "genre_ids": [1, 2, 3],
    "id": 1,
    "original_name": 'originalName',
    "overview": 'overview',
    "popularity": 1,
    "poster_path": 'posterPath',
    "first_air_date": 'firstAirDate',
    "name": 'name',
    "vote_average": 1,
    "vote_count": 1,
  };

  test('should be a subclass of Tv Show entity', () async {
    final result = tTvShowModel.toEntity();
    expect(result, tTvShow);
  });

  test('should be a subclass of Map json', () async {
    final result = tTvShowModel.toJson();
    expect(result, tTvShowMap);
  });

  test('should be a subclass of Tv Show Model', () async {
    final result = TvShowModel.fromJson(tTvShowMap);
    expect(result, tTvShowModel);
  });
}
