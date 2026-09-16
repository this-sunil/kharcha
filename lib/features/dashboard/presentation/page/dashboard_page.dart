import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kharcha/features/auth/presentation/riverpod/auth_provider.dart';
import 'package:kharcha/features/dashboard/presentation/page/home_page.dart';
import 'package:kharcha/features/dashboard/presentation/page/insights_page.dart';
import 'package:kharcha/features/dashboard/presentation/page/profile_page.dart';
import 'package:kharcha/features/dashboard/presentation/page/transaction_page.dart';

import '../../../../core/util/CustomText.dart';
import '../../domain/entity/NavItemEntity.dart';



class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  int selectedNav = 0;

  final List<Widget> pages = const [
    HomePage(),
    TransactionPage(),
    InsightPage(),
    ProfilePage(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(authNotifierProvider.notifier).fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedNav,
        children: pages,
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final items = const <NavItemEntity>[
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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(60),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : const Color(0xFF71805D).withValues(alpha: 0.10),
              blurRadius: 28,
              spreadRadius: -5,
              offset: const Offset(0, 10),
            ),
            if (!isDark)
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                blurRadius: 18,
                spreadRadius: 1,
              ),
          ],
        ),
        child: Row(
          children: List.generate(items.length, (index) {
            final bool selected = selectedNav == index;
            final activeColor = Colors.deepPurpleAccent;
            final inactiveColor = Colors.deepPurple.shade200;

            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (selectedNav != index) {
                    setState(() => selectedNav = index);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeOutCubic,
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: selected
                        ? activeColor.withValues(alpha: 0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: selected
                        ? Border.all(
                      color: activeColor.withValues(alpha: 0.3),
                      width: 1,
                    )
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                        width: selected ? 38 : 32,
                        height: selected ? 30 : 28,
                        decoration: BoxDecoration(
                          color: selected
                              ? activeColor.withValues(alpha: 0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          items[index].icon,
                          size: selected ? 21 : 20,
                          color: selected ? activeColor : inactiveColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 220),
                        style: TextStyle(
                          color: selected ? activeColor : inactiveColor,
                          fontSize: selected ? 9.5 : 9,
                          fontWeight:
                          selected ? FontWeight.w900 : FontWeight.w600,
                          letterSpacing: selected ? 0.1 : 0,
                        ),
                        child: CustomText(
                          text: items[index].label,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}