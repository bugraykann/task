import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task/presentation/screens/main/view/main_view.dart';

abstract final class Routes {
  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static const String splash = 'splash';
  static const String home = 'home';
  static const String main = 'main';
  static final routerConfig = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: main,
        builder: (context, state) => const MainView(),
      ),
    ],
  );
}
