import 'package:core/domain/usecases/tv_shows/save_watchlist_tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvShow usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SaveWatchlistTvShow(mockTvShowRepository);
  });

  test('should save tv show to the repository', () async {
    // arrange
    when(mockTvShowRepository.saveWatchlist(tTvShowDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(tTvShowDetail);
    // assert
    verify(mockTvShowRepository.saveWatchlist(tTvShowDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
