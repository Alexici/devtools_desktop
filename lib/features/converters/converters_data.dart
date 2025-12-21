import 'package:flutter/material.dart';

class ConvertersData {
  final String title;
  final String description;
  final IconData icon;
  final String route;

  const ConvertersData({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
  });
}

// Data Source
final List<ConvertersData> converterTools = [
  // JSON Formatter Tool
  const ConvertersData(
    title: 'JSON Formatter',
    description: 'Validate, prettify, and minify JSON data.',
    icon: Icons.data_object,
    route: '/converters/json_formatter',
  ),

  // Base64 Encoder/Decoder Tool
  const ConvertersData(
    title: 'Base64 Encoder/Decoder',
    description: 'Encode and decode Base64 strings.',
    icon: Icons.code,
    route: '/converters/base64',
  ),

  // JWT Decoder Tool
  const ConvertersData(
    title: 'JWT Decoder',
    description: 'Decode JSON Web Tokens (JWT) easily.',
    icon: Icons.vpn_key,
    route: '/converters/jwt_decoder',
  ),

  // Number Base Converter Tool
  const ConvertersData(
    title: 'Number Base Converter',
    description:
        'Convert numbers between different bases (binary, decimal, hex).',
    icon: Icons.calculate,
    route: '/converters/number_base_converter',
  ),

  // YAML <-> JSON Converter
  const ConvertersData(
    title: 'YAML <-> JSON Converter',
    description: 'Convert data between YAML and JSON formats.',
    icon: Icons.segment,
    route: '/converters/yaml_json_converter',
  ),

  // Unix Timestamp Converter
  const ConvertersData(
    title: 'Unix Timestamp Converter',
    description:
        'Convert Unix timestamps to human-readable dates and vice versa.',
    icon: Icons.schedule,
    route: '/converters/unix_timestamp_converter',
  ),
];
