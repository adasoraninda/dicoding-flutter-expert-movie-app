import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingMoviesCubit extends Cubit<ResultState<List<Movie>>> {
  NowPlayingMoviesCubit(
    this._getNowPlayingMovies,
  ) : super(ResultState<List<Movie>>.init());

  final GetNowPlayingMovies _getNowPlayingMovies;

  Future<void> fetchNowPlayingMovies() async {
    emit(state.copyWith(loading: true));

    final result = await _getNowPlayingMovies.execute();
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
