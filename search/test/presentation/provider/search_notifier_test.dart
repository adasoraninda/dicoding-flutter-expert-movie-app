import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/utils/type_film_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';
import 'package:search/presentation/provider/search_notifier.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_notifier_test.mocks.dart';


@GenerateMocks([SearchMovies, SearchTvShows])
void main() {
  late SearchNotifier provider;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvShows mockSearchTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchMovies = MockSearchMovies();
    mockSearchTvShows = MockSearchTvShows();
    provider = SearchNotifier(
      searchMovies: mockSearchMovies,
      searchTvShows: mockSearchTvShows,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });


  group('search movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.state, RequestState.loading);
    });

    test('should change state to empty when data is empty', () async {
      // arrange
      when(mockSearchMovies.execute(tQuery)).thenAnswer((_) async => const Right([]));
      // act
      await provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.state, RequestState.empty);
      expect(provider.searchMoviesResult, []);
      expect(listenerCallCount, 2);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.state, RequestState.loaded);
      expect(provider.searchMoviesResult, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.state, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('search tv shows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.loading);
    });

    test('should change state to empty when data is empty', () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => const Right([]));
      // act
      await provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.empty);
      expect(provider.searchTvShowsResult, []);
      expect(listenerCallCount, 2);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));
      // act
      await provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.loaded);
      expect(provider.searchTvShowsResult, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('change film type', () {
    test('should change film type when changeType get called', () {
      // arrange
      const tType = FilmType.TVshows;
      // act
      provider.changeFilmType(tType);
      final result = provider.filmType;
      // assert
      expect(result, tType);
    });
  });

  group('fetch film search', () {
    test('should fetch film tv shows when type is tv show', () async {
      // arrange
      provider.changeFilmType(FilmType.TVshows);

      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));

      // act
      await provider.fetchFilmSearch(tQuery);
      final resultType = provider.filmType;

      // assert
      verify(mockSearchTvShows.execute(tQuery)).called(1);
      expect(provider.state, RequestState.loaded);
      expect(provider.searchTvShowsResult, tTvShowList);
      expect(resultType, FilmType.TVshows);
    });

    test('should fetch film movie when type is movie', () async {
      // arrange
      provider.changeFilmType(FilmType.Movies);

      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));

      // act
      await provider.fetchFilmSearch(tQuery);
      final resultType = provider.filmType;

      // assert
      verify(mockSearchMovies.execute(tQuery)).called(1);
      expect(provider.state, RequestState.loaded);
      expect(provider.searchMoviesResult, tMovieList);
      expect(resultType, FilmType.Movies);
    });
  });
}
