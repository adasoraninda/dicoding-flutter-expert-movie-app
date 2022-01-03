import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/repositories/movies/movie_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
