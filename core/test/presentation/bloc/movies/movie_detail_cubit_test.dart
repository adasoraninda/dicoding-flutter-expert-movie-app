import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/entities/movies/movie_detail.dart';
import 'package:core/presentation/bloc/detail_state.dart';
import 'package:core/presentation/bloc/movies/movie_detail_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MovieDetailCubit movieDetailCubit;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockSaveWatchlistMovie mockSaveWatchlist;
  late MockRemoveWatchlistMovie mockRemoveWatchlist;
  late MockGetWatchlistMovieStatus mockGetWatchListStatus;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockSaveWatchlist = MockSaveWatchlistMovie();
    mockRemoveWatchlist = MockRemoveWatchlistMovie();
    mockGetWatchListStatus = MockGetWatchlistMovieStatus();
    movieDetailCubit = MovieDetailCubit(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockSaveWatchlist,
      mockRemoveWatchlist,
      mockGetWatchListStatus,
    );
  });

  test('Initialize state should be empty', () {
    expect(movieDetailCubit.state, DetailState<MovieDetail, Movie>.init());
    expect(movieDetailCubit.state.detailData, null);
    expect(movieDetailCubit.state.recData, <Movie>[]);
    expect(movieDetailCubit.state.status, false);
  });

  group('MovieDetail', () {
    blocTest<MovieDetailCubit, DetailState<MovieDetail, Movie>>(
        'Should emit state [loading, result] when fetch data successfull',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(tMovieDetail));
          return movieDetailCubit;
        },
        act: (bloc) {
          bloc.fetchMovieDetail(tId);
        },
        expect: () => [
              const DetailState<MovieDetail, Movie>(
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
              DetailState<MovieDetail, Movie>(
                false,
                tMovieDetail,
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
          verify(mockGetMovieDetail.execute(tId));
          verifyNoMoreInteractions(mockGetMovieDetail);
          verifyZeroInteractions(mockGetMovieRecommendations);
          verifyZeroInteractions(mockSaveWatchlist);
          verifyZeroInteractions(mockRemoveWatchlist);
          verifyZeroInteractions(mockGetWatchListStatus);
        });

    blocTest<MovieDetailCubit, DetailState<MovieDetail, Movie>>(
        'Should emit state [loading, error] when fetch data unsuccessfull',
        build: () {
          when(mockGetMovieDetail.execute(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return movieDetailCubit;
        },
        act: (bloc) {
          bloc.fetchMovieDetail(tId);
        },
        expect: () => [
              const DetailState<MovieDetail, Movie>(
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
              const DetailState<MovieDetail, Movie>(
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
          verify(mockGetMovieDetail.execute(tId));
          verifyNoMoreInteractions(mockGetMovieDetail);
          verifyZeroInteractions(mockGetMovieRecommendations);
          verifyZeroInteractions(mockSaveWatchlist);
          verifyZeroInteractions(mockRemoveWatchlist);
          verifyZeroInteractions(mockGetWatchListStatus);
        });
  });

  group('MovieRecommendations', () {
    blocTest<MovieDetailCubit, DetailState<MovieDetail, Movie>>(
        'Should emit state [loading, result] when fetch data successfull',
        build: () {
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tMovieList));
          return movieDetailCubit;
        },
        act: (bloc) {
          bloc.fetchMovieDetailRecommendations(tId);
        },
        expect: () => [
              const DetailState<MovieDetail, Movie>(
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
              DetailState<MovieDetail, Movie>(
                false,
                null,
                null,
                false,
                tMovieList,
                null,
                false,
                null,
                null,
                false,
              ),
            ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(tId));
          verifyNoMoreInteractions(mockGetMovieRecommendations);
          verifyZeroInteractions(mockGetMovieDetail);
          verifyZeroInteractions(mockSaveWatchlist);
          verifyZeroInteractions(mockRemoveWatchlist);
          verifyZeroInteractions(mockGetWatchListStatus);
        });

    blocTest<MovieDetailCubit, DetailState<MovieDetail, Movie>>(
        'Should emit state [loading, error] when fetch data unsuccessfull',
        build: () {
          when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return movieDetailCubit;
        },
        act: (bloc) {
          bloc.fetchMovieDetailRecommendations(tId);
        },
        expect: () => [
              const DetailState<MovieDetail, Movie>(
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
              const DetailState<MovieDetail, Movie>(
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
          verify(mockGetMovieRecommendations.execute(tId));
          verifyNoMoreInteractions(mockGetMovieRecommendations);
          verifyZeroInteractions(mockGetMovieDetail);
          verifyZeroInteractions(mockSaveWatchlist);
          verifyZeroInteractions(mockRemoveWatchlist);
          verifyZeroInteractions(mockGetWatchListStatus);
        });

    blocTest<MovieDetailCubit, DetailState<MovieDetail, Movie>>(
        'Should emit state [loading, result empty] when fetch data unsuccessfull',
        build: () {
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => const Right([]));
          return movieDetailCubit;
        },
        act: (bloc) {
          bloc.fetchMovieDetailRecommendations(tId);
        },
        expect: () => [
              const DetailState<MovieDetail, Movie>(
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
              const DetailState<MovieDetail, Movie>(
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
          verify(mockGetMovieRecommendations.execute(tId));
          verifyNoMoreInteractions(mockGetMovieRecommendations);
          verifyZeroInteractions(mockGetMovieDetail);
          verifyZeroInteractions(mockSaveWatchlist);
          verifyZeroInteractions(mockRemoveWatchlist);
          verifyZeroInteractions(mockGetWatchListStatus);
        });
  });

  group('Add Watchlist', () {
    blocTest<MovieDetailCubit, DetailState<MovieDetail, Movie>>(
        'Should emit state [loading, success message, true watchlist] when add watchlist successfull',
        build: () {
          when(mockSaveWatchlist.execute(tMovieDetail))
              .thenAnswer((_) async => const Right('Added to Watchlist'));

          when(mockGetWatchListStatus.execute(tMovieDetail.id))
              .thenAnswer((_) async => true);

          return movieDetailCubit;
        },
        act: (bloc) {
          bloc.addWatchlist(tMovieDetail);
        },
        expect: () => [
              const DetailState<MovieDetail, Movie>(
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
              const DetailState<MovieDetail, Movie>(
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
              const DetailState<MovieDetail, Movie>(
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
          verify(mockSaveWatchlist.execute(tMovieDetail));
          verify(mockGetWatchListStatus.execute(tMovieDetail.id));
          verifyNoMoreInteractions(mockSaveWatchlist);
          verifyNoMoreInteractions(mockGetWatchListStatus);
          verifyZeroInteractions(mockGetMovieDetail);
          verifyZeroInteractions(mockGetMovieRecommendations);
          verifyZeroInteractions(mockRemoveWatchlist);
        });

    blocTest<MovieDetailCubit, DetailState<MovieDetail, Movie>>(
        'Should emit state [loading, error message, false watchlist] when add watchlist unsuccessfull',
        build: () {
          when(mockSaveWatchlist.execute(tMovieDetail)).thenAnswer(
              (_) async => const Left(DatabaseFailure('Failed add watchlist')));

          when(mockGetWatchListStatus.execute(tMovieDetail.id))
              .thenAnswer((_) async => false);

          return movieDetailCubit;
        },
        act: (bloc) {
          bloc.addWatchlist(tMovieDetail);
        },
        expect: () => [
              const DetailState<MovieDetail, Movie>(
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
              const DetailState<MovieDetail, Movie>(
                false,
                null,
                null,
                false,
                [],
                null,
                false,
                null,
                'Failed add watchlist',
                false,
              ),
              const DetailState<MovieDetail, Movie>(
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
          verify(mockSaveWatchlist.execute(tMovieDetail));
          verify(mockGetWatchListStatus.execute(tMovieDetail.id));
          verifyNoMoreInteractions(mockSaveWatchlist);
          verifyNoMoreInteractions(mockGetWatchListStatus);
          verifyZeroInteractions(mockGetMovieDetail);
          verifyZeroInteractions(mockGetMovieRecommendations);
          verifyZeroInteractions(mockRemoveWatchlist);
        });
  });

  group('Remove Watchlist', () {
    blocTest<MovieDetailCubit, DetailState<MovieDetail, Movie>>(
        'Should emit state [loading, success message, false watchlist] when remove watchlist successfull',
        build: () {
          when(mockRemoveWatchlist.execute(tMovieDetail))
              .thenAnswer((_) async => const Right('Removed from Watchlist'));

          when(mockGetWatchListStatus.execute(tMovieDetail.id))
              .thenAnswer((_) async => false);

          movieDetailCubit.emit(const DetailState<MovieDetail, Movie>(
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

          return movieDetailCubit;
        },
        act: (bloc) {
          bloc.removeFromWatchlist(tMovieDetail);
        },
        expect: () => [
              const DetailState<MovieDetail, Movie>(
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
              const DetailState<MovieDetail, Movie>(
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
              const DetailState<MovieDetail, Movie>(
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
          verify(mockRemoveWatchlist.execute(tMovieDetail));
          verify(mockGetWatchListStatus.execute(tMovieDetail.id));
          verifyNoMoreInteractions(mockRemoveWatchlist);
          verifyNoMoreInteractions(mockGetWatchListStatus);
          verifyZeroInteractions(mockGetMovieDetail);
          verifyZeroInteractions(mockGetMovieRecommendations);
          verifyZeroInteractions(mockSaveWatchlist);
        });

    blocTest<MovieDetailCubit, DetailState<MovieDetail, Movie>>(
        'Should emit state [loading, error message, true watchlist] when remove watchlist unsuccessfull',
        build: () {
          when(mockRemoveWatchlist.execute(tMovieDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('Failed remove watchlist')));

          when(mockGetWatchListStatus.execute(tMovieDetail.id))
              .thenAnswer((_) async => true);

          movieDetailCubit.emit(const DetailState<MovieDetail, Movie>(
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

          return movieDetailCubit;
        },
        act: (bloc) {
          bloc.removeFromWatchlist(tMovieDetail);
        },
        expect: () => [
              const DetailState<MovieDetail, Movie>(
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
              const DetailState<MovieDetail, Movie>(
                false,
                null,
                null,
                false,
                [],
                null,
                false,
                null,
                'Failed remove watchlist',
                true,
              ),
              const DetailState<MovieDetail, Movie>(
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
          verify(mockRemoveWatchlist.execute(tMovieDetail));
          verify(mockGetWatchListStatus.execute(tMovieDetail.id));
          verifyNoMoreInteractions(mockRemoveWatchlist);
          verifyNoMoreInteractions(mockGetWatchListStatus);
          verifyZeroInteractions(mockGetMovieDetail);
          verifyZeroInteractions(mockGetMovieRecommendations);
          verifyZeroInteractions(mockSaveWatchlist);
        });
  });

  group('Load Watchlist Status', () {
    blocTest<MovieDetailCubit, DetailState<MovieDetail, Movie>>(
      'Should get result true when get watchlist statuss get called',
      build: () {
        when(mockGetWatchListStatus.execute(tMovieDetail.id))
            .thenAnswer((_) async => true);

        return movieDetailCubit;
      },
      act: (bloc) {
        bloc.loadWatchlistStatus(tMovieDetail.id);
      },
      expect: () => [
        const DetailState<MovieDetail, Movie>(
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
        verify(mockGetWatchListStatus.execute(tMovieDetail.id));
        verifyNoMoreInteractions(mockGetWatchListStatus);
      },
    );

    blocTest<MovieDetailCubit, DetailState<MovieDetail, Movie>>(
      'Should get result true when get watchlist statuss get called',
      build: () {
        when(mockGetWatchListStatus.execute(tMovieDetail.id))
            .thenAnswer((_) async => false);

        return movieDetailCubit;
      },
      act: (bloc) {
        bloc.loadWatchlistStatus(tMovieDetail.id);
      },
      expect: () => [
        const DetailState<MovieDetail, Movie>(
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
        verify(mockGetWatchListStatus.execute(tMovieDetail.id));
        verifyNoMoreInteractions(mockGetWatchListStatus);
      },
    );
  });
}
