import 'package:agory_client_mobile/app/router/app_router.dart';
import 'package:agory_client_mobile/core/error/failure.dart';
import 'package:agory_client_mobile/core/extensions/build_context_extension.dart';
import 'package:agory_client_mobile/core/utils/validators.dart';
import 'package:agory_client_mobile/core/widgets/app_button.dart';
import 'package:agory_client_mobile/core/widgets/app_text_field.dart';
import 'package:agory_client_mobile/features/auth/application/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePassword = useState(true);

    final signUpState = ref.watch(signUpControllerProvider);
    final isLoading = signUpState.isLoading;

    void showMessage(String message) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
    }

    ref.listen(signUpControllerProvider, (previous, next) {
      if (previous is! AsyncLoading) return;

      next.when(
        data: (_) {
          showMessage(context.l10n.signUpSuccessMessage);
          context.go(AppRoutes.signIn);
        },
        error: (error, _) {
          final message = error is Failure ? error.message : context.l10n.genericErrorMessage;
          showMessage(message);
        },
        loading: () {},
      );
    });

    Future<void> handleSubmit() async {
      if (!(formKey.currentState?.validate() ?? false)) return;

      await ref
          .read(signUpControllerProvider.notifier)
          .signUp(
            email: emailController.text.trim(),
            password: passwordController.text,
          );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.signUpScreenTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                AppTextField(
                  controller: emailController,
                  label: context.l10n.emailFieldLabel,
                  keyboardType: .emailAddress,
                  validator: (value) => Validators.email(context, value),
                  enabled: !isLoading,
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextField(
                  controller: passwordController,
                  label: context.l10n.passwordFieldLabel,
                  obscureText: obscurePassword.value,
                  validator: (value) => Validators.password(context, value),
                  enabled: !isLoading,
                  suffixIcon: IconButton(
                    onPressed: () => obscurePassword.value = !obscurePassword.value,
                    icon: Icon(
                      obscurePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                AppButton(
                  label: context.l10n.signUpButtonLabel,
                  isLoading: isLoading,
                  onPressed: handleSubmit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
