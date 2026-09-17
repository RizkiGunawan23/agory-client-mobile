import 'package:agory_client_mobile/features/auth/sign_in/presentation/sign_in_screen.dart';
import 'package:agory_client_mobile/features/auth/sign_up/presentation/sign_up_screen.dart';
import 'package:agory_client_mobile/features/profile/profile_screen.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoutes {
  static const String signUp = '/auth/sign-up';
  static const String signIn = '/auth/sign-in';
  static const String profile = '/profile';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.profile,
  routes: [
    GoRoute(
      path: AppRoutes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
