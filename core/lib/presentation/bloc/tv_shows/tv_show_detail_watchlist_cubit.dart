import 'package:core/domain/entities/tv_shows/tv_show_detail.dart';
import 'package:core/domain/usecases/tv_shows/remove_watchlist_tv_show.dart';
import 'package:core/domain/usecases/tv_shows/save_watchlist_tv_show.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowDetailWatchlistCubit extends Cubit<ResultState<String?>> {
  TvShowDetailWatchlistCubit(
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(ResultState<String?>.init());

  final SaveWatchlistTvShow _saveWatchlist;
  final RemoveWatchlistTvShow _removeWatchlist;

  Future<void> addWatchlist(TvShowDetail tvShow) async {
    emit(state.copyWith(loading: true));

    final result = await _saveWatchlist.execute(tvShow);

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

  Future<void> removeFromWatchlist(TvShowDetail tvShow) async {
    emit(state.copyWith(loading: true));

    final result = await _removeWatchlist.execute(tvShow);

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
