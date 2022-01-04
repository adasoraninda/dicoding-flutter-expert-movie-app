import 'package:core/domain/usecases/tv_shows/get_tv_show_recommendations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  late GetTvShowRecommendations usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetTvShowRecommendations(mockTvShowRepository);
  });

  test('should get list of tv show recommendations from the repository',
      () async {
    // arrange
    when(mockTvShowRepository.getTvShowRecommendations(tId))
        .thenAnswer((_) async => Right(tTvShowList));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvShowList));
  });
}
