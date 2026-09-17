import 'package:agory_client_mobile/app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home AppBar'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                context.go(AppRoutes.signUp);
              },
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () {
                context.go(AppRoutes.signIn);
              },
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
