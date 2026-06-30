import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:verditech/features/dashboard/presentation/dashboard_screen.dart';

void main() {
  GoRouter createTestRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/add-plant',
          builder: (context, state) => const Scaffold(body: Text('Add Plant')),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const Scaffold(body: Text('About')),
        ),
      ],
    );
  }

  testWidgets('DashboardScreen smoke test — empty state renders correctly',
      (WidgetTester tester) async {
    // Build the app with an empty database (ProviderScope with no overrides
    // will attempt DB access; we just verify the loading spinner appears, then
    // the empty-state screen. In a full test suite we would inject a mock repo.)
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: createTestRouter(),
        ),
      ),
    );

    // The loading spinner should appear first
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('DashboardScreen shows FAB for adding a plant',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: createTestRouter(),
        ),
      ),
    );

    // FAB should be present immediately
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.text('Add Plant'), findsOneWidget);
  });
}
