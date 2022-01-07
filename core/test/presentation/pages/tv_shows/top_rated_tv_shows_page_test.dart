import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/bloc/tv_shows/top_rated_tv_shows_cubit.dart';
import 'package:core/presentation/pages/tv_shows/top_rated_tv_show_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTopRatedTvShowsCubit mockCubit;

  setUp(() {
    mockCubit = MockTopRatedTvShowsCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvShowsCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.value(const ResultState<List<TvShow>>(
              loading: true,
              data: null,
              error: null,
            )));
    when(mockCubit.state).thenReturn(const ResultState<List<TvShow>>(
      loading: true,
      data: null,
      error: null,
    ));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display list when data is loaded',
      (WidgetTester tester) async {
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.value(ResultState<List<TvShow>>(
              loading: false,
              data: tTvShowList,
              error: null,
            )));

    when(mockCubit.state).thenReturn(ResultState<List<TvShow>>(
      loading: false,
      data: tTvShowList,
      error: null,
    ));

    when(mockCubit.fetchTopRatedTvShows()).thenAnswer((_) => Future.value());

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.value(const ResultState<List<TvShow>>(
              loading: false,
              data: null,
              error: 'Error Message',
            )));
    when(mockCubit.state).thenReturn(const ResultState<List<TvShow>>(
      loading: false,
      data: null,
      error: 'Error Message',
    ));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when data is Empty',
      (WidgetTester tester) async {
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.value(const ResultState<List<TvShow>>(
              loading: false,
              data: [],
              error: null,
            )));
    when(mockCubit.state).thenReturn(const ResultState<List<TvShow>>(
      loading: false,
      data: [],
      error: null,
    ));

    final textFinder = find.byKey(const Key('empty_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });
}
