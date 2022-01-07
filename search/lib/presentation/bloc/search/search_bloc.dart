import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';
import 'package:search/presentation/bloc/search/search_event.dart';
import 'package:search/presentation/bloc/search/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;
  final SearchTvShows _searchTvShows;

  SearchBloc(
    this._searchMovies,
    this._searchTvShows,
  ) : super(SearchState.init()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      if (state.type == FilmType.movies) {
        emit(state.copyWith(
          movLoading: true,
          movError: null,
        ));
        final result = await _searchMovies.execute(query);

        result.fold(
          (failure) => emit(state.copyWith(
            movError: failure.message,
            movies: [],
            movLoading: false,
          )),
          (data) => emit(state.copyWith(
            movies: data,
            movLoading: false,
          )),
        );
      } else {
        emit(state.copyWith(
          tvLoading: true,
          tvError: null,
        ));
        final result = await _searchTvShows.execute(query);

        result.fold(
          (failure) => emit(state.copyWith(
            tvError: failure.message,
            tvLoading: false,
            tvShows: [],
          )),
          (data) => emit(state.copyWith(
            tvShows: data,
            tvLoading: false,
          )),
        );
      }
    }, transformer: debounce(const Duration(milliseconds: 500)));

    on<OnQuerySubmit>((event, emit) async {
      final query = event.query;
      if (state.type == FilmType.movies) {
        emit(state.copyWith(
          movLoading: true,
          movError: null,
        ));
        final result = await _searchMovies.execute(query);

        result.fold(
          (failure) => emit(state.copyWith(
            movError: failure.message,
            movLoading: false,
            movies: [],
          )),
          (data) => emit(state.copyWith(
            movies: data,
            movLoading: false,
          )),
        );
      } else {
        emit(state.copyWith(
          tvLoading: true,
          tvShows: null,
        ));
        final result = await _searchTvShows.execute(query);

        result.fold(
          (failure) => emit(state.copyWith(
            tvError: failure.message,
            tvLoading: false,
            tvShows: [],
          )),
          (data) => emit(state.copyWith(
            tvShows: data,
            tvLoading: false,
          )),
        );
      }
    });

    on<SearchMovieTypeEvent>((event, emit) {
      emit(state.copyWith(
        type: FilmType.movies,
      ));
    });

    on<SearchTvShowTypeEvent>((event, emit) {
      emit(state.copyWith(
        type: FilmType.tvShows,
      ));
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) =>
        events.distinct().debounceTime(duration).flatMap(mapper);
  }
}
