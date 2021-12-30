import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movies/movie_detail.dart';
import 'package:ditonton/domain/repositories/movies/movie_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
