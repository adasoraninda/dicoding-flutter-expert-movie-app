import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/pages/movies/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockPopularMoviesCubit mockCubit;

  setUp(() {
    mockCubit = MockPopularMoviesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MockPopularMoviesCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockCubit.state)
        .thenReturn(const ResultState<List<Movie>>(true, [], null));

    whenListen(bloc, stream)

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));
    await tester.pumpAndSettle();

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockCubit.state)
        .thenReturn(ResultState<List<Movie>>(false, tMovieList, null));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockCubit.state)
        .thenReturn(const ResultState<List<Movie>>(false, [], 'Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when data is Empty',
      (WidgetTester tester) async {
    when(mockCubit.state)
        .thenReturn(const ResultState<List<Movie>>(false, [], null));

    final textFinder = find.byKey(const Key('empty_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
