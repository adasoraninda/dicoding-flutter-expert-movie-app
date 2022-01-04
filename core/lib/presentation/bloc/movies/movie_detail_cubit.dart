import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/entities/movies/movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movies/get_watchlist_movie_status.dart';
import 'package:core/domain/usecases/movies/remove_watchlist_movie.dart';
import 'package:core/domain/usecases/movies/save_watchlist_movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../detail_state.dart';

class MovieDetailCubit extends Cubit<DetailState<MovieDetail, Movie>> {
  MovieDetailCubit(
    this._getMovieDetail,
    this._getMovieRecommendations,
    this._saveWatchlist,
    this._removeWatchlist,
    this._getWatchListStatus,
  ) : super(DetailState.init());

  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  final SaveWatchlistMovie _saveWatchlist;
  final RemoveWatchlistMovie _removeWatchlist;
  final GetWatchlistMovieStatus _getWatchListStatus;

  Future<void> fetchMovieDetail(int id) async {
    emit(state.copyWith(detailLoading: true));

    final detailResult = await _getMovieDetail.execute(id);

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

  Future<void> fetchMovieDetailRecommendations(int id) async {
    emit(state.copyWith(recLoading: true));

    final recommendationResult = await _getMovieRecommendations.execute(id);

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

  Future<void> addWatchlist(MovieDetail movie) async {
    emit(state.copyWith(watchlistLoading: true));

    final result = await _saveWatchlist.execute(movie);

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

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    emit(state.copyWith(watchlistLoading: true));

    final result = await _removeWatchlist.execute(movie);

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

    await loadWatchlistStatus(movie.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await _getWatchListStatus.execute(id);
    emit(state.copyWith(
      status: result,
      watchlistMessage: null,
    ));
  }
}
