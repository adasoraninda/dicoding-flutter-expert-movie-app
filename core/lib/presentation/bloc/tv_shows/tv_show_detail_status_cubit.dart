import 'package:core/domain/usecases/tv_shows/get_watchlist_tv_show_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowDetailStatusCubit extends Cubit<bool> {
  TvShowDetailStatusCubit(this._getWatchListStatus) : super(false);

  final GetWatchlistTvShowStatus _getWatchListStatus;

  Future<void> loadWatchlistStatus(int id) async {
    final result = await _getWatchListStatus.execute(id);
    emit(result);
  }
}
