import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/presentation/bloc/movies/movie_list_cubit.dart';
import 'package:core/presentation/bloc/tri_result_list_state.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MovieListCubit movieListCubit;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    movieListCubit = MovieListCubit(
      mockGetTopRatedMovies,
      mockGetNowPlayingMovies,
      mockGetPopularMovies,
    );
  });

  test('Initialize state should be empty', () {
    expect(movieListCubit.state, TriResultListState<Movie>.init());
    expect(movieListCubit.state.nowData, <Movie>[]);
    expect(movieListCubit.state.topData, <Movie>[]);
    expect(movieListCubit.state.popularData, <Movie>[]);
  });

  group('TopRatedMovies', () {
    blocTest<MovieListCubit, TriResultListState<Movie>>(
        'Should emit state [loading, result] when fetch is successfull',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));

          return movieListCubit;
        },
        act: (bloc) => bloc.fetchTopRatedMovies(),
        expect: () => [
              const TriResultListState(
                true,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
              ),
              TriResultListState(
                false,
                tMovieList,
                null,
                false,
                const <Movie>[],
                null,
                false,
                const <Movie>[],
                null,
              ),
            ],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
          verifyNoMoreInteractions(mockGetTopRatedMovies);
          verifyZeroInteractions(mockGetPopularMovies);
          verifyZeroInteractions(mockGetNowPlayingMovies);
        });

    blocTest<MovieListCubit, TriResultListState<Movie>>(
        'Should emit state [loading, error] when fetch is unsuccessfull',
        build: () {
          when(mockGetTopRatedMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return movieListCubit;
        },
        act: (bloc) => bloc.fetchTopRatedMovies(),
        expect: () => [
              const TriResultListState(
                true,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
              ),
              const TriResultListState(
                false,
                <Movie>[],
                'Server Failure',
                false,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
              ),
            ],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
          verifyNoMoreInteractions(mockGetTopRatedMovies);
          verifyZeroInteractions(mockGetPopularMovies);
          verifyZeroInteractions(mockGetNowPlayingMovies);
        });

    blocTest<MovieListCubit, TriResultListState<Movie>>(
        'Should emit state [loading, result empty] when fetch is successfull',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => const Right([]));

          return movieListCubit;
        },
        act: (bloc) => bloc.fetchTopRatedMovies(),
        expect: () => [
              const TriResultListState(
                true,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
              ),
              const TriResultListState(
                false,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
              ),
            ],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
          verifyNoMoreInteractions(mockGetTopRatedMovies);
          verifyZeroInteractions(mockGetPopularMovies);
          verifyZeroInteractions(mockGetNowPlayingMovies);
        });
  });

  group('NowPlayingMovies', () {
    blocTest<MovieListCubit, TriResultListState<Movie>>(
        'Should emit state [loading, result] when fetch is successfull',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));

          return movieListCubit;
        },
        act: (bloc) => bloc.fetchNowPlayingMovies(),
        expect: () => [
              const TriResultListState(
                false,
                <Movie>[],
                null,
                true,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
              ),
              TriResultListState(
                false,
                const <Movie>[],
                null,
                false,
                tMovieList,
                null,
                false,
                const <Movie>[],
                null,
              ),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
          verifyNoMoreInteractions(mockGetNowPlayingMovies);
          verifyZeroInteractions(mockGetPopularMovies);
          verifyZeroInteractions(mockGetTopRatedMovies);
        });

    blocTest<MovieListCubit, TriResultListState<Movie>>(
        'Should emit state [loading, error] when fetch is unsuccessfull',
        build: () {
          when(mockGetNowPlayingMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return movieListCubit;
        },
        act: (bloc) => bloc.fetchNowPlayingMovies(),
        expect: () => [
              const TriResultListState(
                false,
                <Movie>[],
                null,
                true,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
              ),
              const TriResultListState(
                false,
                <Movie>[],
                null,
                false,
                <Movie>[],
                'Server Failure',
                false,
                <Movie>[],
                null,
              ),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
          verifyNoMoreInteractions(mockGetNowPlayingMovies);
          verifyZeroInteractions(mockGetPopularMovies);
          verifyZeroInteractions(mockGetTopRatedMovies);
        });

    blocTest<MovieListCubit, TriResultListState<Movie>>(
        'Should emit state [loading, result empty] when fetch is successfull',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => const Right([]));

          return movieListCubit;
        },
        act: (bloc) => bloc.fetchNowPlayingMovies(),
        expect: () => [
              const TriResultListState(
                false,
                <Movie>[],
                null,
                true,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
              ),
              const TriResultListState(
                false,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
              ),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
          verifyNoMoreInteractions(mockGetNowPlayingMovies);
          verifyZeroInteractions(mockGetPopularMovies);
          verifyZeroInteractions(mockGetTopRatedMovies);
        });
  });

  group('PopularMovies', () {
    blocTest<MovieListCubit, TriResultListState<Movie>>(
        'Should emit state [loading, result] when fetch is successfull',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));

          return movieListCubit;
        },
        act: (bloc) => bloc.fetchPopularMovies(),
        expect: () => [
              const TriResultListState(
                false,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
                true,
                <Movie>[],
                null,
              ),
              TriResultListState(
                false,
                const <Movie>[],
                null,
                false,
                const <Movie>[],
                null,
                false,
                tMovieList,
                null,
              ),
            ],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
          verifyNoMoreInteractions(mockGetPopularMovies);
          verifyZeroInteractions(mockGetNowPlayingMovies);
          verifyZeroInteractions(mockGetTopRatedMovies);
        });

    blocTest<MovieListCubit, TriResultListState<Movie>>(
        'Should emit state [loading, error] when fetch is unsuccessfull',
        build: () {
          when(mockGetPopularMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return movieListCubit;
        },
        act: (bloc) => bloc.fetchPopularMovies(),
        expect: () => [
              const TriResultListState(
                false,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
                true,
                <Movie>[],
                null,
              ),
              const TriResultListState(
                false,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
                false,
                <Movie>[],
                'Server Failure',
              ),
            ],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
          verifyNoMoreInteractions(mockGetPopularMovies);
          verifyZeroInteractions(mockGetNowPlayingMovies);
          verifyZeroInteractions(mockGetTopRatedMovies);
        });

    blocTest<MovieListCubit, TriResultListState<Movie>>(
        'Should emit state [loading, result empty] when fetch is successfull',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => const Right([]));

          return movieListCubit;
        },
        act: (bloc) => bloc.fetchPopularMovies(),
        expect: () => [
              const TriResultListState(
                false,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
                true,
                <Movie>[],
                null,
              ),
              const TriResultListState(
                false,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
                false,
                <Movie>[],
                null,
              ),
            ],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
          verifyNoMoreInteractions(mockGetPopularMovies);
          verifyZeroInteractions(mockGetNowPlayingMovies);
          verifyZeroInteractions(mockGetTopRatedMovies);
        });
  });
}
