import '../../../../core/lib/utils/state_enum.dart';
import 'package:ditonton/domain/entities/tv_shows/tv_show.dart';
import 'package:ditonton/presentation/pages/tv_shows/top_rated_tv_show_page.dart';
import 'package:ditonton/presentation/provider/tv_shows/top_rated_tv_shows_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_tv_shows_page_test.mocks.dart';

void main() {
  late MockTopRatedTvShowsNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedTvShowsNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvShowsNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        when(mockNotifier.state).thenReturn(RequestState.loading);

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowsPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        when(mockNotifier.state).thenReturn(RequestState.loaded);
        when(mockNotifier.tvShows).thenReturn(<TvShow>[]);

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowsPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(mockNotifier.state).thenReturn(RequestState.error);
        when(mockNotifier.message).thenReturn('Error message');

        final textFinder = find.byKey(Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowsPage()));

        expect(textFinder, findsOneWidget);
      });
}