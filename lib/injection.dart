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
import 'package:core/presentation/bloc/movies/popular_movies_cubit.dart';
import 'package:core/presentation/bloc/movies/top_rated_movies_cubit.dart';
import 'package:core/presentation/bloc/movies/now_playing_movies_cubit.dart';
import 'package:core/presentation/bloc/movies/movie_detail_recommendations_cubit.dart';
import 'package:core/presentation/bloc/movies/movie_detail_status_cubit.dart';
import 'package:core/presentation/bloc/movies/movie_detail_watchlist_cubit.dart';
import 'package:core/presentation/bloc/watchlist/movie_watchlist_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/popular_tv_shows_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/top_rated_tv_shows_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_recommendations_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_status_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_watchlist_cubit.dart';
import 'package:core/presentation/bloc/watchlist/tv_show_watchlist_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/on_the_air_tv_shows_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';
import 'package:search/presentation/bloc/search/search_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => HomeCubit());
  locator.registerFactory(() => SearchBloc(
        locator(),
        locator(),
      ));
  locator.registerFactory(() => MovieDetailCubit(
        locator(),
      ));
  locator.registerFactory(() => MovieDetailRecommendationsCubit(locator()));
  locator.registerFactory(() => MovieDetailStatusCubit(locator()));
  locator
      .registerFactory(() => MovieDetailWatchlistCubit(locator(), locator()));
  locator.registerFactory(() => MovieWatchlistCubit(locator()));
  locator.registerFactory(() => PopularMoviesCubit(locator()));
  locator.registerFactory(() => TopRatedMoviesCubit(locator()));
  locator.registerFactory(() => NowPlayingMoviesCubit(locator()));
  locator.registerFactory(() => TvShowDetailCubit(
        locator(),
      ));
  locator.registerFactory(() => TopRatedTvShowsCubit(locator()));
  locator.registerFactory(() => PopularTvShowsCubit(locator()));
  locator.registerFactory(() => OnTheAirTvShowsCubit(locator()));
  locator.registerFactory(() => TvShowDetailRecommendationsCubit(locator()));
  locator.registerFactory(() => TvShowDetailStatusCubit(locator()));
  locator
      .registerFactory(() => TvShowDetailWatchlistCubit(locator(), locator()));
  locator.registerFactory(() => TvShowWatchlistCubit(locator()));
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
  locator.registerLazySingleton(() => SecureHttpClient.build([
        '549e6939a30144a61b1bf55da5b0cde7f81b394d8b7db197c0b7501efc15a285',
        'f55f9ffcb83c73453261601c7e044db15a0f034b93c05830f28635ef889cf670',
        '87dcd4dc74640a322cd205552506d1be64f12596258096544986b4850bc72706',
        '28689b30e4c306aab53b027b29e36ad6dd1dcf4b953994482ca84bdc1ecac996',
      ]));
}
