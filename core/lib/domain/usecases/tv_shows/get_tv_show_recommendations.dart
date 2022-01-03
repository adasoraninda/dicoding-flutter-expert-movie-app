import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/repositories/tv_shows/tv_show_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTvShowRecommendations {
  final TvShowRepository repository;

  GetTvShowRecommendations(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(id) {
    return repository.getTvShowRecommendations(id);
  }
}
