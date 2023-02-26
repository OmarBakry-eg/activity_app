import 'package:activity_app/src/features/activites/presentation/screens/add_or_edit_activity.dart';
import 'package:activity_app/src/features/home/domain/entities/activity_entity.dart';
import 'package:activity_app/src/features/home/presentation/screens/home.dart';
import 'route_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  static final GoRouter router = GoRouter(
      initialLocation: RouteStrings.homePageString,
      navigatorKey: navigatorKey,
      observers: [
        routeObserver
      ],
      routes: [
        GoRoute(
            path: RouteStrings.homePageString,
            builder: (c, state) => const HomePage()),
        GoRoute(
            path: RouteStrings.activityPageString,
            builder: (c, state) => AddOrEditActivityScreen(
                  activityEntity: state.extra as ActivityEntity?,
                ))
      ]);
}
