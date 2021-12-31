import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_shows/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_shows/search_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvShows usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SearchTvShows(mockTvShowRepository);
  });

  final tTvShow = <TvShow>[];
  final tQuery = 'Spiderman';

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTvShowRepository.searchTvShows(tQuery))
        .thenAnswer((_) async => Right(tTvShow));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvShow));
  });
}