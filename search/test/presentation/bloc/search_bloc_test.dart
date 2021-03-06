import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/film_type_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';
import 'package:search/presentation/bloc/search/search_bloc.dart';
import 'package:search/presentation/bloc/search/search_event.dart';
import 'package:search/presentation/bloc/search/search_state.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTvShows])
void main() {
  late SearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvShows mockSearchTvShows;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTvShows = MockSearchTvShows();

    searchBloc = SearchBloc(
      mockSearchMovies,
      mockSearchTvShows,
    );
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchState.init());
    expect(searchBloc.state.tvShows, []);
    expect(searchBloc.state.movies, []);
  });

  group('OnQueryChange', () {
    blocTest<SearchBloc, SearchState>(
      '[Type Movie] Should emit state [init, loading, result] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));

        return searchBloc;
      },
      act: (bloc) {
        bloc.add(SearchMovieTypeEvent());
        bloc.add(const OnQueryChanged(tQuery));
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const SearchState(
          type: FilmType.movies,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
        const SearchState(
          type: FilmType.movies,
          movies: [],
          tvShows: [],
          movLoading: true,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
        SearchState(
          type: FilmType.movies,
          movies: tMovieList,
          tvShows: const [],
          movLoading: false,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
        verifyNoMoreInteractions(mockSearchMovies);
        verifyZeroInteractions(mockSearchTvShows);
      },
    );

    blocTest<SearchBloc, SearchState>(
      '[Type Movie] Should emit state [init, loading, failure] when get search is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return searchBloc;
      },
      act: (bloc) {
        bloc.add(SearchMovieTypeEvent());
        bloc.add(const OnQueryChanged(tQuery));
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const SearchState(
          type: FilmType.movies,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
        const SearchState(
          type: FilmType.movies,
          movies: [],
          tvShows: [],
          movLoading: true,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
        const SearchState(
          type: FilmType.movies,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: false,
          movError: 'Server Failure',
          tvError: null,
        ),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
        verifyNoMoreInteractions(mockSearchMovies);
        verifyZeroInteractions(mockSearchTvShows);
      },
    );

    blocTest<SearchBloc, SearchState>(
      '[Type Tv] Should emit state [init, loading, result] when data is gotten successfully',
      build: () {
        when(mockSearchTvShows.execute(tQuery))
            .thenAnswer((_) async => Right(tTvShowList));

        return searchBloc;
      },
      act: (bloc) {
        bloc.add(SearchTvShowTypeEvent());
        bloc.add(const OnQueryChanged(tQuery));
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const SearchState(
          type: FilmType.tvShows,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
        const SearchState(
          type: FilmType.tvShows,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: true,
          movError: null,
          tvError: null,
        ),
        SearchState(
          type: FilmType.tvShows,
          movies: const [],
          tvShows: tTvShowList,
          movLoading: false,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQuery));
        verifyNoMoreInteractions(mockSearchTvShows);
        verifyZeroInteractions(mockSearchMovies);
      },
    );

    blocTest<SearchBloc, SearchState>(
      '[Type Tv] Should emit state [init, loading, failure] when get search is unsuccessful',
      build: () {
        when(mockSearchTvShows.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return searchBloc;
      },
      act: (bloc) {
        bloc.add(SearchTvShowTypeEvent());
        bloc.add(const OnQueryChanged(tQuery));
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const SearchState(
          type: FilmType.tvShows,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
        const SearchState(
          type: FilmType.tvShows,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: true,
          movError: null,
          tvError: null,
        ),
        const SearchState(
          type: FilmType.tvShows,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: false,
          movError: null,
          tvError: 'Server Failure',
        ),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQuery));
        verifyNoMoreInteractions(mockSearchTvShows);
        verifyZeroInteractions(mockSearchMovies);
      },
    );
  });

  group('OnQuerySubmit', () {
    blocTest<SearchBloc, SearchState>(
      '[Type Movie] Should emit state [init, loading, result] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));

        return searchBloc;
      },
      act: (bloc) {
        bloc.add(SearchMovieTypeEvent());
        bloc.add(const OnQuerySubmit(tQuery));
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const SearchState(
          type: FilmType.movies,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
        const SearchState(
          type: FilmType.movies,
          movies: [],
          tvShows: [],
          movLoading: true,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
        SearchState(
          type: FilmType.movies,
          movies: tMovieList,
          tvShows: const [],
          movLoading: false,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
        verifyNoMoreInteractions(mockSearchMovies);
        verifyZeroInteractions(mockSearchTvShows);
      },
    );

    blocTest<SearchBloc, SearchState>(
      '[Type Movie] Should emit state [init, loading, failure] when get search is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return searchBloc;
      },
      act: (bloc) {
        bloc.add(SearchMovieTypeEvent());
        bloc.add(const OnQuerySubmit(tQuery));
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const SearchState(
          type: FilmType.movies,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
        const SearchState(
          type: FilmType.movies,
          movies: [],
          tvShows: [],
          movLoading: true,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
        const SearchState(
          type: FilmType.movies,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: false,
          movError: 'Server Failure',
          tvError: null,
        ),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
        verifyNoMoreInteractions(mockSearchMovies);
        verifyZeroInteractions(mockSearchTvShows);
      },
    );

    blocTest<SearchBloc, SearchState>(
      '[Type Tv] Should emit state [init, loading, result] when data is gotten successfully',
      build: () {
        when(mockSearchTvShows.execute(tQuery))
            .thenAnswer((_) async => Right(tTvShowList));

        return searchBloc;
      },
      act: (bloc) {
        bloc.add(SearchTvShowTypeEvent());
        bloc.add(const OnQuerySubmit(tQuery));
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const SearchState(
          type: FilmType.tvShows,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
        const SearchState(
          type: FilmType.tvShows,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: true,
          movError: null,
          tvError: null,
        ),
        SearchState(
          type: FilmType.tvShows,
          movies: const [],
          tvShows: tTvShowList,
          movLoading: false,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQuery));
        verifyNoMoreInteractions(mockSearchTvShows);
        verifyZeroInteractions(mockSearchMovies);
      },
    );

    blocTest<SearchBloc, SearchState>(
      '[Type Tv] Should emit state [init, loading, failure] when get search is unsuccessful',
      build: () {
        when(mockSearchTvShows.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return searchBloc;
      },
      act: (bloc) {
        bloc.add(SearchTvShowTypeEvent());
        bloc.add(const OnQuerySubmit(tQuery));
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const SearchState(
          type: FilmType.tvShows,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
        const SearchState(
          type: FilmType.tvShows,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: true,
          movError: null,
          tvError: null,
        ),
        const SearchState(
          type: FilmType.tvShows,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: false,
          movError: null,
          tvError: 'Server Failure',
        ),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQuery));
        verifyNoMoreInteractions(mockSearchTvShows);
        verifyZeroInteractions(mockSearchMovies);
      },
    );
  });

  group('SearchTypeEvent', () {
    blocTest<SearchBloc, SearchState>(
      '[Type Tv] Should emit state FilmType tvShows',
      build: () => searchBloc,
      act: (bloc) {
        bloc.add(SearchTvShowTypeEvent());
      },
      expect: () => [
        const SearchState(
          type: FilmType.tvShows,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      '[Type Movie] Should emit state FilmType movies',
      build: () => searchBloc,
      act: (bloc) {
        bloc.add(SearchMovieTypeEvent());
      },
      expect: () => [
        const SearchState(
          type: FilmType.movies,
          movies: [],
          tvShows: [],
          movLoading: false,
          tvLoading: false,
          movError: null,
          tvError: null,
        ),
      ],
    );
  });
}
