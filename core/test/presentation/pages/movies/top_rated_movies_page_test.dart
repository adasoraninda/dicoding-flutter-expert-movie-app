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

class MockTopRateMoviesCubit extends MockCubit<ResultState<List<Movie>>>
    implements TopRatedMoviesCubit {}

void main() {
  late MockTopRateMoviesCubit mockCubit;

  setUp(() {
    mockCubit = MockTopRateMoviesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MockTopRateMoviesCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  ;

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockCubit.state).thenReturn(ResultState<List<Movie>>(
      loading: false,
      data: tMovieList,
      error: null,
    ));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockCubit.state).thenReturn(const ResultState<List<Movie>>(
      loading: false,
      data: [],
      error: 'Error Message',
    ));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when data is Empty',
      (WidgetTester tester) async {
    when(mockCubit.state).thenReturn(const ResultState<List<Movie>>(
      loading: false,
      data: [],
      error: null,
    ));

    final textFinder = find.byKey(const Key('empty_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
