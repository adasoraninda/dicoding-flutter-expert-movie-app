import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movies/movie_detail.dart';
import 'package:core/presentation/bloc/movies/movie_detail_cubit.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MovieDetailCubit movieDetailCubit;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailCubit = MovieDetailCubit(mockGetMovieDetail);
  });

  test('Initialize state should be null', () {
    expect(movieDetailCubit.state, ResultState<MovieDetail>.init());
  });

  blocTest<MovieDetailCubit, ResultState<MovieDetail>>(
      'Should emit state [loading, success] when fetch is successfull',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(tMovieDetail));

        return movieDetailCubit;
      },
      act: (bloc) => bloc.fetchMovieDetail(tId),
      expect: () => [
            const ResultState<MovieDetail>(
              loading: true,
              data: null,
              error: null,
            ),
            const ResultState<MovieDetail>(
              loading: false,
              data: tMovieDetail,
              error: null,
            ),
          ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        verifyNoMoreInteractions(mockGetMovieDetail);
      });

  blocTest<MovieDetailCubit, ResultState<MovieDetail>>(
      'Should emit state [loading, error] when fetch is unsuccessfull',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return movieDetailCubit;
      },
      act: (bloc) => bloc.fetchMovieDetail(tId),
      expect: () => [
            const ResultState<MovieDetail>(
              loading: true,
              data: null,
              error: null,
            ),
            const ResultState<MovieDetail>(
              loading: false,
              data: null,
              error: 'Server Failure',
            ),
          ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        verifyNoMoreInteractions(mockGetMovieDetail);
      });
}
