import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_watchlist_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowDetailWatchlistCubit tvShowDetailWatchlistCubit;
  late MockSaveWatchlistTvShow mockSaveWatchlistTvShow;
  late MockRemoveWatchlistTvShow mockRemoveWatchlistTvShow;

  setUp(() {
    mockSaveWatchlistTvShow = MockSaveWatchlistTvShow();
    mockRemoveWatchlistTvShow = MockRemoveWatchlistTvShow();
    tvShowDetailWatchlistCubit = TvShowDetailWatchlistCubit(
      mockSaveWatchlistTvShow,
      mockRemoveWatchlistTvShow,
    );
  });

  test('Initiliaze state should be null', () {
    expect(tvShowDetailWatchlistCubit.state, ResultState<String?>.init());
    expect(tvShowDetailWatchlistCubit.state.data, null);
  });

  group('Save watch list', () {
    blocTest(
      'Should emit [loading, success] when save functionality successfull',
      build: () {
        when(mockSaveWatchlistTvShow.execute(tTvShowDetail))
            .thenAnswer((_) async => const Right('Success'));
        return tvShowDetailWatchlistCubit;
      },
      act: (bloc) => tvShowDetailWatchlistCubit.addWatchlist(tTvShowDetail),
      expect: () => [
        const ResultState<String?>(loading: true, data: null, error: null),
        const ResultState<String?>(
            loading: false, data: 'Success', error: null),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvShow.execute(tTvShowDetail));
        verifyNoMoreInteractions(mockSaveWatchlistTvShow);
      },
    );

    blocTest(
      'Should emit [loading, error] when save functionality unsuccessfull',
      build: () {
        when(mockSaveWatchlistTvShow.execute(tTvShowDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Error')));
        return tvShowDetailWatchlistCubit;
      },
      act: (bloc) => tvShowDetailWatchlistCubit.addWatchlist(tTvShowDetail),
      expect: () => [
        const ResultState<String?>(loading: true, data: null, error: null),
        const ResultState<String?>(loading: false, data: null, error: 'Error'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvShow.execute(tTvShowDetail));
        verifyNoMoreInteractions(mockSaveWatchlistTvShow);
      },
    );
  });

  group('Remove watch list', () {
    blocTest(
      'Should emit [loading, success] when remove functionality successfull',
      build: () {
        when(mockRemoveWatchlistTvShow.execute(tTvShowDetail))
            .thenAnswer((_) async => const Right('Success'));
        return tvShowDetailWatchlistCubit;
      },
      act: (bloc) =>
          tvShowDetailWatchlistCubit.removeFromWatchlist(tTvShowDetail),
      expect: () => [
        const ResultState<String?>(loading: true, data: null, error: null),
        const ResultState<String?>(
            loading: false, data: 'Success', error: null),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvShow.execute(tTvShowDetail));
        verifyNoMoreInteractions(mockRemoveWatchlistTvShow);
      },
    );

    blocTest(
      'Should emit [loading, error] when remove functionality unsuccessfull',
      build: () {
        when(mockRemoveWatchlistTvShow.execute(tTvShowDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Error')));
        return tvShowDetailWatchlistCubit;
      },
      act: (bloc) =>
          tvShowDetailWatchlistCubit.removeFromWatchlist(tTvShowDetail),
      expect: () => [
        const ResultState<String?>(loading: true, data: null, error: null),
        const ResultState<String?>(loading: false, data: null, error: 'Error'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvShow.execute(tTvShowDetail));
        verifyNoMoreInteractions(mockRemoveWatchlistTvShow);
      },
    );
  });
}
