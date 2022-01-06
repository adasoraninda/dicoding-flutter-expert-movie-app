import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/presentation/bloc/movies/top_rated_movies_cubit.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TopRatedMoviesCubit topRatedMoviesCubit;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesCubit = TopRatedMoviesCubit(mockGetTopRatedMovies);
  });

  test('Initialize state should be empty', () {
    expect(topRatedMoviesCubit.state, ResultState.init(const <Movie>[]));
    expect(topRatedMoviesCubit.state.data, []);
  });

  blocTest<TopRatedMoviesCubit, ResultState<List<Movie>>>(
      'Should emit state [loading, result] when fetch is successfull',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        return topRatedMoviesCubit;
      },
      act: (bloc) => bloc.fetchTopRatedMovies(),
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
        verify(mockGetTopRatedMovies.execute());
        verifyNoMoreInteractions(mockGetTopRatedMovies);
      });

  blocTest<TopRatedMoviesCubit, ResultState<List<Movie>>>(
      'Should emit state [loading, error] when fetch is unsuccessfull',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return topRatedMoviesCubit;
      },
      act: (bloc) => bloc.fetchTopRatedMovies(),
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
        verify(mockGetTopRatedMovies.execute());
        verifyNoMoreInteractions(mockGetTopRatedMovies);
      });

  blocTest<TopRatedMoviesCubit, ResultState<List<Movie>>>(
      'Should emit state [loading, result empty] when fetch is successfull',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => const Right([]));

        return topRatedMoviesCubit;
      },
      act: (bloc) => bloc.fetchTopRatedMovies(),
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
        verify(mockGetTopRatedMovies.execute());
        verifyNoMoreInteractions(mockGetTopRatedMovies);
      });
}
