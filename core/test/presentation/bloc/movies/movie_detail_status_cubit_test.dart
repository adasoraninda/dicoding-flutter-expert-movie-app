import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/movies/movie_detail_status_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MovieDetailStatusCubit movieDetailStatusCubit;
  late MockGetWatchlistMovieStatus mockGetWatchlistMovieStatus;

  setUp(() {
    mockGetWatchlistMovieStatus = MockGetWatchlistMovieStatus();
    movieDetailStatusCubit =
        MovieDetailStatusCubit(mockGetWatchlistMovieStatus);
  });

  test('Initialize state should be false', () {
    expect(movieDetailStatusCubit.state, false);
  });

  blocTest<MovieDetailStatusCubit, bool>(
    'Should return true when status is true',
    build: () {
      when(mockGetWatchlistMovieStatus.execute(tId))
          .thenAnswer((_) async => true);

      return movieDetailStatusCubit;
    },
    act: (bloc) => bloc.loadWatchlistStatus(tId),
    expect: () => [true],
    verify: (bloc) {
      verify(mockGetWatchlistMovieStatus.execute(tId));
      verifyNoMoreInteractions(mockGetWatchlistMovieStatus);
    },
  );

  blocTest<MovieDetailStatusCubit, bool>(
    'Should return false when status is false',
    build: () {
      when(mockGetWatchlistMovieStatus.execute(tId))
          .thenAnswer((_) async => false);

      return movieDetailStatusCubit;
    },
    act: (bloc) => bloc.loadWatchlistStatus(tId),
    expect: () => [false],
    verify: (bloc) {
      verify(mockGetWatchlistMovieStatus.execute(tId));
      verifyNoMoreInteractions(mockGetWatchlistMovieStatus);
    },
  );
}
