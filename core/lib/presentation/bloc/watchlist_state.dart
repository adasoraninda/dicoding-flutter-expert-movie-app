import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:equatable/equatable.dart';

class WatchlistState extends Equatable {
  const WatchlistState(
    this.movieLoading,
    this.tvShowLoading,
    this.movieData,
    this.tvShowData,
    this.movieError,
    this.tvShowError,
  );

  final bool movieLoading;
  final bool tvShowLoading;
  final List<Movie> movieData;
  final List<TvShow> tvShowData;
  final String? movieError;
  final String? tvShowError;

  factory WatchlistState.init() {
    return const WatchlistState(false, false, [], [], null, null);
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
      movieLoading ?? this.movieLoading,
      tvShowLoading ?? this.tvShowLoading,
      movieData ?? this.movieData,
      tvShowData ?? this.tvShowData,
      movieError ?? this.movieError,
      tvShowError ?? this.tvShowError,
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
