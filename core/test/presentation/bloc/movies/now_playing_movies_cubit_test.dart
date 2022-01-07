import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/presentation/bloc/movies/now_playing_movies_cubit.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late NowPlayingMoviesCubit nowPayingMoviesCubit;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPayingMoviesCubit = NowPlayingMoviesCubit(mockGetNowPlayingMovies);
  });

  test('Initialize state should be null', () {
    expect(nowPayingMoviesCubit.state, ResultState<List<Movie>>.init());
    expect(nowPayingMoviesCubit.state.data, null);
  });

  blocTest<NowPlayingMoviesCubit, ResultState<List<Movie>>>(
      'Should emit state [loading, result] when fetch is successfull',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        return nowPayingMoviesCubit;
      },
      act: (bloc) => bloc.fetchNowPlayingMovies(),
      expect: () => [
            const ResultState<List<Movie>>(
              loading: true,
              data: null,
              error: null,
            ),
            ResultState<List<Movie>>(
              loading: false,
              data: tMovieList,
              error: null,
            ),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
        verifyNoMoreInteractions(mockGetNowPlayingMovies);
      });

  blocTest<NowPlayingMoviesCubit, ResultState<List<Movie>>>(
      'Should emit state [loading, error] when fetch is unsuccessfull',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return nowPayingMoviesCubit;
      },
      act: (bloc) => bloc.fetchNowPlayingMovies(),
      expect: () => [
            const ResultState<List<Movie>>(
              loading: true,
              data: null,
              error: null,
            ),
            const ResultState<List<Movie>>(
              loading: false,
              data: null,
              error: 'Server Failure',
            ),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
        verifyNoMoreInteractions(mockGetNowPlayingMovies);
      });

  blocTest<NowPlayingMoviesCubit, ResultState<List<Movie>>>(
      'Should emit state [loading, result empty] when fetch is successfull',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => const Right([]));

        return nowPayingMoviesCubit;
      },
      act: (bloc) => bloc.fetchNowPlayingMovies(),
      expect: () => [
            const ResultState<List<Movie>>(
              loading: true,
              data: null,
              error: null,
            ),
            const ResultState<List<Movie>>(
              loading: false,
              data: <Movie>[],
              error: null,
            ),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
        verifyNoMoreInteractions(mockGetNowPlayingMovies);
      });
}
