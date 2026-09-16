import 'package:flutter/material.dart';

class NavItemEntity {
  final IconData icon;
  final String label;

  const NavItemEntity({
    required this.icon,
    required this.label,
  });

  // Default items list for the Dashboard
  static const List<NavItemEntity> defaultItems = [
    NavItemEntity(
      icon: Icons.home_rounded,
      label: 'Home',
    ),
    NavItemEntity(
      icon: Icons.receipt_long_rounded,
      label: 'Activity',
    ),
    NavItemEntity(
      icon: Icons.bar_chart_rounded,
      label: 'Insights',
    ),
    NavItemEntity(
      icon: Icons.person_rounded,
      label: 'Profile',
    ),
  ];
}