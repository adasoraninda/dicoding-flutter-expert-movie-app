import 'dart:ffi';

import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/presentation/bloc/movies/top_rated_movies_cubit.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockCounterCubit extends MockCubit<ResultState<List<Movie>>>
    implements TopRatedMoviesCubit {}

void main() {
  late MockCounterCubit mockCubit;

  setUp(() {
    mockCubit = MockCounterCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MockCounterCubit>(
      create: (context) => mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.value(ResultState.init(const <Movie>[])));
    when(mockCubit.state).thenReturn(ResultState.init(const <Movie>[]));

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));
    await tester.pump();

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockCubit.state)
        .thenReturn(ResultState<List<Movie>>(false, tMovieList, null));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockCubit.state)
        .thenReturn(const ResultState<List<Movie>>(false, [], 'Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when data is Empty',
      (WidgetTester tester) async {
    when(mockCubit.state)
        .thenReturn(const ResultState<List<Movie>>(false, [], null));

    final textFinder = find.byKey(const Key('empty_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
