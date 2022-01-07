import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/utils/film_type_enum.dart';
import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  const SearchState({
    required this.type,
    required this.movies,
    required this.tvShows,
    required this.movLoading,
    required this.tvLoading,
    required this.movError,
    required this.tvError,
  });

  final FilmType type;

  final List<Movie> movies;
  final List<TvShow> tvShows;

  final bool movLoading;
  final bool tvLoading;

  final String? movError;
  final String? tvError;

  factory SearchState.init() {
    return const SearchState(
      type: FilmType.movies,
      movies: [],
      tvShows: [],
      movLoading: false,
      tvLoading: false,
      movError: null,
      tvError: null,
    );
  }

  SearchState copyWith({
    FilmType? type,
    List<Movie>? movies,
    List<TvShow>? tvShows,
    bool? movLoading,
    bool? tvLoading,
    String? movError,
    String? tvError,
  }) {
    return SearchState(
      type: type ?? this.type,
      movies: movies ?? this.movies,
      tvShows: tvShows ?? this.tvShows,
      movLoading: movLoading ?? this.movLoading,
      tvLoading: tvLoading ?? this.tvLoading,
      movError: movError,
      tvError: tvError,
    );
  }

  @override
  List<Object?> get props => [
        type,
        movies,
        tvShows,
        movLoading,
        tvLoading,
        movError,
        tvError,
      ];
}
