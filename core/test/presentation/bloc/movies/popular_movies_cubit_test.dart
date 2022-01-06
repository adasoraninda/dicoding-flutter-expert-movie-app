import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/presentation/bloc/movies/popular_movies_cubit.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late PopularMoviesCubit popularMoviesCubit;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesCubit = PopularMoviesCubit(mockGetPopularMovies);
  });

  test('Initialize state should be empty', () {
    expect(popularMoviesCubit.state, ResultState.init(const <Movie>[]));
    expect(popularMoviesCubit.state.data, []);
  });

  blocTest<PopularMoviesCubit, ResultState<List<Movie>>>(
      'Should emit state [loading, result] when fetch is successfull',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        return popularMoviesCubit;
      },
      act: (bloc) => bloc.fetchPopularMovies(),
      expect: () => [
            const ResultState(
              loading: true,
              data: <Movie>[],
              error: null,
            ),
            ResultState(
              loading: false,
              data: tMovieList,
              error: null,
            ),
          ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
        verifyNoMoreInteractions(mockGetPopularMovies);
      });

  blocTest<PopularMoviesCubit, ResultState<List<Movie>>>(
      'Should emit state [loading, error] when fetch is unsuccessfull',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return popularMoviesCubit;
      },
      act: (bloc) => bloc.fetchPopularMovies(),
      expect: () => [
            const ResultState(
              loading: true,
              data: <Movie>[],
              error: null,
            ),
            const ResultState(
              loading: false,
              data: <Movie>[],
              error: 'Server Failure',
            ),
          ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
        verifyNoMoreInteractions(mockGetPopularMovies);
      });

  blocTest<PopularMoviesCubit, ResultState<List<Movie>>>(
      'Should emit state [loading, result empty] when fetch is successfull',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => const Right([]));

        return popularMoviesCubit;
      },
      act: (bloc) => bloc.fetchPopularMovies(),
      expect: () => [
            const ResultState(
              loading: true,
              data: <Movie>[],
              error: null,
            ),
            const ResultState(
              loading: false,
              data: <Movie>[],
              error: null,
            ),
          ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
        verifyNoMoreInteractions(mockGetPopularMovies);
      });
}
