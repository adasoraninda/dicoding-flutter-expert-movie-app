import 'package:core/domain/usecases/tv_shows/get_on_the_air_tv_shows.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  late GetOnTheAirTvShows usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetOnTheAirTvShows(mockTvShowRepository);
  });

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTvShowRepository.getOnTheAirTvShows())
        .thenAnswer((_) async => Right(tTvShowList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvShowList));
  });
}
