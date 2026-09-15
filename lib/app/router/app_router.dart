import 'package:agory_client_mobile/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:agory_client_mobile/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoutes {
  static const String signUp = '/auth/sign-up';
  static const String signIn = '/auth/sign-in';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.signUp,
  routes: [
    GoRoute(
      path: AppRoutes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      builder: (context, state) => const SignInScreen(),
    ),
  ],
);
