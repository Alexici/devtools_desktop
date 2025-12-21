import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../generators/generators_data.dart';
import '../../widgets/tool_card.dart';

class GeneratorsView extends StatelessWidget {
  const GeneratorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Header
      appBar: AppBar(title: const Text('Generators'), centerTitle: false),

      // The Grid
      body: GridView.extent(
        maxCrossAxisExtent: 250,
        childAspectRatio: 1.1,
        padding: const EdgeInsets.all(24),
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,

        children: generatorTools.map((tool) {
          return ToolCard(
            title: tool.title,
            description: tool.description,
            icon: tool.icon,
            onTap: () {
              context.go(tool.route);
            },
          );
        }).toList(),
      ),
    );
  }
}
