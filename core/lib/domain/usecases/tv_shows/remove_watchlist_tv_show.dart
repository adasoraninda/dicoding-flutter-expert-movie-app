import 'package:core/domain/entities/tv_shows/tv_show_detail.dart';
import 'package:core/domain/repositories/tv_shows/tv_show_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class RemoveWatchlistTvShow {
  final TvShowRepository repository;

  RemoveWatchlistTvShow(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShow) {
    return repository.removeWatchlist(tvShow);
  }
}
