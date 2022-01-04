import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/usecases/movies/get_popular_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../result_state.dart';

class PopularMoviesCubit extends Cubit<ResultState<List<Movie>>> {
  PopularMoviesCubit(this._getPopularMoviesCubit)
      : super(ResultState.init(const <Movie>[]));

  final GetPopularMovies _getPopularMoviesCubit;

  Future<void> fetchPopularMovies() async {
    emit(state.copyWith(loading: true));

    final result = await _getPopularMoviesCubit.execute();
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
