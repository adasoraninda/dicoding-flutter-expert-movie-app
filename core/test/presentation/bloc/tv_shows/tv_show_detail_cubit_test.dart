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
                detailLoading: true,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: false,
              ),
              DetailState<TvShowDetail, TvShow>(
                detailLoading: false,
                detailData: tTvShowDetail,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: false,
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
                detailLoading: true,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: false,
              ),
              const DetailState<TvShowDetail, TvShow>(
                detailLoading: false,
                detailData: null,
                detailError: 'Server Failure',
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: false,
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
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: true,
                recData: [],
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: false,
              ),
              DetailState<TvShowDetail, TvShow>(
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: tTvShowList,
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: false,
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
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: true,
                recData: [],
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: false,
              ),
              const DetailState<TvShowDetail, TvShow>(
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: 'Server Failure',
                watchlistLoading: false,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: false,
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
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: true,
                recData: [],
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: false,
              ),
              const DetailState<TvShowDetail, TvShow>(
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: false,
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
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: true,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: false,
              ),
              const DetailState<TvShowDetail, TvShow>(
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: 'Added to Watchlist',
                watchlistMessageError: null,
                status: false,
              ),
              const DetailState<TvShowDetail, TvShow>(
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: true,
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
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: true,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: false,
              ),
              const DetailState<TvShowDetail, TvShow>(
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: null,
                watchlistMessageError: 'Failed to add watchlist',
                status: false,
              ),
              const DetailState<TvShowDetail, TvShow>(
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: false,
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
            detailLoading: false,
            detailData: null,
            detailError: null,
            recLoading: false,
            recData: [],
            recError: null,
            watchlistLoading: false,
            watchlistMessageSuccess: null,
            watchlistMessageError: null,
            status: true,
          ));

          return tvShowDetailCubit;
        },
        act: (bloc) {
          bloc.removeFromWatchlist(tTvShowDetail);
        },
        expect: () => [
              const DetailState<TvShowDetail, TvShow>(
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: true,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: true,
              ),
              const DetailState<TvShowDetail, TvShow>(
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: 'Removed from Watchlist',
                watchlistMessageError: null,
                status: true,
              ),
              const DetailState<TvShowDetail, TvShow>(
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: false,
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
            detailLoading: false,
            detailData: null,
            detailError: null,
            recLoading: false,
            recData: [],
            recError: null,
            watchlistLoading: false,
            watchlistMessageSuccess: null,
            watchlistMessageError: null,
            status: true,
          ));

          return tvShowDetailCubit;
        },
        act: (bloc) {
          bloc.removeFromWatchlist(tTvShowDetail);
        },
        expect: () => [
              const DetailState<TvShowDetail, TvShow>(
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: true,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: true,
              ),
              const DetailState<TvShowDetail, TvShow>(
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: null,
                watchlistMessageError: 'Failed to remove watchlist',
                status: true,
              ),
              const DetailState<TvShowDetail, TvShow>(
                detailLoading: false,
                detailData: null,
                detailError: null,
                recLoading: false,
                recData: [],
                recError: null,
                watchlistLoading: false,
                watchlistMessageSuccess: null,
                watchlistMessageError: null,
                status: true,
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
          detailLoading: false,
          detailData: null,
          detailError: null,
          recLoading: false,
          recData: [],
          recError: null,
          watchlistLoading: false,
          watchlistMessageSuccess: null,
          watchlistMessageError: null,
          status: true,
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
          detailLoading: false,
          detailData: null,
          detailError: null,
          recLoading: false,
          recData: [],
          recError: null,
          watchlistLoading: false,
          watchlistMessageSuccess: null,
          watchlistMessageError: null,
          status: false,
        ),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(tTvShowDetail.id));
        verifyNoMoreInteractions(mockGetWatchListStatus);
      },
    );
  });
}
