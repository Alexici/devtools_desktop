import 'package:devtools_desktop/features/converters/tools_data.dart';
import 'package:devtools_desktop/widgets/tool_card.dart';
import 'package:flutter/material.dart';

class ConvertersView extends StatelessWidget {
  const ConvertersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Header
      appBar: AppBar(title: const Text('Converters'), centerTitle: false),

      // The Grid
      body: GridView.extent(
        maxCrossAxisExtent: 250, // Max width
        childAspectRatio: 1.1, // Aspect ratio
        padding: const EdgeInsets.all(24),
        mainAxisSpacing: 20, // Vertical spacing
        crossAxisSpacing: 20, // Horizontal spacing

        children: converterTools.map((tool) {
          return ToolCard(
            title: tool.title,
            description: tool.description,
            icon: tool.icon,
            onTap: () {
              print(
                'Navigating to ${tool.route}',
              ); // Replace with actual navigation logic
            },
          );
        }).toList(),
      ),
    );
  }
}
