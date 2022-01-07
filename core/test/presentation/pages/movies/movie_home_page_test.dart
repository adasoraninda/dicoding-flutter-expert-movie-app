import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/presentation/bloc/movies/now_playing_movies_cubit.dart';
import 'package:core/presentation/bloc/movies/popular_movies_cubit.dart';
import 'package:core/presentation/bloc/movies/top_rated_movies_cubit.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/pages/movies/home_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTopRatedMoviesCubit mockTopRatedMoviesCubit;
  late MockPopularMoviesCubit mockPopularMoviesCubit;
  late MockNowPlayingMoviesCubit mockNowPlayingMoviesCubit;

  setUp(() {
    mockTopRatedMoviesCubit = MockTopRatedMoviesCubit();
    mockPopularMoviesCubit = MockPopularMoviesCubit();
    mockNowPlayingMoviesCubit = MockNowPlayingMoviesCubit();
  });

  Widget _makeTestableWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TopRatedMoviesCubit>.value(value: mockTopRatedMoviesCubit),
        BlocProvider<PopularMoviesCubit>.value(value: mockPopularMoviesCubit),
        BlocProvider<NowPlayingMoviesCubit>.value(
            value: mockNowPlayingMoviesCubit),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: HomeMoviePage(),
        ),
      ),
    );
  }

  testWidgets(
      'Page should display loading in every section (now playing, top rated, popular) section',
      (tester) async {
    when(mockTopRatedMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(const ResultState<List<Movie>>(
              loading: true,
              data: null,
              error: null,
            )));
    when(mockTopRatedMoviesCubit.state)
        .thenReturn(const ResultState<List<Movie>>(
      loading: true,
      data: null,
      error: null,
    ));

    when(mockPopularMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(const ResultState<List<Movie>>(
              loading: true,
              data: null,
              error: null,
            )));
    when(mockPopularMoviesCubit.state)
        .thenReturn(const ResultState<List<Movie>>(
      loading: true,
      data: null,
      error: null,
    ));

    when(mockNowPlayingMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(const ResultState<List<Movie>>(
              loading: true,
              data: null,
              error: null,
            )));
    when(mockNowPlayingMoviesCubit.state)
        .thenReturn(const ResultState<List<Movie>>(
      loading: true,
      data: null,
      error: null,
    ));

    final progressBarFinder1 = find.byKey(const Key('now_playing_loading'));
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
    when(mockTopRatedMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(ResultState<List<Movie>>(
              loading: false,
              data: tMovieList,
              error: null,
            )));
    when(mockTopRatedMoviesCubit.state).thenReturn(ResultState<List<Movie>>(
      loading: false,
      data: tMovieList,
      error: null,
    ));

    when(mockPopularMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(ResultState<List<Movie>>(
              loading: false,
              data: tMovieList,
              error: null,
            )));
    when(mockPopularMoviesCubit.state).thenReturn(ResultState<List<Movie>>(
      loading: false,
      data: tMovieList,
      error: null,
    ));

    when(mockNowPlayingMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(ResultState<List<Movie>>(
              loading: false,
              data: tMovieList,
              error: null,
            )));
    when(mockNowPlayingMoviesCubit.state).thenReturn(ResultState<List<Movie>>(
      loading: false,
      data: tMovieList,
      error: null,
    ));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget());

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets(
      'Page should display text empty in every section (now playing, top rated, popular) section when data is empty',
      (tester) async {
    when(mockTopRatedMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(const ResultState<List<Movie>>(
              loading: false,
              data: [],
              error: null,
            )));
    when(mockTopRatedMoviesCubit.state)
        .thenReturn(const ResultState<List<Movie>>(
      loading: false,
      data: [],
      error: null,
    ));

    when(mockPopularMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(const ResultState<List<Movie>>(
              loading: false,
              data: [],
              error: null,
            )));
    when(mockPopularMoviesCubit.state)
        .thenReturn(const ResultState<List<Movie>>(
      loading: false,
      data: [],
      error: null,
    ));

    when(mockNowPlayingMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(const ResultState<List<Movie>>(
              loading: false,
              data: [],
              error: null,
            )));
    when(mockNowPlayingMoviesCubit.state)
        .thenReturn(const ResultState<List<Movie>>(
      loading: false,
      data: [],
      error: null,
    ));

    final textFinder1 = find.byKey(const Key('text_now_playing_error'));
    final textFinder2 = find.byKey(const Key('text_popular_error'));
    final textFinder3 = find.byKey(const Key('text_top_rated_error'));

    await tester.pumpWidget(_makeTestableWidget());

    expect(textFinder1, findsOneWidget);
    expect(textFinder2, findsOneWidget);
    expect(textFinder3, findsOneWidget);
  });
}
