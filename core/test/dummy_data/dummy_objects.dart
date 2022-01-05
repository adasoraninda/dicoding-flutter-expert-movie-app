import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/movies/movie_detail_model.dart';
import 'package:core/data/models/movies/movie_model.dart';
import 'package:core/data/models/movies/movie_response.dart';
import 'package:core/data/models/movies/movie_table.dart';
import 'package:core/data/models/tv_shows/tv_show_detail_model.dart';
import 'package:core/data/models/tv_shows/tv_show_model.dart';
import 'package:core/data/models/tv_shows/tv_show_response.dart';
import 'package:core/data/models/tv_shows/tv_show_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/entities/movies/movie_detail.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/entities/tv_shows/tv_show_detail.dart';

const tQuery = 'Spider-Man';
const tId = 1;

const tMovieModel = MovieModel(
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

final tMovieModelList = [tMovieModel];

const tMovieModelMap = {
  "adult": false,
  "backdrop_path": '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  "genre_ids": [14, 28],
  "id": 557,
  "original_title": 'Spider-Man',
  "overview":
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  "popularity": 60.441,
  "poster_path": '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  "release_date": '2002-05-01',
  "title": 'Spider-Man',
  "video": false,
  "vote_average": 7.2,
  "vote_count": 13507,
};

final tMovieListMap = {
  'results': [tMovieModelMap]
};

final tMoveResponse = MovieResponse(movieList: const <MovieModel>[tMovieModel]);

const tMovie = Movie(
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

final tMovieList = [tMovie];

final tMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

const tMovieDetailResponse = MovieDetailResponse(
  adult: false,
  backdropPath: 'backdropPath',
  budget: 100,
  genres: [GenreModel(id: 1, name: 'Action')],
  homepage: "https://google.com",
  id: 1,
  imdbId: 'imdb1',
  originalLanguage: 'en',
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  revenue: 12000,
  runtime: 120,
  status: 'Status',
  tagline: 'Tagline',
  title: 'title',
  video: false,
  voteAverage: 1,
  voteCount: 1,
);

final tWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const tMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final tMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

const tTvShowModel = TvShowModel(
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

final tTvShowModelList = [tTvShowModel];

final tTvShowModelMap = {
  "backdrop_path": '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  "genre_ids": [14, 28],
  "id": 557,
  "original_name": 'Spider-Man',
  "overview":
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  "popularity": 60.441,
  "poster_path": '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  "first_air_date": '2002-05-01',
  "name": 'Spider-Man',
  "vote_average": 7.2,
  "vote_count": 13507,
};

final tTvShowListMap = {
  'results': [tTvShowModelMap]
};

const tTvShowDetailResponse = TvShowDetailResponse(
  backdropPath: 'backdropPath',
  genres: [GenreModel(id: 1, name: 'Action')],
  homepage: "https://google.com",
  id: 1,
  originalLanguage: 'en',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  episodeRunTime: 120,
  status: 'Status',
  tagline: 'Tagline',
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
);

const tTvShowResponse = TvShowResponse(tvShowList: <TvShowModel>[tTvShowModel]);

const tTvShow = TvShow(
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

final tTvShowList = [tTvShow];

final tTvShowDetail = TvShowDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  episodeRunTime: 120,
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
);

const tWatchlistTvShow = TvShow.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const tTvShowTable = TvShowTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final tTvShowTableMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
