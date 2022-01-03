import 'package:core/core.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/entities/tv_shows/tv_show_detail.dart';
import 'package:core/domain/usecases/tv_shows/get_tv_show_detail.dart';
import 'package:core/domain/usecases/tv_shows/get_tv_show_recommendations.dart';
import 'package:core/domain/usecases/tv_shows/get_watchlist_tv_show_status.dart';
import 'package:core/domain/usecases/tv_shows/remove_watchlist_tv_show.dart';
import 'package:core/domain/usecases/tv_shows/save_watchlist_tv_show.dart';
import 'package:flutter/material.dart';

class TvShowDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvShowDetail getTvShowDetail;
  final GetTvShowRecommendations getTvShowRecommendations;
  final GetWatchlistTvShowStatus getWatchListStatus;
  final SaveWatchlistTvShow saveWatchlist;
  final RemoveWatchlistTvShow removeWatchlist;

  TvShowDetailNotifier({
    required this.getTvShowDetail,
    required this.getTvShowRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  late TvShowDetail _tvShow;

  TvShowDetail get tvShow => _tvShow;

  RequestState _tvShowState = RequestState.empty;

  RequestState get tvShowState => _tvShowState;

  List<TvShow> _tvShowRecommendations = [];

  List<TvShow> get tvShowRecommendations => _tvShowRecommendations;

  RequestState _recommendationState = RequestState.empty;

  RequestState get recommendationState => _recommendationState;

  String _message = '';

  String get message => _message;

  bool _isAddedtoWatchlist = false;

  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvShowDetail(int id) async {
    _tvShowState = RequestState.loading;
    notifyListeners();
    final detailResult = await getTvShowDetail.execute(id);
    final recommendationResult = await getTvShowRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvShowState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShow) {
        _recommendationState = RequestState.loading;
        _tvShow = tvShow;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
          },
          (tvShows) {
            tvShows.isEmpty
                ? _recommendationState = RequestState.empty
                : _recommendationState = RequestState.loaded;
            _tvShowRecommendations = tvShows;
          },
        );
        _tvShowState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';

  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvShowDetail tvShow) async {
    final result = await saveWatchlist.execute(tvShow);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> removeFromWatchlist(TvShowDetail tvShow) async {
    final result = await removeWatchlist.execute(tvShow);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
