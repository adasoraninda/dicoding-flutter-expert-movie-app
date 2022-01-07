import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/usecases/tv_shows/get_on_the_air_tv_shows.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnTheAirTvShowsCubit extends Cubit<ResultState<List<TvShow>>> {
  OnTheAirTvShowsCubit(
    this._getOnTheAirTvShows,
  ) : super(ResultState<List<TvShow>>.init());

  final GetOnTheAirTvShows _getOnTheAirTvShows;

  Future<void> fetchOnTheAirTvShows() async {
    emit(state.copyWith(loading: true));

    final result = await _getOnTheAirTvShows.execute();

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
