import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/entities/tv_shows/tv_show_detail.dart';
import 'package:core/presentation/bloc/detail_state.dart';
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
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;
  late MockSaveWatchlistTvShow mockSaveWatchlist;
  late MockRemoveWatchlistTvShow mockRemoveWatchlist;
  late MockGetWatchlistTvShowStatus mockGetWatchListStatus;

  setUp(() {
    mockGetTvShowDetail = MockGetTvShowDetail();
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    mockSaveWatchlist = MockSaveWatchlistTvShow();
    mockRemoveWatchlist = MockRemoveWatchlistTvShow();
    mockGetWatchListStatus = MockGetWatchlistTvShowStatus();
    tvShowDetailCubit = TvShowDetailCubit(
      mockGetTvShowDetail,
      mockGetTvShowRecommendations,
      mockSaveWatchlist,
      mockRemoveWatchlist,
      mockGetWatchListStatus,
    );
  });

  test('Initialize state should be empty', () {
    expect(tvShowDetailCubit.state, DetailState<TvShowDetail, TvShow>.init());
    expect(tvShowDetailCubit.state.detailData, null);
    expect(tvShowDetailCubit.state.recData, <TvShow>[]);
    expect(tvShowDetailCubit.state.status, false);
  });

  group('TvShowDetail', () {
    blocTest<TvShowDetailCubit, DetailState<TvShowDetail, TvShow>>(
        'Should emit state [loading, result] when fetch data successfull',
        build: () {
          when(mockGetTvShowDetail.execute(tId))
              .thenAnswer((_) async => Right(tTvShowDetail));
          return tvShowDetailCubit;
        },
        act: (bloc) {
          bloc.fetchTvShowDetail(tId);
        },
        expect: () => [
              const DetailState<TvShowDetail, TvShow>(
                true,
                null,
                null,
                false,
                [],
                null,
                false,
                null,
                null,
                false,
              ),
              DetailState<TvShowDetail, TvShow>(
                false,
                tTvShowDetail,
                null,
                false,
                [],
                null,
                false,
                null,
                null,
                false,
              ),
            ],
        verify: (bloc) {
          verify(mockGetTvShowDetail.execute(tId));
          verifyNoMoreInteractions(mockGetTvShowDetail);
          verifyZeroInteractions(mockGetTvShowRecommendations);
          verifyZeroInteractions(mockSaveWatchlist);
          verifyZeroInteractions(mockRemoveWatchlist);
          verifyZeroInteractions(mockGetWatchListStatus);
        });

    blocTest<TvShowDetailCubit, DetailState<TvShowDetail, TvShow>>(
        'Should emit state [loading, error] when fetch data unsuccessfull',
        build: () {
          when(mockGetTvShowDetail.execute(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return tvShowDetailCubit;
        },
        act: (bloc) {
          bloc.fetchTvShowDetail(tId);
        },
        expect: () => [
              const DetailState<TvShowDetail, TvShow>(
                true,
                null,
                null,
                false,
                [],
                null,
                false,
                null,
                null,
                false,
              ),
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                'Server Failure',
                false,
                [],
                null,
                false,
                null,
                null,
                false,
              ),
            ],
        verify: (bloc) {
          verify(mockGetTvShowDetail.execute(tId));
          verifyNoMoreInteractions(mockGetTvShowDetail);
          verifyZeroInteractions(mockGetTvShowRecommendations);
          verifyZeroInteractions(mockSaveWatchlist);
          verifyZeroInteractions(mockRemoveWatchlist);
          verifyZeroInteractions(mockGetWatchListStatus);
        });
  });

  group('TvShowRecommendations', () {
    blocTest<TvShowDetailCubit, DetailState<TvShowDetail, TvShow>>(
        'Should emit state [loading, result] when fetch data successfull',
        build: () {
          when(mockGetTvShowRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tTvShowList));
          return tvShowDetailCubit;
        },
        act: (bloc) {
          bloc.fetchTvShowDetailRecommendations(tId);
        },
        expect: () => [
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                true,
                [],
                null,
                false,
                null,
                null,
                false,
              ),
              DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                false,
                tTvShowList,
                null,
                false,
                null,
                null,
                false,
              ),
            ],
        verify: (bloc) {
          verify(mockGetTvShowRecommendations.execute(tId));
          verifyNoMoreInteractions(mockGetTvShowRecommendations);
          verifyZeroInteractions(mockGetTvShowDetail);
          verifyZeroInteractions(mockSaveWatchlist);
          verifyZeroInteractions(mockRemoveWatchlist);
          verifyZeroInteractions(mockGetWatchListStatus);
        });

    blocTest<TvShowDetailCubit, DetailState<TvShowDetail, TvShow>>(
        'Should emit state [loading, error] when fetch data unsuccessfull',
        build: () {
          when(mockGetTvShowRecommendations.execute(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return tvShowDetailCubit;
        },
        act: (bloc) {
          bloc.fetchTvShowDetailRecommendations(tId);
        },
        expect: () => [
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                true,
                [],
                null,
                false,
                null,
                null,
                false,
              ),
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                false,
                [],
                'Server Failure',
                false,
                null,
                null,
                false,
              ),
            ],
        verify: (bloc) {
          verify(mockGetTvShowRecommendations.execute(tId));
          verifyNoMoreInteractions(mockGetTvShowRecommendations);
          verifyZeroInteractions(mockGetTvShowDetail);
          verifyZeroInteractions(mockSaveWatchlist);
          verifyZeroInteractions(mockRemoveWatchlist);
          verifyZeroInteractions(mockGetWatchListStatus);
        });

    blocTest<TvShowDetailCubit, DetailState<TvShowDetail, TvShow>>(
        'Should emit state [loading, result empty] when fetch data unsuccessfull',
        build: () {
          when(mockGetTvShowRecommendations.execute(tId))
              .thenAnswer((_) async => const Right([]));
          return tvShowDetailCubit;
        },
        act: (bloc) {
          bloc.fetchTvShowDetailRecommendations(tId);
        },
        expect: () => [
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                true,
                [],
                null,
                false,
                null,
                null,
                false,
              ),
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                false,
                [],
                null,
                false,
                null,
                null,
                false,
              ),
            ],
        verify: (bloc) {
          verify(mockGetTvShowRecommendations.execute(tId));
          verifyNoMoreInteractions(mockGetTvShowRecommendations);
          verifyZeroInteractions(mockGetTvShowDetail);
          verifyZeroInteractions(mockSaveWatchlist);
          verifyZeroInteractions(mockRemoveWatchlist);
          verifyZeroInteractions(mockGetWatchListStatus);
        });
  });

  group('Add Watchlist', () {
    blocTest<TvShowDetailCubit, DetailState<TvShowDetail, TvShow>>(
        'Should emit state [loading, success message, true watchlist] when add watchlist successfull',
        build: () {
          when(mockSaveWatchlist.execute(tTvShowDetail))
              .thenAnswer((_) async => const Right('Added to Watchlist'));

          when(mockGetWatchListStatus.execute(tTvShowDetail.id))
              .thenAnswer((_) async => true);

          return tvShowDetailCubit;
        },
        act: (bloc) {
          bloc.addWatchlist(tTvShowDetail);
        },
        expect: () => [
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                false,
                [],
                null,
                true,
                null,
                null,
                false,
              ),
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                false,
                [],
                null,
                false,
                'Added to Watchlist',
                null,
                false,
              ),
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                false,
                [],
                null,
                false,
                null,
                null,
                true,
              ),
            ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(tTvShowDetail));
          verify(mockGetWatchListStatus.execute(tTvShowDetail.id));
          verifyNoMoreInteractions(mockSaveWatchlist);
          verifyNoMoreInteractions(mockGetWatchListStatus);
          verifyZeroInteractions(mockGetTvShowDetail);
          verifyZeroInteractions(mockGetTvShowRecommendations);
          verifyZeroInteractions(mockRemoveWatchlist);
        });

    blocTest<TvShowDetailCubit, DetailState<TvShowDetail, TvShow>>(
        'Should emit state [loading, error message, false watchlist] when add watchlist unsuccessfull',
        build: () {
          when(mockSaveWatchlist.execute(tTvShowDetail)).thenAnswer((_) async =>
              const Left(DatabaseFailure('Failed to add watchlist')));

          when(mockGetWatchListStatus.execute(tTvShowDetail.id))
              .thenAnswer((_) async => false);

          return tvShowDetailCubit;
        },
        act: (bloc) {
          bloc.addWatchlist(tTvShowDetail);
        },
        expect: () => [
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                false,
                [],
                null,
                true,
                null,
                null,
                false,
              ),
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                false,
                [],
                null,
                false,
                null,
                'Failed to add watchlist',
                false,
              ),
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                false,
                [],
                null,
                false,
                null,
                null,
                false,
              ),
            ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(tTvShowDetail));
          verify(mockGetWatchListStatus.execute(tTvShowDetail.id));
          verifyNoMoreInteractions(mockSaveWatchlist);
          verifyNoMoreInteractions(mockGetWatchListStatus);
          verifyZeroInteractions(mockGetTvShowDetail);
          verifyZeroInteractions(mockGetTvShowRecommendations);
          verifyZeroInteractions(mockRemoveWatchlist);
        });
  });

  group('Remove Watchlist', () {
    blocTest<TvShowDetailCubit, DetailState<TvShowDetail, TvShow>>(
        'Should emit state [loading, success message, false watchlist] when remove watchlist successfull',
        build: () {
          when(mockRemoveWatchlist.execute(tTvShowDetail))
              .thenAnswer((_) async => const Right('Removed from Watchlist'));

          when(mockGetWatchListStatus.execute(tTvShowDetail.id))
              .thenAnswer((_) async => false);

          tvShowDetailCubit.emit(const DetailState<TvShowDetail, TvShow>(
            false,
            null,
            null,
            false,
            [],
            null,
            false,
            null,
            null,
            true,
          ));

          return tvShowDetailCubit;
        },
        act: (bloc) {
          bloc.removeFromWatchlist(tTvShowDetail);
        },
        expect: () => [
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                false,
                [],
                null,
                true,
                null,
                null,
                true,
              ),
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                false,
                [],
                null,
                false,
                'Removed from Watchlist',
                null,
                true,
              ),
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                false,
                [],
                null,
                false,
                null,
                null,
                false,
              ),
            ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(tTvShowDetail));
          verify(mockGetWatchListStatus.execute(tTvShowDetail.id));
          verifyNoMoreInteractions(mockRemoveWatchlist);
          verifyNoMoreInteractions(mockGetWatchListStatus);
          verifyZeroInteractions(mockGetTvShowDetail);
          verifyZeroInteractions(mockGetTvShowRecommendations);
          verifyZeroInteractions(mockSaveWatchlist);
        });

    blocTest<TvShowDetailCubit, DetailState<TvShowDetail, TvShow>>(
        'Should emit state [loading, error message, true watchlist] when remove watchlist unsuccessfull',
        build: () {
          when(mockRemoveWatchlist.execute(tTvShowDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('Failed to remove watchlist')));

          when(mockGetWatchListStatus.execute(tTvShowDetail.id))
              .thenAnswer((_) async => true);

          tvShowDetailCubit.emit(const DetailState<TvShowDetail, TvShow>(
            false,
            null,
            null,
            false,
            [],
            null,
            false,
            null,
            null,
            true,
          ));

          return tvShowDetailCubit;
        },
        act: (bloc) {
          bloc.removeFromWatchlist(tTvShowDetail);
        },
        expect: () => [
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                false,
                [],
                null,
                true,
                null,
                null,
                true,
              ),
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                false,
                [],
                null,
                false,
                null,
                'Failed to remove watchlist',
                true,
              ),
              const DetailState<TvShowDetail, TvShow>(
                false,
                null,
                null,
                false,
                [],
                null,
                false,
                null,
                null,
                true,
              ),
            ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(tTvShowDetail));
          verify(mockGetWatchListStatus.execute(tTvShowDetail.id));
          verifyNoMoreInteractions(mockRemoveWatchlist);
          verifyNoMoreInteractions(mockGetWatchListStatus);
          verifyZeroInteractions(mockGetTvShowDetail);
          verifyZeroInteractions(mockGetTvShowRecommendations);
          verifyZeroInteractions(mockSaveWatchlist);
        });
  });

  group('Load Watchlist Status', () {
    blocTest<TvShowDetailCubit, DetailState<TvShowDetail, TvShow>>(
      'Should get result true when get watchlist statuss get called',
      build: () {
        when(mockGetWatchListStatus.execute(tTvShowDetail.id))
            .thenAnswer((_) async => true);

        return tvShowDetailCubit;
      },
      act: (bloc) {
        bloc.loadWatchlistStatus(tTvShowDetail.id);
      },
      expect: () => [
        const DetailState<TvShowDetail, TvShow>(
          false,
          null,
          null,
          false,
          [],
          null,
          false,
          null,
          null,
          true,
        ),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(tTvShowDetail.id));
        verifyNoMoreInteractions(mockGetWatchListStatus);
      },
    );

    blocTest<TvShowDetailCubit, DetailState<TvShowDetail, TvShow>>(
      'Should get result true when get watchlist statuss get called',
      build: () {
        when(mockGetWatchListStatus.execute(tTvShowDetail.id))
            .thenAnswer((_) async => false);

        return tvShowDetailCubit;
      },
      act: (bloc) {
        bloc.loadWatchlistStatus(tTvShowDetail.id);
      },
      expect: () => [
        const DetailState<TvShowDetail, TvShow>(
          false,
          null,
          null,
          false,
          [],
          null,
          false,
          null,
          null,
          false,
        ),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(tTvShowDetail.id));
        verifyNoMoreInteractions(mockGetWatchListStatus);
      },
    );
  });
}
