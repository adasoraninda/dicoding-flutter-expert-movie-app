import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/bloc/tv_shows/top_rated_tv_shows_cubit.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TopRatedTvShowsCubit topRatedTvShowsCubit;
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;

  setUp(() {
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    topRatedTvShowsCubit = TopRatedTvShowsCubit(mockGetTopRatedTvShows);
  });

  test('Initialize state should be empty', () {
    expect(topRatedTvShowsCubit.state, ResultState.init(const <TvShow>[]));
    expect(topRatedTvShowsCubit.state.data, []);
  });

  blocTest<TopRatedTvShowsCubit, ResultState<List<TvShow>>>(
      'Should emit state [loading, result] when fetch is successfull',
      build: () {
        when(mockGetTopRatedTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));

        return topRatedTvShowsCubit;
      },
      act: (bloc) => bloc.fetchTopRatedTvShows(),
      expect: () => [
            const ResultState(true, <TvShow>[], null),
            ResultState(false, tTvShowList, null),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTvShows.execute());
        verifyNoMoreInteractions(mockGetTopRatedTvShows);
      });

  blocTest<TopRatedTvShowsCubit, ResultState<List<TvShow>>>(
      'Should emit state [loading, error] when fetch is unsuccessfull',
      build: () {
        when(mockGetTopRatedTvShows.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return topRatedTvShowsCubit;
      },
      act: (bloc) => bloc.fetchTopRatedTvShows(),
      expect: () => [
            const ResultState(true, <TvShow>[], null),
            const ResultState(false, <TvShow>[], 'Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTvShows.execute());
        verifyNoMoreInteractions(mockGetTopRatedTvShows);
      });

  blocTest<TopRatedTvShowsCubit, ResultState<List<TvShow>>>(
      'Should emit state [loading, result empty] when fetch is successfull',
      build: () {
        when(mockGetTopRatedTvShows.execute())
            .thenAnswer((_) async => const Right([]));

        return topRatedTvShowsCubit;
      },
      act: (bloc) => bloc.fetchTopRatedTvShows(),
      expect: () => [
            const ResultState(true, <TvShow>[], null),
            const ResultState(false, <TvShow>[], null),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTvShows.execute());
        verifyNoMoreInteractions(mockGetTopRatedTvShows);
      });
}
