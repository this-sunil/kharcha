import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
GlobalKey<ScaffoldMessengerState> globalMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<Object?> pushNamed(String routeName, {Object? arguments}) async {
  return GoRouter.of(
    navigatorKey.currentContext!,
  ).push(routeName, extra: arguments);
}

void pushReplacement(String routeName, {Object? extra}) {
  GoRouter.of(
    navigatorKey.currentContext!,
  ).pushReplacement(routeName, extra: extra);
}

void clearAndGo(String path, {Object? extra}) {
  GoRouter.of(navigatorKey.currentContext!).go(path, extra: extra);
}

void pop([Object? result]) {
  GoRouter.of(navigatorKey.currentContext!).pop(result);
}
