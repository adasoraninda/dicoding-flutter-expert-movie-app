import 'package:core/domain/entities/tv_shows/tv_show_detail.dart';
import 'package:core/domain/repositories/tv_shows/tv_show_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTvShowDetail {
  final TvShowRepository repository;

  GetTvShowDetail(this.repository);

  Future<Either<Failure, TvShowDetail>> execute(int id) {
    return repository.getTvShowDetail(id);
  }
}
