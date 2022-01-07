import 'dart:async';

import 'package:core/domain/entities/movies/movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_detail.dart';
import 'package:core/presentation/bloc/movies/movie_detail_recommendations_cubit.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailCubit extends Cubit<ResultState<MovieDetail>> {
  MovieDetailCubit(
    this._getMovieDetail,
  ) : super(ResultState<MovieDetail>.init());

  final GetMovieDetail _getMovieDetail;

  StreamSubscription? _recommendationsScubscriptions;

  Future<void> fetchMovieDetail(int id) async {
    emit(state.copyWith(loading: true));

    final detailResult = await _getMovieDetail.execute(id);

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
