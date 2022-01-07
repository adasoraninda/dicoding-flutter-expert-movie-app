import 'package:core/domain/entities/tv_shows/tv_show.dart';
import 'package:core/presentation/pages/tv_shows/top_rated_tv_show_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

// void main() {
//   late MockTopRatedTvShowsCubit mockCubit;

//   setUp(() {
//     mockCubit = MockTopRatedTvShowsCubit();
//   });

//   Widget _makeTestableWidget(Widget body) {
//     return BlocProvider<MockTopRatedTvShowsCubit>.value(
//       value: mockCubit,
//       child: MaterialApp(
//         home: body,
//       ),
//     );
//   }

//   testWidgets('Page should display progress bar when loading',
//       (WidgetTester tester) async {
//     when(mockCubit.state).thenReturn(RequestState.loading);

//     final progressFinder = find.byType(CircularProgressIndicator);
//     final centerFinder = find.byType(Center);

//     await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

//     expect(centerFinder, findsOneWidget);
//     expect(progressFinder, findsOneWidget);
//   });

//   testWidgets('Page should display when data is loaded',
//       (WidgetTester tester) async {
//     when(mockCubit.state).thenReturn(RequestState.loaded);
//     when(mockCubit.tvShows).thenReturn(<TvShow>[]);

//     final listViewFinder = find.byType(ListView);

//     await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

//     expect(listViewFinder, findsOneWidget);
//   });

//   testWidgets('Page should display text with message when Error',
//       (WidgetTester tester) async {
//     when(mockCubit.state).thenReturn(RequestState.error);
//     when(mockCubit.message).thenReturn('Error message');

//     final textFinder = find.byKey(const Key('error_message'));

//     await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

//     expect(textFinder, findsOneWidget);
//   });
// }
