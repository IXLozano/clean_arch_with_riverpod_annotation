import 'dart:async';

import 'package:feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:feature_auth/presentation/bloc/auth_state.dart';
import 'package:feature_auth/presentation/pages/home_page.dart';
import 'package:feature_auth/presentation/pages/login_page.dart';
import 'package:feature_auth/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  GoRouter get router => GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final onLoggingIn = state.matchedLocation == '/login';
      final onSplash = state.matchedLocation == '/splash';

      // If user is authenticated, ignore intention to go to login or splash and redirect to home
      if (authState is AuthAuthenticated && (onLoggingIn || onSplash)) {
        return '/home';
      }

      // If user is not authenticated or there is an error, and tries to access
      // a protected route, redirect to login
      if ((authState is AuthUnauthenticated || authState is AuthError) && !onLoggingIn) {
        return '/login';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => SplashPage()),
      GoRoute(path: '/login', builder: (context, state) => LoginPage()),
      GoRoute(path: '/home', builder: (context, state) => HomePage()),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  final Stream stream;
  late final StreamSubscription _subscription;

  GoRouterRefreshStream(this.stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
