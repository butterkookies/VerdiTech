import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'screens/dashboard_screen.dart';
import 'screens/add_plant_screen.dart';
import 'screens/plant_details_screen.dart';
import 'screens/ca_visualization_screen.dart';
import 'screens/about_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: VerdiTechApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'add-plant',
          builder: (BuildContext context, GoRouterState state) {
            return const AddPlantScreen();
          },
        ),
        GoRoute(
          path: 'plant/:id',
          builder: (BuildContext context, GoRouterState state) {
            return PlantDetailsScreen(id: state.pathParameters['id']!);
          },
          routes: [
            GoRoute(
              path: 'visualization',
              builder: (BuildContext context, GoRouterState state) {
                return CaVisualizationScreen(id: state.pathParameters['id']!);
              },
            ),
          ]
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
    return MaterialApp.router(
      title: 'VerdiTech',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32), // A deep green seed color
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routerConfig: _router,
    );
  }
}
