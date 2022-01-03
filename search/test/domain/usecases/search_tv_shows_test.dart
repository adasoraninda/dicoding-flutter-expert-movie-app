import 'package:core/domain/repositories/tv_shows/tv_show_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_tv_shows_test.mocks.dart';

@GenerateMocks([TvShowRepository])
void main() {
  late SearchTvShows usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SearchTvShows(mockTvShowRepository);
  });

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
