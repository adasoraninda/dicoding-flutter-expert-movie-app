import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:equatable/equatable.dart';

class WatchlistState extends Equatable {
  const WatchlistState({
    required this.movieLoading,
    required this.tvShowLoading,
    required this.movieData,
    required this.tvShowData,
    required this.movieError,
    required this.tvShowError,
  });

  final bool movieLoading;
  final bool tvShowLoading;
  final List<Movie> movieData;
  final List<TvShow> tvShowData;
  final String? movieError;
  final String? tvShowError;

  factory WatchlistState.init() {
    return const WatchlistState(
      movieLoading: false,
      tvShowLoading: false,
      movieData: [],
      tvShowData: [],
      movieError: null,
      tvShowError: null,
    );
  }

  WatchlistState copyWith({
    bool? movieLoading,
    bool? tvShowLoading,
    List<Movie>? movieData,
    List<TvShow>? tvShowData,
    String? movieError,
    String? tvShowError,
  }) {
    return WatchlistState(
      movieLoading: movieLoading ?? this.movieLoading,
      tvShowLoading: tvShowLoading ?? this.tvShowLoading,
      movieData: movieData ?? this.movieData,
      tvShowData: tvShowData ?? this.tvShowData,
      movieError: movieError ?? this.movieError,
      tvShowError: tvShowError ?? this.tvShowError,
    );
  }

  @override
  List<Object?> get props => [
        movieLoading,
        tvShowLoading,
        movieData,
        tvShowData,
        movieError,
        tvShowError,
      ];
}
