import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_shows/tv_show_detail.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_cubit.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowDetailCubit tvShowDetailCubit;
  late MockGetTvShowDetail mockGetTvShowDetail;

  setUp(() {
    mockGetTvShowDetail = MockGetTvShowDetail();
    tvShowDetailCubit = TvShowDetailCubit(mockGetTvShowDetail);
  });

  test('Initialize state should be null', () {
    expect(tvShowDetailCubit.state, ResultState<TvShowDetail>.init());
  });

  blocTest<TvShowDetailCubit, ResultState<TvShowDetail>>(
      'Should emit state [loading, success] when fetch is successfull',
      build: () {
        when(mockGetTvShowDetail.execute(tId))
            .thenAnswer((_) async => Right(tTvShowDetail));

        return tvShowDetailCubit;
      },
      act: (bloc) => bloc.fetchTvShowDetail(tId),
      expect: () => [
            const ResultState<TvShowDetail>(
              loading: true,
              data: null,
              error: null,
            ),
            ResultState<TvShowDetail>(
              loading: false,
              data: tTvShowDetail,
              error: null,
            ),
          ],
      verify: (bloc) {
        verify(mockGetTvShowDetail.execute(tId));
        verifyNoMoreInteractions(mockGetTvShowDetail);
      });

  blocTest<TvShowDetailCubit, ResultState<TvShowDetail>>(
      'Should emit state [loading, error] when fetch is unsuccessfull',
      build: () {
        when(mockGetTvShowDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return tvShowDetailCubit;
      },
      act: (bloc) => bloc.fetchTvShowDetail(tId),
      expect: () => [
            const ResultState<TvShowDetail>(
              loading: true,
              data: null,
              error: null,
            ),
            const ResultState<TvShowDetail>(
              loading: false,
              data: null,
              error: 'Server Failure',
            ),
          ],
      verify: (bloc) {
        verify(mockGetTvShowDetail.execute(tId));
        verifyNoMoreInteractions(mockGetTvShowDetail);
      });
}
