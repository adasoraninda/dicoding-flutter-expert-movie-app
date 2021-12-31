import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movies/movie.dart';
import 'package:ditonton/domain/entities/tv_shows/tv_show.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/tv_shows/get_watchlist_tv_shows.dart';
import 'package:flutter/foundation.dart';

class WatchlistNotifier extends ChangeNotifier {
  var _watchlistMovies = <Movie>[];

  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistTvShows = <TvShow>[];

  List<TvShow> get watchlistTvShows => _watchlistTvShows;

  var _watchlistMovieState = RequestState.Empty;

  RequestState get watchlistMovieState => _watchlistMovieState;

  var _watchlistTvShowState = RequestState.Empty;

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
    _watchlistMovieState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _watchlistMovieState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        moviesData.isEmpty
            ? _watchlistMovieState = RequestState.Empty
            : _watchlistMovieState = RequestState.Loaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchWatchlistTvShows() async {
    _watchlistTvShowState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvShows.execute();
    result.fold(
      (failure) {
        _watchlistTvShowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        tvShowsData.isEmpty
            ? _watchlistTvShowState = RequestState.Empty
            : _watchlistTvShowState = RequestState.Loaded;
        _watchlistTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }
}
