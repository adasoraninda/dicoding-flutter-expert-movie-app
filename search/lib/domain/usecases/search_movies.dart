import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/repositories/movies/movie_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
