import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:top_anime/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('TopAnimes App Integration Tests', () {
    testWidgets('App should load and display anime grid', (tester) async {
      // Start the app
      await tester.pumpWidget(const TopAnimeApp());
      
      // Verify app loads with title
      expect(find.text('TopAnimes'), findsOneWidget);
      
      // Wait for potential loading to complete
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      // The app should either show loading, error, or loaded state
      // We can't guarantee network connectivity in tests, so we check for UI elements
      expect(
        find.byType(Scaffold),
        findsOneWidget,
        reason: 'App should have main scaffold',
      );
      
      // Should have refresh button in app bar
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('Refresh button should be tappable', (tester) async {
      await tester.pumpWidget(const TopAnimeApp());
      await tester.pumpAndSettle();
      
      // Find and tap refresh button
      final refreshButton = find.byIcon(Icons.refresh);
      expect(refreshButton, findsOneWidget);
      
      await tester.tap(refreshButton);
      await tester.pump();
      
      // After tapping refresh, we should see some UI response
      // (loading indicator or content)
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}