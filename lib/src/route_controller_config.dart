import 'dart:async';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:getx_go/src/controller_binding_entry.dart';

typedef GetxGoBuilder = ControllerBindingEntry Function(BuildContext context, GoRouterState state);
typedef Redirect = FutureOr<String?> Function(BuildContext context, GoRouterState state);
typedef CustomTransitionBuilder =
    Widget Function(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    );

abstract class RouteControllerConfig {
  /// Must return a `ControllerBinding` which will be used by the route
  GetxGoBuilder builder();

  /// Call this method inside redirect method to prevent navigation
  ///
  /// Example:
  /// ```dart
  /// @override
  /// Redirect redirect() {
  ///   return (context, state) {
  ///     final email = state.uri.queryParameters['email'];
  ///     final code = state.uri.queryParameters['code'];
  ///     if (email == null && code == null) {
  ///       preventNavigation('Email and code are required');
  ///     }
  ///     return null;
  ///   };
  /// }
  /// ```
  Redirect? redirect() => null;

  /// Optional transitions
  CustomTransitionBuilder? transitionsBuilder() => null;

  /// Call this method inside redirect method to prevent navigation
  ///
  /// Example:
  /// ```dart
  /// @override
  /// Redirect redirect() {
  ///   return (context, state) {
  ///     final email = state.uri.queryParameters['email'];
  ///     final code = state.uri.queryParameters['code'];
  ///     if (email == null && code == null) {
  ///       preventNavigation('Email and code are required');
  ///     }
  ///     return null;
  ///   };
  /// }
  /// ```
  void preventNavigation({required GoRouterState state, String message = ''}) {
    throw PreventRouteException(state, message);
  }
}

class PreventRouteException implements Exception {
  final GoRouterState state;
  String message;

  PreventRouteException(this.state, this.message) {
    message =
        'PreventNavigation:\n'
        'Message: ${message.isEmpty ? 'No message' : message}\n'
        'Path: ${state.uri.path}\n'
        'Query: ${state.uri.query.isEmpty ? 'No query' : state.uri.query}\n';
  }

  @override
  String toString() => message;
}
