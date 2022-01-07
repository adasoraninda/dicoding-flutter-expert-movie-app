import 'package:core/domain/entities/movies/movie_detail.dart';
import 'package:core/domain/usecases/movies/remove_watchlist_movie.dart';
import 'package:core/domain/usecases/movies/save_watchlist_movie.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailWatchlistCubit extends Cubit<ResultState<String?>> {
  MovieDetailWatchlistCubit(
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(ResultState<String?>.init());

  final SaveWatchlistMovie _saveWatchlist;
  final RemoveWatchlistMovie _removeWatchlist;

  Future<void> addWatchlist(MovieDetail movie) async {
    emit(state.copyWith(loading: true));

    final result = await _saveWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        emit(state.copyWith(
          error: failure.message,
          loading: false,
        ));
      },
      (data) async {
        emit(state.copyWith(
          data: data,
          loading: false,
        ));
      },
    );
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    emit(state.copyWith(loading: true));

    final result = await _removeWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        emit(state.copyWith(
          error: failure.message,
          loading: false,
        ));
      },
      (data) async {
        emit(state.copyWith(
          data: data,
          loading: false,
        ));
      },
    );
  }
}
