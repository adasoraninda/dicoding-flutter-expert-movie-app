import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  testWidgets(
    "About page contain text Ditonton",
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutPage()));

      final findTextDitonton = find.textContaining('Ditonton');

      expect(findTextDitonton, findsOneWidget);
    },
  );
}
