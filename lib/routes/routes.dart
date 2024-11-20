import 'package:flutter/material.dart';

import '../features/home/presentation/views/home_view.dart';
import '../features/splashscreen/presentation/views/splashscreen_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreenView.route:
        return MaterialPageRoute(
            settings: const RouteSettings(name: SplashScreenView.route),
            builder: (_) => const SplashScreenView());
      case HomeView.route:
        return MaterialPageRoute(
            settings: const RouteSettings(name: HomeView.route),
            builder: (_) => const HomeView());
      default:
        return MaterialPageRoute(
            settings: const RouteSettings(name: SplashScreenView.route),
            builder: (_) => const SplashScreenView());
    }
  }
}
