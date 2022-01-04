import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/entities/tv_shows/tv_show_detail.dart';
import 'package:core/domain/usecases/tv_shows/get_tv_show_detail.dart';
import 'package:core/domain/usecases/tv_shows/get_tv_show_recommendations.dart';
import 'package:core/domain/usecases/tv_shows/get_watchlist_tv_show_status.dart';
import 'package:core/domain/usecases/tv_shows/remove_watchlist_tv_show.dart';
import 'package:core/domain/usecases/tv_shows/save_watchlist_tv_show.dart';
import 'package:core/presentation/bloc/detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowDetailCubit extends Cubit<DetailState<TvShowDetail, TvShow>> {
  TvShowDetailCubit(
    this._getTvShowDetail,
    this._getTvShowRecommendations,
    this._saveWatchlist,
    this._removeWatchlist,
    this._getWatchListStatus,
  ) : super(DetailState.init());

  final GetTvShowDetail _getTvShowDetail;
  final SaveWatchlistTvShow _saveWatchlist;
  final RemoveWatchlistTvShow _removeWatchlist;
  final GetWatchlistTvShowStatus _getWatchListStatus;
  final GetTvShowRecommendations _getTvShowRecommendations;

  Future<void> fetchTvShowDetail(int id) async {
    emit(state.copyWith(detailLoading: true));

    final detailResult = await _getTvShowDetail.execute(id);

    detailResult.fold(
      (failure) {
        emit(state.copyWith(
          detailError: failure.message,
          detailLoading: false,
        ));
      },
      (data) {
        emit(state.copyWith(
          detailData: data,
          detailLoading: false,
        ));
      },
    );
  }

  Future<void> fetchTvShowDetailRecommendations(int id) async {
    emit(state.copyWith(recLoading: true));

    final recommendationResult = await _getTvShowRecommendations.execute(id);

    recommendationResult.fold(
      (failure) {
        emit((state.copyWith(
          recError: failure.message,
          recLoading: true,
        )));
      },
      (data) {
        if (data.isEmpty) {
          emit((state.copyWith(
            recData: [],
            recLoading: false,
          )));
        } else {
          emit((state.copyWith(
            recData: data,
            recLoading: false,
          )));
        }
      },
    );
  }

  Future<void> addWatchlist(TvShowDetail tvShow) async {
    emit(state.copyWith(watchlistLoading: true));

    final result = await _saveWatchlist.execute(tvShow);

    await result.fold(
      (failure) async {
        emit(state.copyWith(
          watchlistMessage: failure.message,
          watchlistLoading: false,
        ));
      },
      (data) async {
        emit(state.copyWith(
          watchlistMessage: data,
          watchlistLoading: false,
        ));
      },
    );

    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> removeFromWatchlist(TvShowDetail tvShow) async {
    emit(state.copyWith(watchlistLoading: true));

    final result = await _removeWatchlist.execute(tvShow);

    await result.fold(
      (failure) async {
        emit(state.copyWith(
          watchlistMessage: failure.message,
          watchlistLoading: false,
        ));
      },
      (data) async {
        emit(state.copyWith(
          watchlistMessage: data,
          watchlistLoading: false,
        ));
      },
    );

    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await _getWatchListStatus.execute(id);
    emit(state.copyWith(
      status: result,
      watchlistMessage: null,
    ));
  }
}
