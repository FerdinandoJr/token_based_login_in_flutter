
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:token_based_authentication/config/providers/auth_provider.dart';
import 'package:token_based_authentication/presentation/pages/home_screen.dart';
import 'package:token_based_authentication/presentation/pages/login_screen.dart';

final routerProvider = Provider<GoRouter> ((ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final loggedIn = ref.read(authProvider);

      if (!loggedIn && state.location != '/login') {
        return '/login';
      }

      if (loggedIn && state.location == '/login') {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
    ],
  );
});
