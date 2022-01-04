import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../result_state.dart';

class TopRatedMoviesCubit extends Cubit<ResultState<List<Movie>>> {
  TopRatedMoviesCubit(this._getTopRatedMovies) : super(ResultState.init(const <Movie>[]));

  final GetTopRatedMovies _getTopRatedMovies;

  Future<void> fetchTopRatedMovies() async {
    emit(state.copyWith(loading: true));

    final result = await _getTopRatedMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          error: failure.message,
          loading: false,
        ));
      },
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
