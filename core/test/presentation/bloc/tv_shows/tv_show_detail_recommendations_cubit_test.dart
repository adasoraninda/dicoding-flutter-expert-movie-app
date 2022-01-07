import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_recommendations_cubit.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowDetailRecommendationsCubit tvShowDetailRecommendationsCubit;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;

  setUp(() {
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    tvShowDetailRecommendationsCubit =
        TvShowDetailRecommendationsCubit(mockGetTvShowRecommendations);
  });

  test('Initialize state should be null', () {
    expect(tvShowDetailRecommendationsCubit.state,
        ResultState<List<TvShow>>.init());
    expect(tvShowDetailRecommendationsCubit.state.data, null);
  });

  blocTest<TvShowDetailRecommendationsCubit, ResultState<List<TvShow>>>(
      'Should emit state [loading, result] when fetch is successfull',
      build: () {
        when(mockGetTvShowRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvShowList));

        return tvShowDetailRecommendationsCubit;
      },
      act: (bloc) => bloc.fetchTvShowDetailRecommendations(tId),
      expect: () => [
            const ResultState<List<TvShow>>(
              loading: true,
              data: null,
              error: null,
            ),
            ResultState<List<TvShow>>(
              loading: false,
              data: tTvShowList,
              error: null,
            ),
          ],
      verify: (bloc) {
        verify(mockGetTvShowRecommendations.execute(tId));
        verifyNoMoreInteractions(mockGetTvShowRecommendations);
      });

  blocTest<TvShowDetailRecommendationsCubit, ResultState<List<TvShow>>>(
      'Should emit state [loading, error] when fetch is unsuccessfull',
      build: () {
        when(mockGetTvShowRecommendations.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return tvShowDetailRecommendationsCubit;
      },
      act: (bloc) => bloc.fetchTvShowDetailRecommendations(tId),
      expect: () => [
            const ResultState<List<TvShow>>(
              loading: true,
              data: null,
              error: null,
            ),
            const ResultState<List<TvShow>>(
              loading: false,
              data: null,
              error: 'Server Failure',
            ),
          ],
      verify: (bloc) {
        verify(mockGetTvShowRecommendations.execute(tId));
        verifyNoMoreInteractions(mockGetTvShowRecommendations);
      });

  blocTest<TvShowDetailRecommendationsCubit, ResultState<List<TvShow>>>(
      'Should emit state [loading, result empty] when fetch is successfull',
      build: () {
        when(mockGetTvShowRecommendations.execute(tId))
            .thenAnswer((_) async => const Right(<TvShow>[]));

        return tvShowDetailRecommendationsCubit;
      },
      act: (bloc) => bloc.fetchTvShowDetailRecommendations(tId),
      expect: () => [
            const ResultState<List<TvShow>>(
              loading: true,
              data: null,
              error: null,
            ),
            const ResultState<List<TvShow>>(
              loading: false,
              data: <TvShow>[],
              error: null,
            ),
          ],
      verify: (bloc) {
        verify(mockGetTvShowRecommendations.execute(tId));
        verifyNoMoreInteractions(mockGetTvShowRecommendations);
      });
}
