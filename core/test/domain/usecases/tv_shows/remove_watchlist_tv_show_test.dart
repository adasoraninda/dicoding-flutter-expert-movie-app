import 'package:core/domain/usecases/tv_shows/remove_watchlist_tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  late RemoveWatchlistTvShow usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = RemoveWatchlistTvShow(mockTvShowRepository);
  });

  test('should remove watchlist tv show from repository', () async {
    // arrange
    when(mockTvShowRepository.removeWatchlist(tTvShowDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(tTvShowDetail);
    // assert
    verify(mockTvShowRepository.removeWatchlist(tTvShowDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}