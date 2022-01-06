import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/watchlist/watchlist_cubit.dart';
import 'package:core/presentation/bloc/watchlist_state.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistCubit watchlistCubit;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchlistTvShows mockWatchlistTvShows;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockWatchlistTvShows = MockGetWatchlistTvShows();
    watchlistCubit = WatchlistCubit(
      mockWatchlistTvShows,
      mockGetWatchlistMovies,
    );
  });

  test('initial state should be empty', () {
    expect(watchlistCubit.state, WatchlistState.init());
    expect(watchlistCubit.state.movieData, []);
    expect(watchlistCubit.state.tvShowData, []);
  });

  group('WatchlistMovies', () {
    blocTest<WatchlistCubit, WatchlistState>(
      'Should emit state [loading, result] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        return watchlistCubit;
      },
      act: (bloc) {
        bloc.fetchWatchlistMovies();
      },
      expect: () => [
        const WatchlistState(
          movieLoading: true,
          tvShowLoading: false,
          movieData: [],
          tvShowData: [],
          movieError: null,
          tvShowError: null,
        ),
        WatchlistState(
          movieLoading: false,
          tvShowLoading: false,
          movieData: tMovieList,
          tvShowData: const [],
          movieError: null,
          tvShowError: null,
        ),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        verifyNoMoreInteractions(mockGetWatchlistMovies);
        verifyZeroInteractions(mockWatchlistTvShows);
      },
    );

    blocTest<WatchlistCubit, WatchlistState>(
      'Should emit state [loading, error] when data is gotten unsuccessfully',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => const Left(DatabaseFailure('Can\'t get data')));

        return watchlistCubit;
      },
      act: (bloc) {
        bloc.fetchWatchlistMovies();
      },
      expect: () => [
        const WatchlistState(
          movieLoading: true,
          tvShowLoading: false,
          movieData: [],
          tvShowData: [],
          movieError: null,
          tvShowError: null,
        ),
        const WatchlistState(
          movieLoading: false,
          tvShowLoading: false,
          movieData: [],
          tvShowData: [],
          movieError: 'Can\'t get data',
          tvShowError: null,
        ),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        verifyNoMoreInteractions(mockGetWatchlistMovies);
        verifyZeroInteractions(mockWatchlistTvShows);
      },
    );

    blocTest<WatchlistCubit, WatchlistState>(
      'Should emit state [loading, result] when data is empty',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Right([]));

        return watchlistCubit;
      },
      act: (bloc) {
        bloc.fetchWatchlistMovies();
      },
      expect: () => [
        const WatchlistState(
          movieLoading: true,
          tvShowLoading: false,
          movieData: [],
          tvShowData: [],
          movieError: null,
          tvShowError: null,
        ),
        const WatchlistState(
          movieLoading: false,
          tvShowLoading: false,
          movieData: [],
          tvShowData: [],
          movieError: null,
          tvShowError: null,
        ),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        verifyNoMoreInteractions(mockGetWatchlistMovies);
        verifyZeroInteractions(mockWatchlistTvShows);
      },
    );
  });

  group('WatchlistTvShows', () {
    blocTest<WatchlistCubit, WatchlistState>(
      'Should emit state [loading, result] when data is gotten successfully',
      build: () {
        when(mockWatchlistTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));

        return watchlistCubit;
      },
      act: (bloc) {
        bloc.fetchWatchlistTvShows();
      },
      expect: () => [
        const WatchlistState(
          movieLoading: false,
          tvShowLoading: true,
          movieData: [],
          tvShowData: [],
          movieError: null,
          tvShowError: null,
        ),
        WatchlistState(
          movieLoading: false,
          tvShowLoading: false,
          movieData: const [],
          tvShowData: tTvShowList,
          movieError: null,
          tvShowError: null,
        ),
      ],
      verify: (bloc) {
        verify(mockWatchlistTvShows.execute());
        verifyNoMoreInteractions(mockWatchlistTvShows);
        verifyZeroInteractions(mockGetWatchlistMovies);
      },
    );

    blocTest<WatchlistCubit, WatchlistState>(
      'Should emit state [loading, error] when data is gotten unsuccessfully',
      build: () {
        when(mockWatchlistTvShows.execute()).thenAnswer(
            (_) async => const Left(DatabaseFailure('Can\'t get data')));

        return watchlistCubit;
      },
      act: (bloc) {
        bloc.fetchWatchlistTvShows();
      },
      expect: () => [
        const WatchlistState(
          movieLoading: false,
          tvShowLoading: true,
          movieData: [],
          tvShowData: [],
          movieError: null,
          tvShowError: null,
        ),
        const WatchlistState(
          movieLoading: false,
          tvShowLoading: false,
          movieData: [],
          tvShowData: [],
          movieError: null,
          tvShowError: 'Can\'t get data',
        ),
      ],
      verify: (bloc) {
        verify(mockWatchlistTvShows.execute());
        verifyNoMoreInteractions(mockWatchlistTvShows);
        verifyZeroInteractions(mockGetWatchlistMovies);
      },
    );

    blocTest<WatchlistCubit, WatchlistState>(
      'Should emit state [loading, result] when data is empty',
      build: () {
        when(mockWatchlistTvShows.execute())
            .thenAnswer((_) async => const Right([]));

        return watchlistCubit;
      },
      act: (bloc) {
        bloc.fetchWatchlistTvShows();
      },
      expect: () => [
        const WatchlistState(
          movieLoading: false,
          tvShowLoading: true,
          movieData: [],
          tvShowData: [],
          movieError: null,
          tvShowError: null,
        ),
        const WatchlistState(
          movieLoading: false,
          tvShowLoading: false,
          movieData: [],
          tvShowData: [],
          movieError: null,
          tvShowError: null,
        ),
      ],
      verify: (bloc) {
        verify(mockWatchlistTvShows.execute());
        verifyNoMoreInteractions(mockWatchlistTvShows);
        verifyZeroInteractions(mockGetWatchlistMovies);
      },
    );
  });
}
