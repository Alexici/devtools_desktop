import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class UuidToolView extends StatefulWidget {
  const UuidToolView({super.key});

  @override
  State<UuidToolView> createState() => _UuidToolViewState();
}

class _UuidToolViewState extends State<UuidToolView> {
  // Logic Variables
  final Uuid _uuid = const Uuid();
  List<String> _generatedUuids = [];

  // Settings
  bool _removeHyphens = false;
  bool _upperCase = false;
  int _count = 1;

  @override
  void initState() {
    super.initState();
    _generate(); // Initial generation
  }

  void _generate() {
    List<String> newIds = [];

    for (int i = 0; i < _count; i++) {
      String id = _uuid.v4();

      // Remove hyphens
      if (_removeHyphens) {
        id = id.replaceAll('-', '');
      }

      // Uppercase
      if (_upperCase) {
        id = id.toUpperCase();
      }

      // Add The new ID to the list
      newIds.add(id);
    }

    setState(() {
      _generatedUuids = newIds;
    });
  }

  void _copyAll() {
    final text = _generatedUuids.join('\n');
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All UUIDs copied to clipboard!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UUID Generator')),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Settings bar
            Wrap(
              spacing: 20,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Count: "),
                    SizedBox(
                      width: 150,
                      child: Slider(
                        value: _count.toDouble(),
                        min: 1,
                        max: 50,
                        divisions: 49,
                        label: _count.toString(),
                        onChanged: (value) {
                          setState(() {
                            _count = value.toInt();
                            _generate();
                          });
                        },
                      ),
                    ),
                    Text("$_count"),
                  ],
                ),

                // Toggles
                FilterChip(
                  label: const Text("Hyphens"),
                  selected: !_removeHyphens,
                  onSelected: (val) {
                    setState(() {
                      _removeHyphens = !val;
                      _generate();
                    });
                  },
                ),

                // Uppercase Toggle
                FilterChip(
                  label: const Text("Uppercase"),
                  selected: _upperCase,
                  onSelected: (val) {
                    setState(() {
                      _upperCase = val;
                      _generate();
                    });
                  },
                ),

                // Refresh Button
                FilledButton.icon(
                  onPressed: _generate,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Regenerate"),
                ),

                // Copy Button
                OutlinedButton.icon(
                  onPressed: _copyAll,
                  icon: Icon(Icons.copy),
                  label: const Text("Copy All"),
                ),
              ],
            ),

            const Divider(height: 40),

            // Output List
            Expanded(
              child: ListView.separated(
                separatorBuilder: (ctx, i) => const Divider(height: 1),
                itemCount: _generatedUuids.length,
                itemBuilder: (ctx, index) {
                  final uuid = _generatedUuids[index];
                  return ListTile(
                    title: Text(
                      uuid,
                      style: const TextStyle(
                        fontFamily: 'RobotoMono',
                        fontSize: 16,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy, size: 18),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: uuid));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('UUID copied to clipboard!'),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
