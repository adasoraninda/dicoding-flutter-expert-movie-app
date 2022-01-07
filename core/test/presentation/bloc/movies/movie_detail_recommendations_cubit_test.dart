import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/presentation/bloc/movies/movie_detail_recommendations_cubit.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MovieDetailRecommendationsCubit movieDetailRecommendationsCubit;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieDetailRecommendationsCubit =
        MovieDetailRecommendationsCubit(mockGetMovieRecommendations);
  });

  test('Initialize state should be null', () {
    expect(
        movieDetailRecommendationsCubit.state, ResultState<List<Movie>>.init());
    expect(movieDetailRecommendationsCubit.state.data, null);
  });

  blocTest<MovieDetailRecommendationsCubit, ResultState<List<Movie>>>(
      'Should emit state [loading, result] when fetch is successfull',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovieList));

        return movieDetailRecommendationsCubit;
      },
      act: (bloc) => bloc.fetchMovieDetailRecommendations(tId),
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
        verify(mockGetMovieRecommendations.execute(tId));
        verifyNoMoreInteractions(mockGetMovieRecommendations);
      });

  blocTest<MovieDetailRecommendationsCubit, ResultState<List<Movie>>>(
      'Should emit state [loading, error] when fetch is unsuccessfull',
      build: () {
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return movieDetailRecommendationsCubit;
      },
      act: (bloc) => bloc.fetchMovieDetailRecommendations(tId),
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
        verify(mockGetMovieRecommendations.execute(tId));
        verifyNoMoreInteractions(mockGetMovieRecommendations);
      });

  blocTest<MovieDetailRecommendationsCubit, ResultState<List<Movie>>>(
      'Should emit state [loading, result empty] when fetch is successfull',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Right(<Movie>[]));

        return movieDetailRecommendationsCubit;
      },
      act: (bloc) => bloc.fetchMovieDetailRecommendations(tId),
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
        verify(mockGetMovieRecommendations.execute(tId));
        verifyNoMoreInteractions(mockGetMovieRecommendations);
      });
}
