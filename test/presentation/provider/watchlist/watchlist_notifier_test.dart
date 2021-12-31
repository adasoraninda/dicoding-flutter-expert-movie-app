import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/tv_shows/get_watchlist_tv_shows.dart';
import 'package:ditonton/presentation/provider/watchlist/watchlist_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_notifier_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchlistTvShows,
])
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
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      // act
      await provider.fetchWatchlistMovies();
      // assert
      expect(provider.watchlistMovieState, RequestState.Loaded);
      expect(provider.watchlistMovies, [testWatchlistMovie]);
      expect(listenerCallCount, 2);
    });

    test('should change state to empty when data is empty', () async {
      // arrange
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([]));
      // act
      await provider.fetchWatchlistMovies();
      // assert
      expect(provider.watchlistMovieState, RequestState.Empty);
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
      expect(provider.watchlistMovieState, RequestState.Error);
      expect(provider.message, "Can't get data");
      expect(listenerCallCount, 2);
    });
  });

  group('watchlist tv shows', () {
    test('should change tv shows data when data is gotten successfully',
            () async {
          // arrange
          when(mockGetWatchlistTvShows.execute())
              .thenAnswer((_) async => Right([testWatchlistTvShow]));
          // act
          await provider.fetchWatchlistTvShows();
          // assert
          expect(provider.watchlistTvShowState, RequestState.Loaded);
          expect(provider.watchlistTvShows, [testWatchlistTvShow]);
          expect(listenerCallCount, 2);
        });

    test('should change state to empty when data is empty', () async {
      // arrange
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Right([]));
      // act
      await provider.fetchWatchlistTvShows();
      // assert
      expect(provider.watchlistTvShowState, RequestState.Empty);
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
      expect(provider.watchlistTvShowState, RequestState.Error);
      expect(provider.message, "Can't get data");
      expect(listenerCallCount, 2);
    });
  });
}