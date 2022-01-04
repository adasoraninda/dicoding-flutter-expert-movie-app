import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movies/movie_local_data_source.dart';
import 'package:core/data/datasources/movies/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_shows/tv_show_local_data_source.dart';
import 'package:core/data/datasources/tv_shows/tv_show_remote_data_source.dart';
import 'package:core/data/repositories/movies/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_shows/tv_show_repository_impl.dart';
import 'package:core/domain/repositories/movies/movie_repository.dart';
import 'package:core/domain/repositories/tv_shows/tv_show_repository.dart';
import 'package:core/domain/usecases/movies/get_movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movies/get_popular_movies.dart';
import 'package:core/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:core/domain/usecases/movies/get_watchlist_movie_status.dart';
import 'package:core/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movies/remove_watchlist_movie.dart';
import 'package:core/domain/usecases/movies/save_watchlist_movie.dart';
import 'package:core/domain/usecases/tv_shows/get_on_the_air_tv_shows.dart';
import 'package:core/domain/usecases/tv_shows/get_popular_tv_shows.dart';
import 'package:core/domain/usecases/tv_shows/get_top_rated_tv_shows.dart';
import 'package:core/domain/usecases/tv_shows/get_tv_show_detail.dart';
import 'package:core/domain/usecases/tv_shows/get_tv_show_recommendations.dart';
import 'package:core/domain/usecases/tv_shows/get_watchlist_tv_show_status.dart';
import 'package:core/domain/usecases/tv_shows/get_watchlist_tv_shows.dart';
import 'package:core/domain/usecases/tv_shows/remove_watchlist_tv_show.dart';
import 'package:core/domain/usecases/tv_shows/save_watchlist_tv_show.dart';
import 'package:core/presentation/bloc/home/home_cubit.dart';
import 'package:core/presentation/bloc/movies/movie_detail_cubit.dart';
import 'package:core/presentation/bloc/movies/movie_list_cubit.dart';
import 'package:core/presentation/bloc/movies/popular_movies_cubit.dart';
import 'package:core/presentation/bloc/movies/top_rated_movies_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/popular_tv_shows_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/top_rated_tv_shows_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_list_cubit.dart';
import 'package:core/presentation/bloc/watchlist/watchlist_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';
import 'package:search/presentation/bloc/search/search_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => HomeCubit());
  locator.registerFactory(() => WatchlistCubit(
        locator(),
        locator(),
      ));
  locator.registerFactory(() => SearchBloc(
        locator(),
        locator(),
      ));
  locator.registerFactory(() => MovieListCubit(
        locator(),
        locator(),
        locator(),
      ));
  locator.registerFactory(() => MovieDetailCubit(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ));
  locator.registerFactory(() => PopularMoviesCubit(locator()));
  locator.registerFactory(() => TopRatedMoviesCubit(locator()));

  locator.registerFactory(() => TvShowListCubit(
        locator(),
        locator(),
        locator(),
      ));
  locator.registerFactory(() => TvShowDetailCubit(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ));
  locator.registerFactory(() => TopRatedTvShowsCubit(locator()));
  locator.registerFactory(() => PopularTvShowsCubit(locator()));

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
