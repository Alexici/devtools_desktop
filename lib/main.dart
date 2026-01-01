import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';
import 'package:provider/provider.dart';
import 'core/app_shell.dart';
import 'core/theme_provider.dart';
import 'features/home/home_screen.dart';

// Importing main views
import 'package:devtools_desktop/features/converters/converters_view.dart';
import 'package:devtools_desktop/features/generators/generators_view.dart';

// Importing sub-views
import 'package:devtools_desktop/features/generators/uuid_tool/uuid_tool_view.dart';
import 'package:devtools_desktop/features/converters/json_tool/json_tool_view.dart';
import 'package:devtools_desktop/features/converters/base64/base64_tool_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1000, 700),
    minimumSize: Size(800, 600),
    center: true,
    title: "DevUtils",
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: themeProvider)],
      child: const MyApp(),
    ),
  );
}

// Router Configuration
final _router = GoRouter(
  initialLocation: '/home',
  routes: [
    // This ShellRoute keeps the Sidebar persistent
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        // Branch 0: Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),

        // Branch 1: Converters
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/converters',
              builder: (context, state) => const ConvertersView(),
              routes: [
                // Sub-routes for Converters

                // JSON Formatter Tool
                GoRoute(
                  path: 'json_formatter',
                  builder: (context, state) => const JsonToolView(),
                ),

                //Base64 Encoder/Decoder Tool
                GoRoute(
                  path: 'base64',
                  builder: (context, state) => const Base64ToolView(),
                ),
              ],
            ),
          ],
        ),

        // Branch 2: Generators
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/generators',
              builder: (context, state) => const GeneratorsView(),
              routes: [
                // Sub-routes for Generators
                GoRoute(
                  path: 'uuid_generator',
                  builder: (context, state) => const UuidToolView(),
                ),
              ],
            ),
          ],
        ),

        // Branch 3: Other Tools
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/other',
              builder: (context, state) =>
                  const Scaffold(body: Center(child: Text('Coming Soon!'))),
            ),
          ],
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the provider for theme changes
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'DevTools Desktop',

      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light, // Default to Dark Mode for devs!
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
      ),
    );
  }
}
