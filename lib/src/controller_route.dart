import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:getx_go/getx_go.dart';
import 'package:getx_go/src/route_controller_config.dart';

class ControllerRoute extends GoRoute {
  ControllerRoute({
    required super.path,
    required RouteControllerConfig routeControllerConfig,
    super.name,
    List<ControllerRoute> routes = const [],
    super.onExit,
    super.parentNavigatorKey,
    super.caseSensitive,
  }) : super(
          builder: routeControllerConfig.getBuilder(),
          pageBuilder: routeControllerConfig.getPageBuilder(),
          redirect: routeControllerConfig.redirect(),
          routes: routes,
        );
}

extension _ControllerRouteBuilderExt on RouteControllerConfig {
  bool hasTransition() {
    final hasBuilder = transitionsBuilder() != null;
    final hasDuration = transitionDuration() != null;
    final hasReverseDuration = reverseTransitionDuration() != null;
    return hasBuilder || hasDuration || hasReverseDuration;
  }

  Widget Function(BuildContext, GoRouterState)? getBuilder() {
    return hasTransition() ? null : builder();
  }

  Page<dynamic> Function(BuildContext, GoRouterState)? getPageBuilder() {
    return hasTransition() ? _buildWithTransition : null;
  }

  Page<dynamic> _buildWithTransition(BuildContext context, GoRouterState state) {
    final defaultDuration = const Duration(milliseconds: 300);
    return CustomTransitionPage(
      key: state.pageKey,
      child: builder()(context, state),
      transitionDuration: transitionDuration() ?? defaultDuration,
      reverseTransitionDuration: reverseTransitionDuration() ?? defaultDuration,
      transitionsBuilder: transitionsBuilder() ?? (ctx, a1, a2, child) => child,
    );
  }
}
