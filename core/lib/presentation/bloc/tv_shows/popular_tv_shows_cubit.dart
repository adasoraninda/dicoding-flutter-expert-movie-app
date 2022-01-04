import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/usecases/tv_shows/get_popular_tv_shows.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvShowsCubit extends Cubit<ResultState<List<TvShow>>> {
  PopularTvShowsCubit(this._getPopularTvShows)
      : super(ResultState.init(const <TvShow>[]));

  final GetPopularTvShows _getPopularTvShows;

  Future<void> fetchPopularTvShows() async {
    emit(state.copyWith(loading: true));

    final result = await _getPopularTvShows.execute();

    result.fold(
      (failure) => emit(state.copyWith(error: failure.message, loading: false)),
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
