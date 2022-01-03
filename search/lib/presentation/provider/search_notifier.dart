import 'package:core/core.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:flutter/foundation.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';

class SearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchTvShows searchTvShows;

  SearchNotifier({
    required this.searchMovies,
    required this.searchTvShows,
  });

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  List<Movie> _searchMoviesResult = [];

  List<Movie> get searchMoviesResult => _searchMoviesResult;

  List<TvShow> _searchTvShowsResult = [];

  List<TvShow> get searchTvShowsResult => _searchTvShowsResult;

  FilmType? _filmType = FilmType.Movies;

  FilmType? get filmType => _filmType;

  String _message = '';

  String get message => _message;

  Future<void> fetchFilmSearch(String query) async {
    if (_filmType == FilmType.Movies) {
      fetchMovieSearch(query);
    } else {
      fetchTvShowSearch(query);
    }
  }

  Future<void> fetchMovieSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _searchMoviesResult = data;
        data.isEmpty
            ? _state = RequestState.empty
            : _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTvShowSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchTvShows.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _searchTvShowsResult = data;
        data.isEmpty
            ? _state = RequestState.empty
            : _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  void changeFilmType(FilmType? type) {
    _filmType = type;
    notifyListeners();
  }
}
