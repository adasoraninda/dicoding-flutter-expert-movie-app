import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/repositories/tv_shows/tv_show_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class SearchTvShows {
  final TvShowRepository repository;

  SearchTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(String query) {
    return repository.searchTvShows(query);
  }
}
