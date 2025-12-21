import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_sidebar.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell ({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AppSidebar(navigationShell:   navigationShell),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: navigationShell)
        ],
      ),
    );
  }
}