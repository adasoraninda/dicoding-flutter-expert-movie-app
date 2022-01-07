import 'package:core/domain/entities/tv_shows/tv_show_detail.dart';
import 'package:core/domain/usecases/tv_shows/get_tv_show_detail.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowDetailCubit extends Cubit<ResultState<TvShowDetail>> {
  TvShowDetailCubit(
    this._getTvShowDetail,
  ) : super(ResultState<TvShowDetail>.init());

  final GetTvShowDetail _getTvShowDetail;

  Future<void> fetchTvShowDetail(int id) async {
    emit(state.copyWith(loading: true));

    final detailResult = await _getTvShowDetail.execute(id);

    detailResult.fold(
      (failure) {
        emit(state.copyWith(
          error: failure.message,
          loading: false,
        ));
      },
      (data) {
        emit(state.copyWith(
          data: data,
          error: null,
          loading: false,
        ));
      },
    );
  }
}
