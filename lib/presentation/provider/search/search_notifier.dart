import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/type_film_enum.dart';
import 'package:ditonton/domain/entities/movies/movie.dart';
import 'package:ditonton/domain/entities/tv_shows/tv_show.dart';
import 'package:ditonton/domain/usecases/movies/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_shows/search_tv_shows.dart';
import 'package:flutter/foundation.dart';

class SearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchTvShows searchTvShows;

  SearchNotifier({
    required this.searchMovies,
    required this.searchTvShows,
  });

  RequestState _state = RequestState.Empty;

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
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchMoviesResult = data;
        data.isEmpty
            ? _state = RequestState.Empty
            : _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTvShowSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvShows.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchTvShowsResult = data;
        data.isEmpty
            ? _state = RequestState.Empty
            : _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  void changeFilmType(FilmType? type) {
    _filmType = type;
    notifyListeners();
  }
}
