import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app.dart';
import 'di/injector.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await initSingletons();
  provideDataSources();
  provideRepositories();
  provideUseCases();

  runApp(const ProviderScope(child: App()));
}
