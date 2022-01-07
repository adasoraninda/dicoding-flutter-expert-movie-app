import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_status_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowDetailStatusCubit tvShowDetailStatusCubit;
  late MockGetWatchlistTvShowStatus mockGetWatchlistTvShowStatus;

  setUp(() {
    mockGetWatchlistTvShowStatus = MockGetWatchlistTvShowStatus();
    tvShowDetailStatusCubit =
        TvShowDetailStatusCubit(mockGetWatchlistTvShowStatus);
  });

  test('Initialize state should be false', () {
    expect(tvShowDetailStatusCubit.state, false);
  });

  blocTest<TvShowDetailStatusCubit, bool>(
    'Should return true when status is true',
    build: () {
      when(mockGetWatchlistTvShowStatus.execute(tTvShowDetail.id))
          .thenAnswer((_) async => true);

      return tvShowDetailStatusCubit;
    },
    act: (bloc) => bloc.loadWatchlistStatus(tTvShowDetail.id),
    expect: () => [true],
    verify: (bloc) {
      verify(mockGetWatchlistTvShowStatus.execute(tTvShowDetail.id));
      verifyNoMoreInteractions(mockGetWatchlistTvShowStatus);
    },
  );

  blocTest<TvShowDetailStatusCubit, bool>(
    'Should return false when status is false',
    build: () {
      when(mockGetWatchlistTvShowStatus.execute(tTvShowDetail.id))
          .thenAnswer((_) async => false);

      return tvShowDetailStatusCubit;
    },
    act: (bloc) => bloc.loadWatchlistStatus(tTvShowDetail.id),
    expect: () => [false],
    verify: (bloc) {
      verify(mockGetWatchlistTvShowStatus.execute(tTvShowDetail.id));
      verifyNoMoreInteractions(mockGetWatchlistTvShowStatus);
    },
  );
}
