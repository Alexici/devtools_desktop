import 'package:flutter/material.dart';

class GeneratorsData {
  final String title;
  final String description;
  final IconData icon;
  final String route;

  const GeneratorsData({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
  });
}

final List<GeneratorsData> generatorTools = [
  // UUID Generator Tool
  const GeneratorsData(
    title: 'UUID Generator',
    description: 'Generate unique identifiers (UUIDs).',
    icon: Icons.fingerprint,
    route: '/generators/uuid_generator',
  ),
  // Hash Generator Tool
  const GeneratorsData(
    title: 'Hash Generator',
    description: 'Generate hashes (MD5, SHA-1, SHA-256).',
    icon: Icons.lock,
    route: '/generators/hash_generator',
  ),
  // Password Generator Tool
  const GeneratorsData(
    title: 'Password Generator',
    description: 'Create strong, random passwords.',
    icon: Icons.vpn_key,
    route: '/generators/password_generator',
  ),
  // Lorem Ipsum Generator Tool
  const GeneratorsData(
    title: 'Lorem Ipsum Generator',
    description: 'Generate placeholder text.',
    icon: Icons.text_fields,
    route: '/generators/lorem_ipsum_generator',
  ),
  // QR Code Generator Tool
  const GeneratorsData(
    title: 'QR Code Generator',
    description: 'Generate QR codes.',
    icon: Icons.qr_code,
    route: '/generators/qr_code_generator',
  ),
];
