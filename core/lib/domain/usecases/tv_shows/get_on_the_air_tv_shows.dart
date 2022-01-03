import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/repositories/tv_shows/tv_show_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetOnTheAirTvShows {
  final TvShowRepository repository;

  GetOnTheAirTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getOnTheAirTvShows();
  }
}
