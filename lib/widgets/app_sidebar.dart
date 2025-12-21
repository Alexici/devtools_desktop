import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../core/theme_provider.dart';

class AppSidebar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppSidebar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return NavigationRail(
      extended: true,
      minExtendedWidth: 180,
      backgroundColor: Theme.of(context).colorScheme.surface,
      indicatorColor: Colors.transparent,

      // Styling for selected and unselected items
      selectedIconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.primary,
      ),
      unselectedIconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
      ),
      selectedLabelTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),

      // Destinations
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard),
          label: Text('Dashboard'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.transform_outlined),
          selectedIcon: Icon(Icons.transform),
          label: Text('Converters'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.generating_tokens_outlined),
          selectedIcon: Icon(Icons.generating_tokens),
          label: Text('Generators'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.build_outlined),
          selectedIcon: Icon(Icons.build),
          label: Text('Other Tools'),
        ),
      ],
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (int index) {
        navigationShell.goBranch(index);
      },
      trailing: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wb_sunny_outlined, size: 20),
                  Switch(
                    value: isDark,
                    onChanged: (value) {
                      themeProvider.toggleTheme(value);
                    },
                  ),
                  const Icon(Icons.nightlight_round, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
