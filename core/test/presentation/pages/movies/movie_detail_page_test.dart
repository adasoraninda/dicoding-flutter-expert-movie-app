import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/domain/entities/movies/movie_detail.dart';
import 'package:core/presentation/bloc/movies/movie_detail_cubit.dart';
import 'package:core/presentation/bloc/movies/movie_detail_recommendations_cubit.dart';
import 'package:core/presentation/bloc/movies/movie_detail_status_cubit.dart';
import 'package:core/presentation/bloc/movies/movie_detail_watchlist_cubit.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/pages/movies/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieDetailCubit mockMovieDetailCubit;
  late MockMovieDetailRecommendationsCubit mockMovieDetailRecommendationsCubit;
  late MockMovieDetailStatusCubit mockMovieDetailStatusCubit;
  late MockMovieDetailWatchlistCubit mockMovieDetailWatchlistCubit;

  setUp(() {
    mockMovieDetailCubit = MockMovieDetailCubit();
    mockMovieDetailRecommendationsCubit = MockMovieDetailRecommendationsCubit();
    mockMovieDetailStatusCubit = MockMovieDetailStatusCubit();
    mockMovieDetailWatchlistCubit = MockMovieDetailWatchlistCubit();
  });

  Widget _makeTestableWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailCubit>.value(value: mockMovieDetailCubit),
        BlocProvider<MovieDetailRecommendationsCubit>.value(
            value: mockMovieDetailRecommendationsCubit),
        BlocProvider<MovieDetailStatusCubit>.value(
            value: mockMovieDetailStatusCubit),
        BlocProvider<MovieDetailWatchlistCubit>.value(
            value: mockMovieDetailWatchlistCubit),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: MovieDetailPage(id: tId),
        ),
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream).thenAnswer((_) => Stream.value(
        const ResultState<MovieDetail>(
            loading: false, data: tMovieDetail, error: null)));
    when(mockMovieDetailCubit.state).thenReturn(const ResultState<MovieDetail>(
        loading: false, data: tMovieDetail, error: null));

    when(mockMovieDetailRecommendationsCubit.stream).thenAnswer((_) =>
        Stream.value(const ResultState<List<Movie>>(
            loading: false, data: null, error: null)));
    when(mockMovieDetailRecommendationsCubit.state).thenReturn(
        const ResultState<List<Movie>>(
            loading: false, data: null, error: null));

    when(mockMovieDetailStatusCubit.stream)
        .thenAnswer((_) => Stream.value(false));
    when(mockMovieDetailStatusCubit.state).thenReturn(false);

    when(mockMovieDetailWatchlistCubit.stream)
        .thenAnswer((_) => Stream.value(ResultState<String?>.init()));
    when(mockMovieDetailWatchlistCubit.state)
        .thenReturn(ResultState<String?>.init());

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget());

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream).thenAnswer((_) => Stream.value(
        const ResultState<MovieDetail>(
            loading: false, data: tMovieDetail, error: null)));
    when(mockMovieDetailCubit.state).thenReturn(const ResultState<MovieDetail>(
        loading: false, data: tMovieDetail, error: null));

    when(mockMovieDetailRecommendationsCubit.stream).thenAnswer((_) =>
        Stream.value(const ResultState<List<Movie>>(
            loading: false, data: null, error: null)));
    when(mockMovieDetailRecommendationsCubit.state).thenReturn(
        const ResultState<List<Movie>>(
            loading: false, data: null, error: null));

    when(mockMovieDetailStatusCubit.stream)
        .thenAnswer((_) => Stream.value(true));
    when(mockMovieDetailStatusCubit.state).thenReturn(true);

    when(mockMovieDetailWatchlistCubit.stream)
        .thenAnswer((_) => Stream.value(ResultState<String?>.init()));
    when(mockMovieDetailWatchlistCubit.state)
        .thenReturn(ResultState<String?>.init());

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget());

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream).thenAnswer((_) => Stream.value(
        const ResultState<MovieDetail>(
            loading: false, data: tMovieDetail, error: null)));
    when(mockMovieDetailCubit.state).thenReturn(const ResultState<MovieDetail>(
        loading: false, data: tMovieDetail, error: null));

    when(mockMovieDetailRecommendationsCubit.stream).thenAnswer((_) =>
        Stream.value(const ResultState<List<Movie>>(
            loading: false, data: null, error: null)));
    when(mockMovieDetailRecommendationsCubit.state).thenReturn(
        const ResultState<List<Movie>>(
            loading: false, data: null, error: null));

    when(mockMovieDetailStatusCubit.stream)
        .thenAnswer((_) => Stream.value(false));
    when(mockMovieDetailStatusCubit.state).thenReturn(false);

    when(mockMovieDetailWatchlistCubit.stream).thenAnswer((_) => Stream.value(
        const ResultState<String?>(
            loading: false, data: 'Added to Watchlist', error: null)));
    when(mockMovieDetailWatchlistCubit.state).thenReturn(
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
    when(mockMovieDetailCubit.stream).thenAnswer((_) => Stream.value(
        const ResultState<MovieDetail>(
            loading: false, data: tMovieDetail, error: null)));
    when(mockMovieDetailCubit.state).thenReturn(const ResultState<MovieDetail>(
        loading: false, data: tMovieDetail, error: null));

    when(mockMovieDetailRecommendationsCubit.stream).thenAnswer((_) =>
        Stream.value(const ResultState<List<Movie>>(
            loading: false, data: null, error: null)));
    when(mockMovieDetailRecommendationsCubit.state).thenReturn(
        const ResultState<List<Movie>>(
            loading: false, data: null, error: null));

    when(mockMovieDetailStatusCubit.stream)
        .thenAnswer((_) => Stream.value(false));
    when(mockMovieDetailStatusCubit.state).thenReturn(false);

    when(mockMovieDetailWatchlistCubit.stream).thenAnswer((_) => Stream.value(
        const ResultState<String?>(
            loading: false, data: null, error: 'Failed')));
    when(mockMovieDetailWatchlistCubit.state).thenReturn(
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
