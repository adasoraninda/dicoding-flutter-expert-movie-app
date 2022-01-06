import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/bloc/tv_shows/popular_tv_shows_cubit.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late PopularTvShowsCubit popularTvShowsCubit;
  late MockGetPopularTvShows mockGetPopularTvShows;

  setUp(() {
    mockGetPopularTvShows = MockGetPopularTvShows();
    popularTvShowsCubit = PopularTvShowsCubit(mockGetPopularTvShows);
  });

  test('Initialize state should be empty', () {
    expect(popularTvShowsCubit.state, ResultState.init(const <TvShow>[]));
    expect(popularTvShowsCubit.state.data, []);
  });

  blocTest<PopularTvShowsCubit, ResultState<List<TvShow>>>(
      'Should emit state [loading, result] when fetch is successfull',
      build: () {
        when(mockGetPopularTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));

        return popularTvShowsCubit;
      },
      act: (bloc) => bloc.fetchPopularTvShows(),
      expect: () => [
            const ResultState(
              loading: true,
              data: <TvShow>[],
              error: null,
            ),
            ResultState(
              loading: false,
              data: tTvShowList,
              error: null,
            ),
          ],
      verify: (bloc) {
        verify(mockGetPopularTvShows.execute());
        verifyNoMoreInteractions(mockGetPopularTvShows);
      });

  blocTest<PopularTvShowsCubit, ResultState<List<TvShow>>>(
      'Should emit state [loading, error] when fetch is unsuccessfull',
      build: () {
        when(mockGetPopularTvShows.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return popularTvShowsCubit;
      },
      act: (bloc) => bloc.fetchPopularTvShows(),
      expect: () => [
            const ResultState(
              loading: true,
              data: <TvShow>[],
              error: null,
            ),
            const ResultState(
              loading: false,
              data: <TvShow>[],
              error: 'Server Failure',
            ),
          ],
      verify: (bloc) {
        verify(mockGetPopularTvShows.execute());
        verifyNoMoreInteractions(mockGetPopularTvShows);
      });

  blocTest<PopularTvShowsCubit, ResultState<List<TvShow>>>(
      'Should emit state [loading, result empty] when fetch is successfull',
      build: () {
        when(mockGetPopularTvShows.execute())
            .thenAnswer((_) async => const Right([]));

        return popularTvShowsCubit;
      },
      act: (bloc) => bloc.fetchPopularTvShows(),
      expect: () => [
            const ResultState(
              loading: true,
              data: <TvShow>[],
              error: null,
            ),
            const ResultState(
              loading: false,
              data: <TvShow>[],
              error: null,
            ),
          ],
      verify: (bloc) {
        verify(mockGetPopularTvShows.execute());
        verifyNoMoreInteractions(mockGetPopularTvShows);
      });
}
