import 'package:core/core.dart';
import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/usecases/tv_shows/get_on_the_air_tv_shows.dart';
import 'package:core/domain/usecases/tv_shows/get_popular_tv_shows.dart';
import 'package:core/domain/usecases/tv_shows/get_top_rated_tv_shows.dart';
import 'package:flutter/material.dart';

class TvShowListNotifier extends ChangeNotifier {
  var _onTheAirTvShows = <TvShow>[];

  List<TvShow> get onTheAirTvShows => _onTheAirTvShows;

  RequestState _onTheAirState = RequestState.empty;

  RequestState get onTheAirState => _onTheAirState;

  var _popularTvShows = <TvShow>[];

  List<TvShow> get popularTvShows => _popularTvShows;

  RequestState _popularTvShowsState = RequestState.empty;

  RequestState get popularTvShowsState => _popularTvShowsState;

  var _topRatedTvShows = <TvShow>[];

  List<TvShow> get topRatedTvShows => _topRatedTvShows;

  RequestState _topRatedTvShowsState = RequestState.empty;

  RequestState get topRatedTvShowsState => _topRatedTvShowsState;

  String _message = '';

  String get message => _message;

  TvShowListNotifier({
    required this.getOnTheAirTvShows,
    required this.getPopularTvShows,
    required this.getTopRatedTvShows,
  });

  final GetOnTheAirTvShows getOnTheAirTvShows;
  final GetPopularTvShows getPopularTvShows;
  final GetTopRatedTvShows getTopRatedTvShows;

  Future<void> fetchOnTheAirTvShows() async {
    _onTheAirState = RequestState.loading;
    notifyListeners();

    final result = await getOnTheAirTvShows.execute();
    result.fold(
      (failure) {
        _onTheAirState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _onTheAirState = RequestState.loaded;
        _onTheAirTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvShows() async {
    _popularTvShowsState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvShows.execute();
    result.fold(
      (failure) {
        _popularTvShowsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _popularTvShowsState = RequestState.loaded;
        _popularTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedTvShowsState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvShows.execute();
    result.fold(
      (failure) {
        _topRatedTvShowsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _topRatedTvShowsState = RequestState.loaded;
        _topRatedTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }
}
