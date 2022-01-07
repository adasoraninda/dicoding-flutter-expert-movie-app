import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/bloc/watchlist/movie_watchlist_cubit.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MovieWatchlistCubit movieWatchlistCubit;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    movieWatchlistCubit = MovieWatchlistCubit(mockGetWatchlistMovies);
  });

  test('Initialize state should be null', () {
    expect(movieWatchlistCubit.state, ResultState<List<Movie>>.init());
    expect(movieWatchlistCubit.state.data, null);
  });

  blocTest<MovieWatchlistCubit, ResultState<List<Movie>>>(
      'Should emit state [loading, result] when fetch is successfull',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        return movieWatchlistCubit;
      },
      act: (bloc) => bloc.fetchWatchlistMovies(),
      expect: () => [
            const ResultState<List<Movie>>(
              loading: true,
              data: null,
              error: null,
            ),
            ResultState<List<Movie>>(
              loading: false,
              data: tMovieList,
              error: null,
            ),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        verifyNoMoreInteractions(mockGetWatchlistMovies);
      });

  blocTest<MovieWatchlistCubit, ResultState<List<Movie>>>(
      'Should emit state [loading, error] when fetch is unsuccessfull',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return movieWatchlistCubit;
      },
      act: (bloc) => bloc.fetchWatchlistMovies(),
      expect: () => [
            const ResultState<List<Movie>>(
              loading: true,
              data: null,
              error: null,
            ),
            const ResultState<List<Movie>>(
              loading: false,
              data: null,
              error: 'Server Failure',
            ),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        verifyNoMoreInteractions(mockGetWatchlistMovies);
      });

  blocTest<MovieWatchlistCubit, ResultState<List<Movie>>>(
      'Should emit state [loading, result empty] when fetch is successfull',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Right([]));

        return movieWatchlistCubit;
      },
      act: (bloc) => bloc.fetchWatchlistMovies(),
      expect: () => [
            const ResultState<List<Movie>>(
              loading: true,
              data: null,
              error: null,
            ),
            const ResultState<List<Movie>>(
              loading: false,
              data: <Movie>[],
              error: null,
            ),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        verifyNoMoreInteractions(mockGetWatchlistMovies);
      });
}
