import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/domain/entities/tv_shows/tv_show_detail.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_recommendations_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_status_cubit.dart';
import 'package:core/presentation/bloc/tv_shows/tv_show_detail_watchlist_cubit.dart';
import 'package:core/presentation/pages/tv_shows/tv_show_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvShowDetailCubit mockTvShowDetailCubit;
  late MockTvShowDetailRecommendationsCubit
      mockTvShowDetailRecommendationsCubit;
  late MockTvShowDetailStatusCubit mockTvShowDetailStatusCubit;
  late MockTvShowDetailWatchlistCubit mockTvShowDetailWatchlistCubit;

  setUp(() {
    mockTvShowDetailCubit = MockTvShowDetailCubit();
    mockTvShowDetailRecommendationsCubit =
        MockTvShowDetailRecommendationsCubit();
    mockTvShowDetailStatusCubit = MockTvShowDetailStatusCubit();
    mockTvShowDetailWatchlistCubit = MockTvShowDetailWatchlistCubit();
  });

  Widget _makeTestableWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvShowDetailCubit>.value(value: mockTvShowDetailCubit),
        BlocProvider<TvShowDetailRecommendationsCubit>.value(
            value: mockTvShowDetailRecommendationsCubit),
        BlocProvider<TvShowDetailStatusCubit>.value(
            value: mockTvShowDetailStatusCubit),
        BlocProvider<TvShowDetailWatchlistCubit>.value(
            value: mockTvShowDetailWatchlistCubit),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: TvShowDetailPage(id: tId),
        ),
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockTvShowDetailCubit.stream).thenAnswer((_) => Stream.value(
        const ResultState<TvShowDetail>(
            loading: false, data: tTvShowDetail, error: null)));
    when(mockTvShowDetailCubit.state).thenReturn(
        const ResultState<TvShowDetail>(
            loading: false, data: tTvShowDetail, error: null));

    when(mockTvShowDetailRecommendationsCubit.stream).thenAnswer((_) =>
        Stream.value(const ResultState<List<TvShow>>(
            loading: false, data: null, error: null)));
    when(mockTvShowDetailRecommendationsCubit.state).thenReturn(
        const ResultState<List<TvShow>>(
            loading: false, data: null, error: null));

    when(mockTvShowDetailStatusCubit.stream)
        .thenAnswer((_) => Stream.value(false));
    when(mockTvShowDetailStatusCubit.state).thenReturn(false);

    when(mockTvShowDetailWatchlistCubit.stream)
        .thenAnswer((_) => Stream.value(ResultState<String?>.init()));
    when(mockTvShowDetailWatchlistCubit.state)
        .thenReturn(ResultState<String?>.init());

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget());

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockTvShowDetailCubit.stream).thenAnswer((_) => Stream.value(
        const ResultState<TvShowDetail>(
            loading: false, data: tTvShowDetail, error: null)));
    when(mockTvShowDetailCubit.state).thenReturn(
        const ResultState<TvShowDetail>(
            loading: false, data: tTvShowDetail, error: null));

    when(mockTvShowDetailRecommendationsCubit.stream).thenAnswer((_) =>
        Stream.value(const ResultState<List<TvShow>>(
            loading: false, data: null, error: null)));
    when(mockTvShowDetailRecommendationsCubit.state).thenReturn(
        const ResultState<List<TvShow>>(
            loading: false, data: null, error: null));

    when(mockTvShowDetailStatusCubit.stream)
        .thenAnswer((_) => Stream.value(true));
    when(mockTvShowDetailStatusCubit.state).thenReturn(true);

    when(mockTvShowDetailWatchlistCubit.stream)
        .thenAnswer((_) => Stream.value(ResultState<String?>.init()));
    when(mockTvShowDetailWatchlistCubit.state)
        .thenReturn(ResultState<String?>.init());

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget());

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockTvShowDetailCubit.stream).thenAnswer((_) => Stream.value(
        const ResultState<TvShowDetail>(
            loading: false, data: tTvShowDetail, error: null)));
    when(mockTvShowDetailCubit.state).thenReturn(
        const ResultState<TvShowDetail>(
            loading: false, data: tTvShowDetail, error: null));

    when(mockTvShowDetailRecommendationsCubit.stream).thenAnswer((_) =>
        Stream.value(const ResultState<List<TvShow>>(
            loading: false, data: null, error: null)));
    when(mockTvShowDetailRecommendationsCubit.state).thenReturn(
        const ResultState<List<TvShow>>(
            loading: false, data: null, error: null));

    when(mockTvShowDetailStatusCubit.stream)
        .thenAnswer((_) => Stream.value(false));
    when(mockTvShowDetailStatusCubit.state).thenReturn(false);

    when(mockTvShowDetailWatchlistCubit.stream).thenAnswer((_) => Stream.value(
        const ResultState<String?>(
            loading: false, data: 'Added to Watchlist', error: null)));
    when(mockTvShowDetailWatchlistCubit.state).thenReturn(
        const ResultState<String?>(
            loading: false, data: 'Added to Watchlist', error: null));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget());

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockTvShowDetailCubit.stream).thenAnswer((_) => Stream.value(
        const ResultState<TvShowDetail>(
            loading: false, data: tTvShowDetail, error: null)));
    when(mockTvShowDetailCubit.state).thenReturn(
        const ResultState<TvShowDetail>(
            loading: false, data: tTvShowDetail, error: null));

    when(mockTvShowDetailRecommendationsCubit.stream).thenAnswer((_) =>
        Stream.value(const ResultState<List<TvShow>>(
            loading: false, data: null, error: null)));
    when(mockTvShowDetailRecommendationsCubit.state).thenReturn(
        const ResultState<List<TvShow>>(
            loading: false, data: null, error: null));

    when(mockTvShowDetailStatusCubit.stream)
        .thenAnswer((_) => Stream.value(false));
    when(mockTvShowDetailStatusCubit.state).thenReturn(false);

    when(mockTvShowDetailWatchlistCubit.stream).thenAnswer((_) => Stream.value(
        const ResultState<String?>(
            loading: false, data: null, error: 'Failed')));
    when(mockTvShowDetailWatchlistCubit.state).thenReturn(
        const ResultState<String?>(
            loading: false, data: null, error: 'Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget());

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
