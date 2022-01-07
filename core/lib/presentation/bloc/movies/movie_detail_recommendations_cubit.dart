import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailRecommendationsCubit extends Cubit<ResultState<List<Movie>>> {
  MovieDetailRecommendationsCubit(
    this._getMovieRecommendations,
  ) : super(ResultState<List<Movie>>.init());

  final GetMovieRecommendations _getMovieRecommendations;

  Future<void> fetchMovieDetailRecommendations(int id) async {
    emit(state.copyWith(
      loading: true,
    ));

    final recommendationResult = await _getMovieRecommendations.execute(id);

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
