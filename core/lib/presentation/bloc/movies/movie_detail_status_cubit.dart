import 'package:core/domain/usecases/movies/get_watchlist_movie_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailStatusCubit extends Cubit<bool> {
  MovieDetailStatusCubit(this._getWatchListStatus) : super(false);

  final GetWatchlistMovieStatus _getWatchListStatus;

  Future<void> loadWatchlistStatus(int id) async {
    final result = await _getWatchListStatus.execute(id);
    emit(result);
  }
}
