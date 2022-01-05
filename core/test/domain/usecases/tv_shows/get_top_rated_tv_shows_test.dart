import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/usecases/tv_shows/get_top_rated_tv_shows.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvShows usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetTopRatedTvShows(mockTvShowRepository);
  });

  final tTvShows = <TvShow>[];

  test('should get list of tv shows from repository', () async {
    // arrange
    when(mockTvShowRepository.getTopRatedTvShows())
        .thenAnswer((_) async => Right(tTvShows));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvShows));
  });
}
