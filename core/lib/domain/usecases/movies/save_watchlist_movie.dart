import 'package:core/domain/entities/movies/movie_detail.dart';
import 'package:core/domain/repositories/movies/movie_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';


class SaveWatchlistMovie {
  final MovieRepository repository;

  SaveWatchlistMovie(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
