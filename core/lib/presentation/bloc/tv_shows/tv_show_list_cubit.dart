import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/usecases/tv_shows/get_on_the_air_tv_shows.dart';
import 'package:core/domain/usecases/tv_shows/get_popular_tv_shows.dart';
import 'package:core/domain/usecases/tv_shows/get_top_rated_tv_shows.dart';
import 'package:core/presentation/bloc/tri_result_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowListCubit extends Cubit<TriResultListState<TvShow>> {
  TvShowListCubit(
    this._getTopRatedTvShows,
    this._getPopularTvShows,
    this._getOnTheAirTvShows,
  ) : super(TriResultListState.init());

  final GetTopRatedTvShows _getTopRatedTvShows;
  final GetOnTheAirTvShows _getOnTheAirTvShows;
  final GetPopularTvShows _getPopularTvShows;

  Future<void> fetchTopRatedTvShows() async {
    emit(state.copyWith(topLoading: true));

    final result = await _getTopRatedTvShows.execute();

    result.fold(
      (failure) => emit(state.copyWith(
        topError: failure.message,
        topLoading: false,
      )),
      (data) {
        if (data.isEmpty) {
          emit(state.copyWith(
            topData: [],
            topLoading: false,
          ));
        } else {
          emit(state.copyWith(
            topData: data,
            topLoading: false,
          ));
        }
      },
    );
  }

  Future<void> fetchPopularTvShows() async {
    emit(state.copyWith(popularLoading: true));

    final result = await _getPopularTvShows.execute();

    result.fold(
      (failure) => emit(state.copyWith(
        popularError: failure.message,
        popularLoading: false,
      )),
      (data) {
        if (data.isEmpty) {
          emit(state.copyWith(
            popularData: [],
            popularLoading: false,
          ));
        } else {
          emit(state.copyWith(
            popularData: data,
            popularLoading: false,
          ));
        }
      },
    );
  }

  Future<void> fetchOnTheAirTvShows() async {
    emit(state.copyWith(nowLoading: true));

    final result = await _getOnTheAirTvShows.execute();

    result.fold(
      (failure) => emit(state.copyWith(
        nowError: failure.message,
        nowLoading: false,
      )),
      (data) {
        if (data.isEmpty) {
          emit(state.copyWith(
            nowData: [],
            nowLoading: false,
          ));
        } else {
          emit(state.copyWith(
            nowData: data,
            nowLoading: false,
          ));
        }
      },
    );
  }
}
