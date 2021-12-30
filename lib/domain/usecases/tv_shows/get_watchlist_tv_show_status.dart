import 'package:ditonton/domain/repositories/tv_shows/tv_show_repository.dart';

class GetWatchlistTvShowStatus {
  final TvShowRepository repository;

  GetWatchlistTvShowStatus(this.repository);

  Future<bool> execute(int id) {
    return repository.isAddedToWatchlist(id);
  }
}
