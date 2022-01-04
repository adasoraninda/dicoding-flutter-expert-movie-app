import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/utils/failure.dart';
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

@GenerateMocks([SearchMovies, SearchTvShows])
void main() {
  late SearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvShows mockSearchTvShows;

  group('SearchMovies', () {
    setUp(() {
      mockSearchMovies = MockSearchMovies();
      mockSearchTvShows = MockSearchTvShows();

      searchBloc = SearchBloc(
        mockSearchMovies,
        mockSearchTvShows,
      );
    });

    test('initial state should be empty', () {
      expect(searchBloc.state, SearchEmpty());
    });

    group('OnQueryChange', () {
      blocTest<SearchBloc, SearchState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSearchMovies.execute(tQuery))
              .thenAnswer((_) async => Right(tMovieList));

          return searchBloc;
        },
        act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          SearchLoading(),
          SearchHasData<Movie>(tMovieList),
        ],
        verify: (bloc) {
          verify(mockSearchMovies.execute(tQuery));
        },
      );

      blocTest<SearchBloc, SearchState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockSearchMovies.execute(tQuery)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return searchBloc;
        },
        act: (bloc) {
          bloc.add(const OnQueryChanged(tQuery));
        },
        wait: const Duration(milliseconds: 500),
        expect: () => [
          SearchLoading(),
          const SearchError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockSearchMovies.execute(tQuery));
        },
      );
    });

    group('OnQuerySubmit', () {});

    group('SearchMovieEvent', () {
      blocTest<SearchBloc, SearchState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSearchMovies.execute(tQuery))
              .thenAnswer((_) async => Right(tMovieList));

          return searchBloc;
        },
        act: (bloc) {
          bloc.add(const OnQueryChanged(tQuery));
          bloc.add(SearchMovieEvent());
        },
        expect: () => [
          SearchLoading(),
          SearchHasData<Movie>(tMovieList),
        ],
        verify: (bloc) {
          verify(mockSearchMovies.execute(tQuery));
        },
      );
    });
  });
}
