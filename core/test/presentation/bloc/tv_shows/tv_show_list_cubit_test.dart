import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/presentation/bloc/tri_result_list_state.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_list_cubit.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowListCubit tvShowListCubit;
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;
  late MockGetOnTheAirTvShows mockGetOnTheAirTvShows;
  late MockGetPopularTvShows mockGetPopularTvShows;

  setUp(() {
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    mockGetOnTheAirTvShows = MockGetOnTheAirTvShows();
    mockGetPopularTvShows = MockGetPopularTvShows();
    tvShowListCubit = TvShowListCubit(
      mockGetTopRatedTvShows,
      mockGetPopularTvShows,
      mockGetOnTheAirTvShows,
    );
  });

  test('Initialize state should be empty', () {
    expect(tvShowListCubit.state, TriResultListState<TvShow>.init());
    expect(tvShowListCubit.state.nowData, <TvShow>[]);
    expect(tvShowListCubit.state.topData, <TvShow>[]);
    expect(tvShowListCubit.state.popularData, <TvShow>[]);
  });

  group('OnTheAirTvShows', () {
    blocTest<TvShowListCubit, TriResultListState<TvShow>>(
        'Should emit state [loading, result] when fetch is successfull',
        build: () {
          when(mockGetOnTheAirTvShows.execute())
              .thenAnswer((_) async => Right(tTvShowList));

          return tvShowListCubit;
        },
        act: (bloc) => bloc.fetchOnTheAirTvShows(),
        expect: () => [
              const TriResultListState(
                false,
                <TvShow>[],
                null,
                true,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
              ),
              TriResultListState(
                false,
                const <TvShow>[],
                null,
                false,
                tTvShowList,
                null,
                false,
                const <TvShow>[],
                null,
              ),
            ],
        verify: (bloc) {
          verify(mockGetOnTheAirTvShows.execute());
          verifyNoMoreInteractions(mockGetOnTheAirTvShows);
          verifyZeroInteractions(mockGetPopularTvShows);
          verifyZeroInteractions(mockGetTopRatedTvShows);
        });

    blocTest<TvShowListCubit, TriResultListState<TvShow>>(
        'Should emit state [loading, error] when fetch is unsuccessfull',
        build: () {
          when(mockGetOnTheAirTvShows.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return tvShowListCubit;
        },
        act: (bloc) => bloc.fetchOnTheAirTvShows(),
        expect: () => [
              const TriResultListState(
                false,
                <TvShow>[],
                null,
                true,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
              ),
              const TriResultListState(
                false,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                'Server Failure',
                false,
                <TvShow>[],
                null,
              ),
            ],
        verify: (bloc) {
          verify(mockGetOnTheAirTvShows.execute());
          verifyNoMoreInteractions(mockGetOnTheAirTvShows);
          verifyZeroInteractions(mockGetPopularTvShows);
          verifyZeroInteractions(mockGetTopRatedTvShows);
        });

    blocTest<TvShowListCubit, TriResultListState<TvShow>>(
        'Should emit state [loading, result empty] when fetch is successfull',
        build: () {
          when(mockGetOnTheAirTvShows.execute())
              .thenAnswer((_) async => const Right([]));

          return tvShowListCubit;
        },
        act: (bloc) => bloc.fetchOnTheAirTvShows(),
        expect: () => [
              const TriResultListState(
                false,
                <TvShow>[],
                null,
                true,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
              ),
              const TriResultListState(
                false,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
              ),
            ],
        verify: (bloc) {
          verify(mockGetOnTheAirTvShows.execute());
          verifyNoMoreInteractions(mockGetOnTheAirTvShows);
          verifyZeroInteractions(mockGetPopularTvShows);
          verifyZeroInteractions(mockGetTopRatedTvShows);
        });
  });

  group('TopRatedTvShows', () {
    blocTest<TvShowListCubit, TriResultListState<TvShow>>(
        'Should emit state [loading, result] when fetch is successfull',
        build: () {
          when(mockGetTopRatedTvShows.execute())
              .thenAnswer((_) async => Right(tTvShowList));

          return tvShowListCubit;
        },
        act: (bloc) => bloc.fetchTopRatedTvShows(),
        expect: () => [
              const TriResultListState(
                true,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
              ),
              TriResultListState(
                false,
                tTvShowList,
                null,
                false,
                const <TvShow>[],
                null,
                false,
                const <TvShow>[],
                null,
              ),
            ],
        verify: (bloc) {
          verify(mockGetTopRatedTvShows.execute());
          verifyNoMoreInteractions(mockGetTopRatedTvShows);
          verifyZeroInteractions(mockGetPopularTvShows);
          verifyZeroInteractions(mockGetOnTheAirTvShows);
        });

    blocTest<TvShowListCubit, TriResultListState<TvShow>>(
        'Should emit state [loading, error] when fetch is unsuccessfull',
        build: () {
          when(mockGetTopRatedTvShows.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return tvShowListCubit;
        },
        act: (bloc) => bloc.fetchTopRatedTvShows(),
        expect: () => [
              const TriResultListState(
                true,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
              ),
              const TriResultListState(
                false,
                <TvShow>[],
                'Server Failure',
                false,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
              ),
            ],
        verify: (bloc) {
          verify(mockGetTopRatedTvShows.execute());
          verifyNoMoreInteractions(mockGetTopRatedTvShows);
          verifyZeroInteractions(mockGetPopularTvShows);
          verifyZeroInteractions(mockGetOnTheAirTvShows);
        });

    blocTest<TvShowListCubit, TriResultListState<TvShow>>(
        'Should emit state [loading, result empty] when fetch is successfull',
        build: () {
          when(mockGetTopRatedTvShows.execute())
              .thenAnswer((_) async => const Right([]));

          return tvShowListCubit;
        },
        act: (bloc) => bloc.fetchTopRatedTvShows(),
        expect: () => [
              const TriResultListState(
                true,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
              ),
              const TriResultListState(
                false,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
              ),
            ],
        verify: (bloc) {
          verify(mockGetTopRatedTvShows.execute());
          verifyNoMoreInteractions(mockGetTopRatedTvShows);
          verifyZeroInteractions(mockGetPopularTvShows);
          verifyZeroInteractions(mockGetOnTheAirTvShows);
        });
  });

  group('PopularTvShows', () {
    blocTest<TvShowListCubit, TriResultListState<TvShow>>(
        'Should emit state [loading, result] when fetch is successfull',
        build: () {
          when(mockGetPopularTvShows.execute())
              .thenAnswer((_) async => Right(tTvShowList));

          return tvShowListCubit;
        },
        act: (bloc) => bloc.fetchPopularTvShows(),
        expect: () => [
              const TriResultListState(
                false,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
                true,
                <TvShow>[],
                null,
              ),
              TriResultListState(
                false,
                const <TvShow>[],
                null,
                false,
                const <TvShow>[],
                null,
                false,
                tTvShowList,
                null,
              ),
            ],
        verify: (bloc) {
          verify(mockGetPopularTvShows.execute());
          verifyNoMoreInteractions(mockGetPopularTvShows);
          verifyZeroInteractions(mockGetOnTheAirTvShows);
          verifyZeroInteractions(mockGetTopRatedTvShows);
        });

    blocTest<TvShowListCubit, TriResultListState<TvShow>>(
        'Should emit state [loading, error] when fetch is unsuccessfull',
        build: () {
          when(mockGetPopularTvShows.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return tvShowListCubit;
        },
        act: (bloc) => bloc.fetchPopularTvShows(),
        expect: () => [
              const TriResultListState(
                false,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
                true,
                <TvShow>[],
                null,
              ),
              const TriResultListState(
                false,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                'Server Failure',
              ),
            ],
        verify: (bloc) {
          verify(mockGetPopularTvShows.execute());
          verifyNoMoreInteractions(mockGetPopularTvShows);
          verifyZeroInteractions(mockGetOnTheAirTvShows);
          verifyZeroInteractions(mockGetTopRatedTvShows);
        });

    blocTest<TvShowListCubit, TriResultListState<TvShow>>(
        'Should emit state [loading, result empty] when fetch is successfull',
        build: () {
          when(mockGetPopularTvShows.execute())
              .thenAnswer((_) async => const Right([]));

          return tvShowListCubit;
        },
        act: (bloc) => bloc.fetchPopularTvShows(),
        expect: () => [
              const TriResultListState(
                false,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
                true,
                <TvShow>[],
                null,
              ),
              const TriResultListState(
                false,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
                false,
                <TvShow>[],
                null,
              ),
            ],
        verify: (bloc) {
          verify(mockGetPopularTvShows.execute());
          verifyNoMoreInteractions(mockGetPopularTvShows);
          verifyZeroInteractions(mockGetOnTheAirTvShows);
          verifyZeroInteractions(mockGetTopRatedTvShows);
        });
  });
}
