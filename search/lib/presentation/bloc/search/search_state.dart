import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/utils/film_type_enum.dart';
import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  const SearchState(
    this.type,
    this.movies,
    this.tvShows,
    this.movLoading,
    this.tvLoading,
    this.movError,
    this.tvError,
  );

  final FilmType type;

  final List<Movie> movies;
  final List<TvShow> tvShows;

  final bool movLoading;
  final bool tvLoading;

  final String? movError;
  final String? tvError;

  factory SearchState.init() {
    return const SearchState(
      FilmType.movies,
      [],
      [],
      false,
      false,
      null,
      null,
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
      type ?? this.type,
      movies ?? this.movies,
      tvShows ?? this.tvShows,
      movLoading ?? this.movLoading,
      tvLoading ?? this.tvLoading,
      movError ?? this.movError,
      tvError ?? this.tvError,
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
