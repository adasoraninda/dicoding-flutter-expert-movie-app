import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/usecases/tv_shows/get_top_rated_tv_shows.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../result_state.dart';

class TopRatedTvShowsCubit extends Cubit<ResultState<List<TvShow>>> {
  TopRatedTvShowsCubit(this._getTopRatedTvShows) : super(ResultState.init(const <TvShow>[]));

  final GetTopRatedTvShows _getTopRatedTvShows;

  Future<void> fetchTopRatedTvShows() async {
    emit(state.copyWith(loading: true));

    final result = await _getTopRatedTvShows.execute();

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
