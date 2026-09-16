import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kharcha/features/dashboard/presentation/page/dashboard_page.dart';


import 'package:kharcha/features/auth/presentation/page/auth_change_pass.dart';
import 'package:kharcha/features/auth/presentation/page/auth_login.dart';
import 'package:kharcha/features/auth/presentation/page/auth_register.dart';
import 'package:kharcha/features/auth/presentation/page/auth_update.dart';
import 'package:kharcha/features/notification/presentation/page/notification_screen.dart';

import 'package:kharcha/features/wallet/presentation/page/wallet_info.dart';
import 'package:kharcha/splash_screen.dart';
import '../../settings/contact_support.dart';
import '../../settings/currency_screen.dart';
import '../../settings/help_screen.dart';
import '../../settings/privacy_policy.dart';
import 'app_routes.dart';
import 'route_functions.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
          path: AppRoutes.splash,
          builder: (context, state) => SplashScreen()),
      GoRoute(
          path: AppRoutes.dashboard,
          builder: (context, state) => DashboardPage()),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => AuthLogin()),
      GoRoute(
          path: AppRoutes.register,
          builder: (context, state) => AuthRegister()),
      GoRoute(
          path: AppRoutes.updateProfile,
          builder: (context, state) => AuthUpdate()),
      GoRoute(
          path: AppRoutes.authChangePass,
          builder: (context, state) => AuthChangePass()),
      GoRoute(
          path: AppRoutes.currency,
          builder: (context, state) => CurrencyScreen()),
      GoRoute(
          path: AppRoutes.notification,
          builder: (context, state) => NotificationScreen()),
      GoRoute(
          path: AppRoutes.walletInfo,
          builder: (context, state) => WalletInfo()),
      GoRoute(
          path: AppRoutes.help,
          builder: (context, state) => HelpScreen()),
      GoRoute(
          path: AppRoutes.contact,
          builder: (context, state) => ContactSupportScreen()),
      GoRoute(
          path: AppRoutes.privacy,
          builder: (context, state) => PrivacyPolicyScreen()),

    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Error: ${state.error}')),
    ),
  );
}
