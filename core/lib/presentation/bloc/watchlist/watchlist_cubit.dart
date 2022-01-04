import 'package:core/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:core/domain/usecases/tv_shows/get_watchlist_tv_shows.dart';
import 'package:core/presentation/bloc/watchlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  WatchlistCubit(
    this.getWatchlistTvShows,
    this.getWatchlistMovies,
  ) : super(WatchlistState.init());

  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchlistTvShows getWatchlistTvShows;

  Future<void> fetchWatchlistTvShows() async {
    emit(state.copyWith(tvShowLoading: true));

    final result = await getWatchlistTvShows.execute();

    result.fold(
      (failure) => emit(state.copyWith(
        tvShowError: failure.message,
        tvShowLoading: false,
      )),
      (data) {
        if (data.isEmpty) {
          emit(state.copyWith(
            tvShowData: [],
            tvShowLoading: false,
          ));
        } else {
          emit(state.copyWith(
            tvShowData: data,
            tvShowLoading: false,
          ));
        }
      },
    );
  }

  Future<void> fetchWatchlistMovies() async {
    emit(state.copyWith(movieLoading: true));

    final result = await getWatchlistMovies.execute();

    result.fold(
      (failure) => emit(state.copyWith(
        movieError: failure.message,
        movieLoading: false,
      )),
      (data) {
        if (data.isEmpty) {
          emit(state.copyWith(
            movieData: [],
            movieLoading: false,
          ));
        } else {
          emit(state.copyWith(
            movieData: data,
            movieLoading: false,
          ));
        }
      },
    );
  }
}
