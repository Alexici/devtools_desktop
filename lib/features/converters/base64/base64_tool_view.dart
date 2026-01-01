import 'dart:convert'; // Essential for base64Encode / base64Decode
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard
import 'package:google_fonts/google_fonts.dart';

class Base64ToolView extends StatefulWidget {
  const Base64ToolView({super.key});

  @override
  State<Base64ToolView> createState() => _Base64ToolViewState();
}

class _Base64ToolViewState extends State<Base64ToolView> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  
  String? _errorMessage;

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  // --- LOGIC: ENCODE ---
  void _encode() {
    try {
      final text = _inputController.text;
      if (text.isEmpty) return;

      // 1. Convert string to bytes (UTF-8)
      final bytes = utf8.encode(text);
      // 2. Convert bytes to Base64 string
      final base64String = base64Encode(bytes);

      setState(() {
        _outputController.text = base64String;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Encoding Error: ${e.toString()}";
      });
    }
  }

  // --- LOGIC: DECODE ---
  void _decode() {
    try {
      final text = _inputController.text.trim(); // Trim whitespace usually helps
      if (text.isEmpty) return;

      // 1. Decode Base64 string to bytes
      final bytes = base64Decode(text);
      // 2. Convert bytes to UTF-8 string
      final decodedString = utf8.decode(bytes);

      setState(() {
        _outputController.text = decodedString;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Invalid Base64 Input: ${e.toString()}";
      });
    }
  }

  void _clearAll() {
    _inputController.clear();
    _outputController.clear();
    setState(() {
      _errorMessage = null;
    });
  }

  void _copyOutput() {
    if (_outputController.text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _outputController.text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Copied to clipboard!'), duration: Duration(milliseconds: 600)),
      );
    }
  }

  // --- UI ---
  @override
  Widget build(BuildContext context) {
    // Same code style as JSON tool
    final codeStyle = GoogleFonts.firaCode(
      fontSize: 14,
      height: 1.5,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Base64 Encoder / Decoder'),
        scrolledUnderElevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          TextButton.icon(
            onPressed: _clearAll,
            icon: const Icon(Icons.delete_outline),
            label: const Text("Clear"),
          ),
          const SizedBox(width: 8),
          // DECODE BUTTON
          FilledButton.icon(
            onPressed: _decode,
            icon: const Icon(Icons.lock_open),
            label: const Text("Decode"),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          const SizedBox(width: 8),
          // ENCODE BUTTON
          FilledButton.icon(
            onPressed: _encode,
            icon: const Icon(Icons.lock_outline),
            label: const Text("Encode"),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // ERROR BANNER
          if (_errorMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.red.withValues(alpha: 0.1),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            
          // MAIN SPLIT VIEW
          Expanded(
            child: Row(
              children: [
                // --- INPUT SIDE (LEFT) ---
                Expanded(
                  child: Column(
                    children: [
                      // Input Header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Input", style: TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.paste, size: 18),
                              tooltip: "Paste",
                              onPressed: () async {
                                final data = await Clipboard.getData(Clipboard.kTextPlain);
                                if (data?.text != null) {
                                  _inputController.text = data!.text!;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      // Input Field
                      Expanded(
                        child: Card(
                          margin: const EdgeInsets.all(8),
                          elevation: 0,
                          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _inputController,
                              style: codeStyle,
                              maxLines: null,
                              expands: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type text to Encode or Base64 to Decode...',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const VerticalDivider(width: 1),

                // --- OUTPUT SIDE (RIGHT) ---
                Expanded(
                  child: Column(
                    children: [
                      // Output Header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Output", style: TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.copy, size: 18),
                              tooltip: "Copy Output",
                              onPressed: _copyOutput,
                            )
                          ],
                        ),
                      ),
                      // Output Field
                      Expanded(
                        child: Card(
                          margin: const EdgeInsets.all(8),
                          elevation: 0,
                          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _outputController,
                              style: codeStyle,
                              readOnly: true,
                              maxLines: null,
                              expands: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Result will appear here...',
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