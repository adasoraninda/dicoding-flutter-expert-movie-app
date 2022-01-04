import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movies/get_popular_movies.dart';
import 'package:core/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:core/presentation/bloc/tri_result_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieListCubit extends Cubit<TriResultListState<Movie>> {
  MovieListCubit(
    this._getTopRatedMovies,
    this._getNowPlayingMovies,
    this._getPopularMoviesCubit,
  ) : super(TriResultListState.init());

  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetPopularMovies _getPopularMoviesCubit;
  final GetTopRatedMovies _getTopRatedMovies;

  Future<void> fetchTopRatedMovies() async {
    emit(state.copyWith(topLoading: true));

    final result = await _getTopRatedMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          topError: failure.message,
          topLoading: false,
        ));
      },
      (data) {
        if (data.isEmpty) {
          emit(state.copyWith(
            topData: [],
            topLoading: false,
          ));
        } else {
          emit(state.copyWith(
            topData: data,
            topLoading: false,
          ));
        }
      },
    );
  }

  Future<void> fetchNowPlayingMovies() async {
    emit(state.copyWith(nowLoading: true));

    final result = await _getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          nowError: failure.message,
          nowLoading: false,
        ));
      },
      (data) {
        if (data.isEmpty) {
          emit(state.copyWith(
            nowData: [],
            nowLoading: false,
          ));
        } else {
          emit(state.copyWith(
            nowData: data,
            nowLoading: false,
          ));
        }
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    emit(state.copyWith(popularLoading: true));

    final result = await _getPopularMoviesCubit.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          popularError: failure.message,
          popularLoading: false,
        ));
      },
      (data) {
        if (data.isEmpty) {
          emit(state.copyWith(
            popularData: [],
            popularLoading: false,
          ));
        } else {
          emit(state.copyWith(
            popularData: data,
            popularLoading: false,
          ));
        }
      },
    );
  }
}
