import 'package:core/presentation/provider/home/home_notifier.dart';
import 'package:core/utils/type_film_enum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HomeNotifier provider;

  setUp(() {
    provider = HomeNotifier();
  });

  group('checkType', () {
    setUp(() {
      provider.changeFilmType(FilmType.Movies);
    });

    test('should return true when the type is the same', () {
      // arrange
      const tType = FilmType.Movies;

      // act
      final result = provider.checkType(tType);

      // assert
      expect(result, true);
    });

    test('should return false when the type is not the same', () {
      // arrange
      const tType = FilmType.TVshows;

      // act
      final result = provider.checkType(tType);

      // assert
      expect(result, false);
    });
  });

  group('changeType', () {
    test('should change type when changeType get called', () {
      // arrange
      const tType = FilmType.TVshows;

      // act
      provider.changeFilmType(tType);
      final result = provider.filmType;

      // assert
      expect(result, tType);
    });
  });
}
