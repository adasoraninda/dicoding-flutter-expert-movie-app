import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/tv_shows/tv_show_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_shows/tv_show_remote_data_source.dart';
import 'package:ditonton/data/repositories/movies/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_shows/tv_show_repository_impl.dart';
import 'package:ditonton/domain/repositories/movies/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_shows/tv_show_repository.dart';
import 'package:ditonton/domain/usecases/movies/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_shows/get_on_the_air_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_shows/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_shows/get_top_rated_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_shows/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tv_shows/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_shows/get_watchlist_tv_show_status.dart';
import 'package:ditonton/domain/usecases/tv_shows/get_watchlist_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_shows/remove_watchlist_tv_show.dart';
import 'package:ditonton/domain/usecases/tv_shows/save_watchlist_tv_show.dart';
import 'package:ditonton/domain/usecases/tv_shows/search_tv_shows.dart';
import 'package:ditonton/presentation/provider/home/home_notifier.dart';
import 'package:ditonton/presentation/provider/movies/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movies/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movies/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movies/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/search/search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_shows/popular_tv_shows_notifier.dart';
import 'package:ditonton/presentation/provider/tv_shows/top_rated_tv_shows_notifier.dart';
import 'package:ditonton/presentation/provider/tv_shows/tv_show_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_shows/tv_show_list_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist/watchlist_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/movies/movie_local_data_source.dart';
import 'data/datasources/movies/movie_remote_data_source.dart';
import 'domain/usecases/movies/get_movie_detail.dart';
import 'domain/usecases/movies/get_movie_recommendations.dart';
import 'domain/usecases/movies/get_now_playing_movies.dart';
import 'domain/usecases/movies/get_popular_movies.dart';
import 'domain/usecases/movies/get_top_rated_movies.dart';
import 'domain/usecases/movies/get_watchlist_movie_status.dart';
import 'domain/usecases/movies/get_watchlist_movies.dart';
import 'domain/usecases/movies/remove_watchlist_movie.dart';
import 'domain/usecases/movies/save_watchlist_movie.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(() => HomeNotifier());
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistNotifier(
      getWatchlistMovies: locator(),
      getWatchlistTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchNotifier(
      searchMovies: locator(),
      searchTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowListNotifier(
      getOnTheAirTvShows: locator(),
      getPopularTvShows: locator(),
      getTopRatedTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowDetailNotifier(
      getTvShowDetail: locator(),
      getTvShowRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvShowsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvShowsNotifier(
      getTopRatedTvShows: locator(),
    ),
  );

  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovieStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetOnTheAirTvShows(locator()));
  locator.registerLazySingleton(() => GetPopularTvShows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowDetail(locator()));
  locator.registerLazySingleton(() => GetTvShowRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvShows(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvShowStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvShow(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvShow(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvShows(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvShowRepository>(
    () => TvShowRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvShowRemoteDataSource>(
      () => TvShowRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvShowLocalDataSource>(
      () => TvShowLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
