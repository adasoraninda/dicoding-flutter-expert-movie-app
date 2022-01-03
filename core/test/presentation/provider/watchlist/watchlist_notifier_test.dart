import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  late WatchlistNotifier provider;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchlistTvShows mockGetWatchlistTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchlistTvShows = MockGetWatchlistTvShows();
    provider = WatchlistNotifier(
      getWatchlistMovies: mockGetWatchlistMovies,
      getWatchlistTvShows: mockGetWatchlistTvShows,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('watchlist movies', () {
    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([tWatchlistMovie]));
      // act
      await provider.fetchWatchlistMovies();
      // assert
      expect(provider.watchlistMovieState, RequestState.loaded);
      expect(provider.watchlistMovies, [tWatchlistMovie]);
      expect(listenerCallCount, 2);
    });

    test('should change state to empty when data is empty', () async {
      // arrange
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([]));
      // act
      await provider.fetchWatchlistMovies();
      // assert
      expect(provider.watchlistMovieState, RequestState.empty);
      expect(provider.watchlistMovies, []);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      // act
      await provider.fetchWatchlistMovies();
      // assert
      expect(provider.watchlistMovieState, RequestState.error);
      expect(provider.message, "Can't get data");
      expect(listenerCallCount, 2);
    });
  });

  group('watchlist tv shows', () {
    test('should change tv shows data when data is gotten successfully',
            () async {
          // arrange
          when(mockGetWatchlistTvShows.execute())
              .thenAnswer((_) async => Right([tWatchlistTvShow]));
          // act
          await provider.fetchWatchlistTvShows();
          // assert
          expect(provider.watchlistTvShowState, RequestState.loaded);
          expect(provider.watchlistTvShows, [tWatchlistTvShow]);
          expect(listenerCallCount, 2);
        });

    test('should change state to empty when data is empty', () async {
      // arrange
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Right([]));
      // act
      await provider.fetchWatchlistTvShows();
      // assert
      expect(provider.watchlistTvShowState, RequestState.empty);
      expect(provider.watchlistTvShows, []);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      // act
      await provider.fetchWatchlistTvShows();
      // assert
      expect(provider.watchlistTvShowState, RequestState.error);
      expect(provider.message, "Can't get data");
      expect(listenerCallCount, 2);
    });
  });
}
