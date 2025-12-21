import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class JsonToolView extends StatefulWidget {
  const JsonToolView({super.key});

  @override
  State<JsonToolView> createState() => _JsonToolViewState();
}

class _JsonToolViewState extends State<JsonToolView> {
  // Controllers to manage the text
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  String? _errorMessage; // If JSON is invalid

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  // Logic: Prettify JSON
  void _prettifyJson() {
    try {
      if (_inputController.text.trim().isEmpty) return;

      final dynamic parsed = jsonDecode(_inputController.text);
      final String formatted = const JsonEncoder.withIndent(
        '  ',
      ).convert(parsed);

      setState(() {
        _outputController.text = formatted;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Invalid JSON: ${e.toString()}';
      });
    }
  }

  // Logic: Minify JSON
  void _minifyJson() {
    try {
      if (_inputController.text.trim().isEmpty) return;

      final dynamic parsed = jsonDecode(_inputController.text);
      final String minified = jsonEncode(parsed);

      setState(() {
        _outputController.text = minified;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Invalid JSON: ${e.toString()}';
      });
    }
  }

  // Logic: Copy output to clipboard
  void _copyOutput() {
    if (_outputController.text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _outputController.text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Output copied to clipboard')),
      );
    }
  }

  // Logic: Paste input from clipboard
  Future<void> _pasteInput() async {
    final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    final String? text = data?.text;
    if (text == null || text.isEmpty) return;
    if (!mounted) return;
    setState(() {
      _inputController.text = text;
      _prettifyJson();
    });
  }

  void _clearAll() {
    _inputController.clear();
    _outputController.clear();
    setState(() {
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final codeStyle = GoogleFonts.firaCode(fontSize: 14, height: 1.5);
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON Formatter'),
        scrolledUnderElevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          // Toolbar Actions

          // Clear All Button
          TextButton.icon(
            onPressed: _clearAll,
            icon: const Icon(Icons.delete_outline),
            label: const Text('Clear'),
          ),

          const SizedBox(width: 8),

          // Minify Button
          FilledButton.icon(
            onPressed: _minifyJson,
            icon: const Icon(Icons.compress),
            label: const Text('Minify'),
          ),

          const SizedBox(width: 8),

          // Prettify Button
          FilledButton.icon(
            onPressed: _prettifyJson,
            icon: const Icon(Icons.format_indent_increase),
            label: const Text('Prettify'),
          ),

          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Error Banner
          if (_errorMessage != null)
            Container(
              color: Colors.redAccent,
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            ),

          // Main Content [Split View]
          Expanded(
            child: Row(
              children: [
                // Input Area
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Input",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(Icons.paste, size: 18),
                              tooltip: 'Paste from Clipboard',
                              onPressed: _pasteInput,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Card(
                          margin: const EdgeInsets.all(8),
                          elevation: 0,
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                              .withValues(alpha: 0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _inputController,
                              style: codeStyle,
                              maxLines: null, // Allows Infinite scrolling
                              expands: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter JSON here...',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Divider
                const VerticalDivider(width: 1),

                // Output Area
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Output",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: _copyOutput,
                              icon: const Icon(Icons.copy, size: 18),
                              tooltip: 'Copy Output',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Card(
                          margin: const EdgeInsets.all(8),
                          elevation: 0,

                          // Different color for output area
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                              .withValues(alpha: 0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _outputController,
                              style: codeStyle,
                              maxLines: null, // Allows Infinite scrolling
                              expands: true,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Formatted JSON will appear here...',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
