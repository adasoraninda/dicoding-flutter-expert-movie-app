import 'package:core/core.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:core/domain/usecases/tv_shows/get_watchlist_tv_shows.dart';
import 'package:flutter/foundation.dart';

class WatchlistNotifier extends ChangeNotifier {
  var _watchlistMovies = <Movie>[];

  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistTvShows = <TvShow>[];

  List<TvShow> get watchlistTvShows => _watchlistTvShows;

  var _watchlistMovieState = RequestState.empty;

  RequestState get watchlistMovieState => _watchlistMovieState;

  var _watchlistTvShowState = RequestState.empty;

  RequestState get watchlistTvShowState => _watchlistTvShowState;

  String _message = '';

  String get message => _message;

  WatchlistNotifier({
    required this.getWatchlistMovies,
    required this.getWatchlistTvShows,
  });

  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchlistTvShows getWatchlistTvShows;

  Future<void> fetchWatchlistMovies() async {
    _watchlistMovieState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _watchlistMovieState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        moviesData.isEmpty
            ? _watchlistMovieState = RequestState.empty
            : _watchlistMovieState = RequestState.loaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchWatchlistTvShows() async {
    _watchlistTvShowState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistTvShows.execute();
    result.fold(
      (failure) {
        _watchlistTvShowState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        tvShowsData.isEmpty
            ? _watchlistTvShowState = RequestState.empty
            : _watchlistTvShowState = RequestState.loaded;
        _watchlistTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }
}
