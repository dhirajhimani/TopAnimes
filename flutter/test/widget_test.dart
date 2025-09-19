import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:top_anime/main.dart';

void main() {
  testWidgets('TopAnimeApp widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TopAnimeApp());

    // Verify that the app title is shown
    expect(find.text('TopAnimes'), findsOneWidget);

    // Verify that there's a refresh button
    expect(find.byIcon(Icons.refresh), findsOneWidget);
  });
}
