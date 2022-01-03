import 'package:core/core.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/usecases/tv_shows/get_top_rated_tv_shows.dart';
import 'package:flutter/material.dart';

class TopRatedTvShowsNotifier extends ChangeNotifier {
  final GetTopRatedTvShows getTopRatedTvShows;

  TopRatedTvShowsNotifier({required this.getTopRatedTvShows});

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  List<TvShow> _tvShows = [];

  List<TvShow> get tvShows => _tvShows;

  String _message = '';

  String get message => _message;

  Future<void> fetchTopRatedTvShows() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvShows.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvShowsData) {
        _tvShows = tvShowsData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
