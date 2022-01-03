import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/entities/tv_shows/tv_show_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

abstract class TvShowRepository {
  Future<Either<Failure, List<TvShow>>> getOnTheAirTvShows();

  Future<Either<Failure, List<TvShow>>> getPopularTvShows();

  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows();

  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id);

  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id);

  Future<Either<Failure, List<TvShow>>> searchTvShows(String query);

  Future<Either<Failure, String>> saveWatchlist(TvShowDetail tvShow);

  Future<Either<Failure, String>> removeWatchlist(TvShowDetail tvShow);

  Future<bool> isAddedToWatchlist(int id);

  Future<Either<Failure, List<TvShow>>> getWatchlistTvShows();
}
