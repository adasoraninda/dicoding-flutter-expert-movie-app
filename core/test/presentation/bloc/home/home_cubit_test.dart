import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/home/home_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HomeCubit homeCubit;

  setUp(() {
    homeCubit = HomeCubit();
  });

  test('Initialize state should be type movies', () {
    expect(homeCubit.state, FilmType.movies);
  });

  blocTest<HomeCubit, FilmType>(
    'Should emit type movies when type is movies',
    build: () => homeCubit,
    act: (bloc) => bloc.type = FilmType.movies,
    expect: () => [FilmType.movies],
  );

  blocTest<HomeCubit, FilmType>(
    'Should emit type tv shows when type is tv shows',
    build: () => homeCubit,
    act: (bloc) => bloc.type = FilmType.tvShows,
    expect: () => [FilmType.tvShows],
  );

  test('[Check movies] Should return true when check type is matches', () {
    // arrange
    homeCubit.type = FilmType.movies;
    // act
    final result = homeCubit.checkType(FilmType.movies);
    // assert
    expect(result, true);
  });

  test('[Check movies] Should return false when check type is not matches', () {
    // arrange
    homeCubit.type = FilmType.tvShows;
    // act
    final result = homeCubit.checkType(FilmType.movies);
    // assert
    expect(result, false);
  });

  test('[Check tvShows] Should return true when check type is matches', () {
    // arrange
    homeCubit.type = FilmType.tvShows;
    // act
    final result = homeCubit.checkType(FilmType.tvShows);
    // assert
    expect(result, true);
  });

  test('[Check tvShows] Should return false when check type is not matches',
      () {
    // arrange
    homeCubit.type = FilmType.movies;
    // act
    final result = homeCubit.checkType(FilmType.tvShows);
    // assert
    expect(result, false);
  });
}
