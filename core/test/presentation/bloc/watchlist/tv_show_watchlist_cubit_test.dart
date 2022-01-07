import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/bloc/watchlist/tv_show_watchlist_cubit.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowWatchlistCubit tvShowWatchlistCubit;
  late MockGetWatchlistTvShows mockGetWatchlistTvShows;

  setUp(() {
    mockGetWatchlistTvShows = MockGetWatchlistTvShows();
    tvShowWatchlistCubit = TvShowWatchlistCubit(mockGetWatchlistTvShows);
  });

  test('Initialize state should be null', () {
    expect(tvShowWatchlistCubit.state, ResultState<List<TvShow>>.init());
    expect(tvShowWatchlistCubit.state.data, null);
  });

  blocTest<TvShowWatchlistCubit, ResultState<List<TvShow>>>(
      'Should emit state [loading, result] when fetch is successfull',
      build: () {
        when(mockGetWatchlistTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));

        return tvShowWatchlistCubit;
      },
      act: (bloc) => bloc.fetchWatchlistTvShows(),
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
        verify(mockGetWatchlistTvShows.execute());
        verifyNoMoreInteractions(mockGetWatchlistTvShows);
      });

  blocTest<TvShowWatchlistCubit, ResultState<List<TvShow>>>(
      'Should emit state [loading, error] when fetch is unsuccessfull',
      build: () {
        when(mockGetWatchlistTvShows.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return tvShowWatchlistCubit;
      },
      act: (bloc) => bloc.fetchWatchlistTvShows(),
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
        verify(mockGetWatchlistTvShows.execute());
        verifyNoMoreInteractions(mockGetWatchlistTvShows);
      });

  blocTest<TvShowWatchlistCubit, ResultState<List<TvShow>>>(
      'Should emit state [loading, result empty] when fetch is successfull',
      build: () {
        when(mockGetWatchlistTvShows.execute())
            .thenAnswer((_) async => const Right([]));

        return tvShowWatchlistCubit;
      },
      act: (bloc) => bloc.fetchWatchlistTvShows(),
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
        verify(mockGetWatchlistTvShows.execute());
        verifyNoMoreInteractions(mockGetWatchlistTvShows);
      });
}
