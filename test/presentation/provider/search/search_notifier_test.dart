import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/type_film_enum.dart';
import 'package:ditonton/domain/entities/movies/movie.dart';
import 'package:ditonton/domain/entities/tv_shows/tv_show.dart';
import 'package:ditonton/domain/usecases/movies/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_shows/search_tv_shows.dart';
import 'package:ditonton/presentation/provider/search/search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];

  final tTvShowModel = TvShow(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalName: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tTvShowList = <TvShow>[tTvShowModel];

  final tQuery = 'spiderman';

  group('search movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change state to empty when data is empty', () async {
      // arrange
      when(mockSearchMovies.execute(tQuery)).thenAnswer((_) async => Right([]));
      // act
      await provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Empty);
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
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchMoviesResult, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
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
      expect(provider.state, RequestState.Loading);
    });

    test('should change state to empty when data is empty', () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right([]));
      // act
      await provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Empty);
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
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchTvShowsResult, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('change film type', () {
    test('should change film type when changeType get called', () {
      // arrange
      final tType = FilmType.TVshows;
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
      expect(provider.state, RequestState.Loaded);
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
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchMoviesResult, tMovieList);
      expect(resultType, FilmType.Movies);
    });
  });
}
