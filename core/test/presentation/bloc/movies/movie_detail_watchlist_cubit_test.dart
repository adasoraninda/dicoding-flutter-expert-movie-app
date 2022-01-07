import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/movies/movie_detail_watchlist_cubit.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MovieDetailWatchlistCubit movieDetailWatchlistCubit;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;

  setUp(() {
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    movieDetailWatchlistCubit = MovieDetailWatchlistCubit(
      mockSaveWatchlistMovie,
      mockRemoveWatchlistMovie,
    );
  });

  test('Initiliaze state should be null', () {
    expect(movieDetailWatchlistCubit.state, ResultState<String?>.init());
    expect(movieDetailWatchlistCubit.state.data, null);
  });

  group('Save watch list', () {
    blocTest(
      'Should emit [loading, success] when save functionality successfull',
      build: () {
        when(mockSaveWatchlistMovie.execute(tMovieDetail))
            .thenAnswer((_) async => const Right('Success'));
        return movieDetailWatchlistCubit;
      },
      act: (bloc) => movieDetailWatchlistCubit.addWatchlist(tMovieDetail),
      expect: () => [
        const ResultState<String?>(loading: true, data: null, error: null),
        const ResultState<String?>(
            loading: false, data: 'Success', error: null),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistMovie.execute(tMovieDetail));
        verifyNoMoreInteractions(mockSaveWatchlistMovie);
      },
    );

    blocTest(
      'Should emit [loading, error] when save functionality unsuccessfull',
      build: () {
        when(mockSaveWatchlistMovie.execute(tMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Error')));
        return movieDetailWatchlistCubit;
      },
      act: (bloc) => movieDetailWatchlistCubit.addWatchlist(tMovieDetail),
      expect: () => [
        const ResultState<String?>(loading: true, data: null, error: null),
        const ResultState<String?>(loading: false, data: null, error: 'Error'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistMovie.execute(tMovieDetail));
        verifyNoMoreInteractions(mockSaveWatchlistMovie);
      },
    );
  });

  group('Remove watch list', () {
    blocTest(
      'Should emit [loading, success] when remove functionality successfull',
      build: () {
        when(mockRemoveWatchlistMovie.execute(tMovieDetail))
            .thenAnswer((_) async => const Right('Success'));
        return movieDetailWatchlistCubit;
      },
      act: (bloc) =>
          movieDetailWatchlistCubit.removeFromWatchlist(tMovieDetail),
      expect: () => [
        const ResultState<String?>(loading: true, data: null, error: null),
        const ResultState<String?>(
            loading: false, data: 'Success', error: null),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistMovie.execute(tMovieDetail));
        verifyNoMoreInteractions(mockRemoveWatchlistMovie);
      },
    );

    blocTest(
      'Should emit [loading, error] when remove functionality unsuccessfull',
      build: () {
        when(mockRemoveWatchlistMovie.execute(tMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Error')));
        return movieDetailWatchlistCubit;
      },
      act: (bloc) =>
          movieDetailWatchlistCubit.removeFromWatchlist(tMovieDetail),
      expect: () => [
        const ResultState<String?>(loading: true, data: null, error: null),
        const ResultState<String?>(loading: false, data: null, error: 'Error'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistMovie.execute(tMovieDetail));
        verifyNoMoreInteractions(mockRemoveWatchlistMovie);
      },
    );
  });
}
