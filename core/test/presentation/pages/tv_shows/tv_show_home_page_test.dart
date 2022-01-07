import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/bloc/tv_shows/on_the_air_tv_shows_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/popular_tv_shows_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/top_rated_tv_shows_cubit.dart';
import 'package:core/presentation/pages/tv_shows/home_tv_show_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTopRatedTvShowsCubit mockTopRatedTvShowsCubit;
  late MockPopularTvShowsCubit mockPopularTvShowsCubit;
  late MockOnTheAirTvShowsCubit mockOnTheAirTvShowsCubit;

  setUp(() {
    mockTopRatedTvShowsCubit = MockTopRatedTvShowsCubit();
    mockPopularTvShowsCubit = MockPopularTvShowsCubit();
    mockOnTheAirTvShowsCubit = MockOnTheAirTvShowsCubit();
  });

  Widget _makeTestableWidget() {
    var blocProvider = BlocProvider<OnTheAirTvShowsCubit>.value(
        value: mockOnTheAirTvShowsCubit);
    return MultiBlocProvider(
      providers: [
        BlocProvider<TopRatedTvShowsCubit>.value(
            value: mockTopRatedTvShowsCubit),
        BlocProvider<PopularTvShowsCubit>.value(value: mockPopularTvShowsCubit),
        blocProvider,
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: HomeTvShowPage(),
        ),
      ),
    );
  }

  testWidgets(
      'Page should display loading in every section (now playing, top rated, popular) section',
      (tester) async {
    when(mockTopRatedTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(const ResultState<List<TvShow>>(
              loading: true,
              data: null,
              error: null,
            )));
    when(mockTopRatedTvShowsCubit.state)
        .thenReturn(const ResultState<List<TvShow>>(
      loading: true,
      data: null,
      error: null,
    ));

    when(mockPopularTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(const ResultState<List<TvShow>>(
              loading: true,
              data: null,
              error: null,
            )));
    when(mockPopularTvShowsCubit.state)
        .thenReturn(const ResultState<List<TvShow>>(
      loading: true,
      data: null,
      error: null,
    ));

    when(mockOnTheAirTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(const ResultState<List<TvShow>>(
              loading: true,
              data: null,
              error: null,
            )));
    when(mockOnTheAirTvShowsCubit.state)
        .thenReturn(const ResultState<List<TvShow>>(
      loading: true,
      data: null,
      error: null,
    ));

    final progressBarFinder1 = find.byKey(const Key('on_the_air_loading'));
    final progressBarFinder2 = find.byKey(const Key('popular_loading'));
    final progressBarFinder3 = find.byKey(const Key('top_rated_loading'));

    await tester.pumpWidget(_makeTestableWidget());

    expect(progressBarFinder1, findsOneWidget);
    expect(progressBarFinder2, findsOneWidget);
    expect(progressBarFinder3, findsOneWidget);
  });

  testWidgets(
      'Page should display list view in every section (now playing, top rated, popular) section when fetch data successfully',
      (tester) async {
    when(mockTopRatedTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(ResultState<List<TvShow>>(
              loading: false,
              data: tTvShowList,
              error: null,
            )));
    when(mockTopRatedTvShowsCubit.state).thenReturn(ResultState<List<TvShow>>(
      loading: false,
      data: tTvShowList,
      error: null,
    ));

    when(mockPopularTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(ResultState<List<TvShow>>(
              loading: false,
              data: tTvShowList,
              error: null,
            )));
    when(mockPopularTvShowsCubit.state).thenReturn(ResultState<List<TvShow>>(
      loading: false,
      data: tTvShowList,
      error: null,
    ));

    when(mockOnTheAirTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(ResultState<List<TvShow>>(
              loading: false,
              data: tTvShowList,
              error: null,
            )));
    when(mockOnTheAirTvShowsCubit.state).thenReturn(ResultState<List<TvShow>>(
      loading: false,
      data: tTvShowList,
      error: null,
    ));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget());

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets(
      'Page should display text empty in every section (now playing, top rated, popular) section when data is empty',
      (tester) async {
    when(mockTopRatedTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(const ResultState<List<TvShow>>(
              loading: false,
              data: [],
              error: null,
            )));
    when(mockTopRatedTvShowsCubit.state)
        .thenReturn(const ResultState<List<TvShow>>(
      loading: false,
      data: [],
      error: null,
    ));

    when(mockPopularTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(const ResultState<List<TvShow>>(
              loading: false,
              data: [],
              error: null,
            )));
    when(mockPopularTvShowsCubit.state)
        .thenReturn(const ResultState<List<TvShow>>(
      loading: false,
      data: [],
      error: null,
    ));

    when(mockOnTheAirTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(const ResultState<List<TvShow>>(
              loading: false,
              data: [],
              error: null,
            )));
    when(mockOnTheAirTvShowsCubit.state)
        .thenReturn(const ResultState<List<TvShow>>(
      loading: false,
      data: [],
      error: null,
    ));

    final textFinder1 = find.byKey(const Key('text_on_the_air_error'));
    final textFinder2 = find.byKey(const Key('text_popular_error'));
    final textFinder3 = find.byKey(const Key('text_top_rated_error'));

    await tester.pumpWidget(_makeTestableWidget());

    expect(textFinder1, findsOneWidget);
    expect(textFinder2, findsOneWidget);
    expect(textFinder3, findsOneWidget);
  });
}
