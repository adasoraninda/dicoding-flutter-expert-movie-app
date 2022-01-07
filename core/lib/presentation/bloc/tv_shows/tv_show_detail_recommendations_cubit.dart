import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/usecases/tv_shows/get_tv_show_recommendations.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowDetailRecommendationsCubit
    extends Cubit<ResultState<List<TvShow>>> {
  TvShowDetailRecommendationsCubit(
    this._getTvShowRecommendations,
  ) : super(ResultState<List<TvShow>>.init());

  final GetTvShowRecommendations _getTvShowRecommendations;

  Future<void> fetchTvShowDetailRecommendations(int id) async {
    emit(state.copyWith(
      loading: true,
    ));

    final recommendationResult = await _getTvShowRecommendations.execute(id);

    recommendationResult.fold(
      (failure) {
        emit((state.copyWith(
          error: failure.message,
          loading: false,
        )));
      },
      (data) {
        if (data.isEmpty) {
          emit((state.copyWith(
            data: [],
            error: null,
            loading: false,
          )));
        } else {
          emit((state.copyWith(
            data: data,
            error: null,
            loading: false,
          )));
        }
      },
    );
  }
}
