import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movies/movie_local_data_source.dart';
import 'package:core/data/datasources/movies/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_shows/tv_show_local_data_source.dart';
import 'package:core/data/datasources/tv_shows/tv_show_remote_data_source.dart';
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
import 'package:core/presentation/bloc/movies/movie_detail_cubit.dart';
import 'package:core/presentation/bloc/movies/movie_detail_recommendations_cubit.dart';
import 'package:core/presentation/bloc/movies/movie_detail_status_cubit.dart';
import 'package:core/presentation/bloc/movies/movie_detail_watchlist_cubit.dart';
import 'package:core/presentation/bloc/movies/now_playing_movies_cubit.dart';
import 'package:core/presentation/bloc/movies/popular_movies_cubit.dart';
import 'package:core/presentation/bloc/movies/top_rated_movies_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/on_the_air_tv_shows_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/popular_tv_shows_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/top_rated_tv_shows_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_recommendations_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_status_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_watchlist_cubit.dart';
import 'package:core/presentation/bloc/watchlist/movie_watchlist_cubit.dart';
import 'package:core/presentation/bloc/watchlist/tv_show_watchlist_cubit.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  DatabaseHelper,

  // Datasource Movie
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,

  // Datasource Tv
  TvShowRepository,
  TvShowRemoteDataSource,
  TvShowLocalDataSource,

  // Usecase Movie
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchlistMovieStatus,
  SaveWatchlistMovie,
  RemoveWatchlistMovie,
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetWatchlistMovies,

  // Usecase Tv Show
  GetPopularTvShows,
  GetOnTheAirTvShows,
  GetTopRatedTvShows,
  GetTvShowDetail,
  GetTvShowRecommendations,
  GetWatchlistTvShowStatus,
  SaveWatchlistTvShow,
  RemoveWatchlistTvShow,
  GetWatchlistTvShows,

  // Cubit
  PopularMoviesCubit,
  TopRatedMoviesCubit,
  NowPlayingMoviesCubit,
  MovieDetailCubit,
  MovieDetailStatusCubit,
  MovieDetailRecommendationsCubit,
  MovieDetailWatchlistCubit,
  MovieWatchlistCubit,
  PopularTvShowsCubit,
  TopRatedTvShowsCubit,
  OnTheAirTvShowsCubit,
  TvShowDetailCubit,
  TvShowDetailStatusCubit,
  TvShowDetailRecommendationsCubit,
  TvShowDetailWatchlistCubit,
  TvShowWatchlistCubit,

  SecureHttpClient
])
void main() {}
