import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/presentation/pages/tv_shows/popular_tv_show_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

// void main() {
//   late MockPopularTvShowsCubit mockCubit;

//   setUp(() {
//     mockCubit = MockPopularTvShowsCubit();
//   });

//   Widget _makeTestableWidget(Widget body) {
//     return BlocProvider<MockPopularTvShowsCubit>.value(
//       value: mockCubit,
//       child: MaterialApp(
//         home: body,
//       ),
//     );
//   }

//   testWidgets('Page should display center progress bar when loading',
//       (WidgetTester tester) async {
//     when(mockCubit.state).thenReturn(RequestState.loading);

//     final progressBarFinder = find.byType(CircularProgressIndicator);
//     final centerFinder = find.byType(Center);

//     await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

//     expect(centerFinder, findsOneWidget);
//     expect(progressBarFinder, findsOneWidget);
//   });

//   testWidgets('Page should display ListView when data is loaded',
//       (WidgetTester tester) async {
//     when(mockCubit.state).thenReturn(RequestState.loaded);
//     when(mockCubit.tvShows).thenReturn(<TvShow>[]);

//     final listViewFinder = find.byType(ListView);

//     await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

//     expect(listViewFinder, findsOneWidget);
//   });

//   testWidgets('Page should display text with message when Error',
//       (WidgetTester tester) async {
//     when(mockCubit.state).thenReturn(RequestState.error);
//     when(mockCubit.message).thenReturn('Error message');

//     final textFinder = find.byKey(const Key('error_message'));

//     await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

//     expect(textFinder, findsOneWidget);
//   });
// }
