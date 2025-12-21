import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.handyman, size: 80, color: Colors.blueGrey),
            const SizedBox(height: 20),
            Text(
              "Developer's Swiss Army Knife",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text("Select a tool from the sidebar to get started."),
          ],
        ),
      ),
    );
  }
}