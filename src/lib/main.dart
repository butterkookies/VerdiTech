import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/notification_service.dart';

import 'presentation/theme/verditech_theme.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/plant_detail/presentation/plant_details_screen.dart';
import 'features/ca_visualization/presentation/ca_visualization_screen.dart';
import 'features/about/presentation/about_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(
    const ProviderScope(
      child: VerdiTechApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  // Step 7: errorBuilder prevents blank white screen on unknown routes
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Page Not Found')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.orange),
          const SizedBox(height: 16),
          Text(
            'Route not found: ${state.uri}',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => context.go('/'),
            child: const Text('Go to Dashboard'),
          ),
        ],
      ),
    ),
  ),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'plant/:id',
          builder: (BuildContext context, GoRouterState state) {
            return PlantDetailsScreen(id: state.pathParameters['id']!);
          },
          routes: [
            GoRoute(
              path: 'visualization',
              builder: (BuildContext context, GoRouterState state) {
                return CAVisualizationScreen(
                    id: state.pathParameters['id']!);
              },
            ),
          ],
        ),
        GoRoute(
          path: 'about',
          builder: (BuildContext context, GoRouterState state) {
            return const AboutScreen();
          },
        ),
      ],
    ),
  ],
);

class VerdiTechApp extends StatelessWidget {
  const VerdiTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine system brightness to pick light or dark scheme.
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDark = brightness == Brightness.dark;
    final scheme = isDark ? VTScheme.dark : VTScheme.light;

    return VTTheme(
      scheme: scheme,
      child: MaterialApp.router(
        title: 'VerdiTech',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: scheme.verdantDeep,
            brightness: brightness,
            surface: scheme.bg,
          ),
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        routerConfig: _router,
      ),
    );
  }
}
