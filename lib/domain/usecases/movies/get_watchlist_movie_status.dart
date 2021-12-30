import 'package:ditonton/domain/repositories/movies/movie_repository.dart';

class GetWatchlistMovieStatus {
  final MovieRepository repository;

  GetWatchlistMovieStatus(this.repository);

  Future<bool> execute(int id) {
    return repository.isAddedToWatchlist(id);
  }
}
