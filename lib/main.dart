import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stepwise/data/database/database.dart';
import 'package:stepwise/data/providers/database_provider.dart';
import 'package:stepwise/views/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase();
  runApp(ProviderScope(
      overrides: [databaseProvider.overrideWithValue(database)],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stepwise',
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.outerSpace),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}
