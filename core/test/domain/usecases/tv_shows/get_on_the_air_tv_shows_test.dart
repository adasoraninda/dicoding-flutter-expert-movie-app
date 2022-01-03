import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  late GetOnTheAirTvShows usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetOnTheAirTvShows(mockTvShowRepository);
  });

  final tTvShows = <TvShow>[];

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTvShowRepository.getOnTheAirTvShows())
        .thenAnswer((_) async => Right(tTvShows));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvShows));
  });
}