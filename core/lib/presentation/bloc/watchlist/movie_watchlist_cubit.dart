import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../result_state.dart';

class MovieWatchlistCubit extends Cubit<ResultState<List<Movie>>> {
  MovieWatchlistCubit(
    this._getWatchlistMovies,
  ) : super(ResultState<List<Movie>>.init());

  final GetWatchlistMovies _getWatchlistMovies;

  Future<void> fetchWatchlistMovies() async {
    emit(state.copyWith(loading: true));

    final result = await _getWatchlistMovies.execute();

    result.fold(
      (failure) => emit(state.copyWith(
        error: failure.message,
        loading: false,
      )),
      (data) {
        if (data.isEmpty) {
          emit(state.copyWith(
            data: [],
            loading: false,
          ));
        } else {
          emit(state.copyWith(
            data: data,
            loading: false,
          ));
        }
      },
    );
  }
}
