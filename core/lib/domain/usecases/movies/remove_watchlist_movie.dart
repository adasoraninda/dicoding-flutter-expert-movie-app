import 'package:core/domain/entities/movies/movie_detail.dart';
import 'package:core/domain/repositories/movies/movie_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class RemoveWatchlistMovie {
  final MovieRepository repository;

  RemoveWatchlistMovie(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
