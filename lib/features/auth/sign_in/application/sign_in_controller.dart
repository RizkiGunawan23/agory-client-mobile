import 'dart:async';

import 'package:agory_client_mobile/features/auth/application/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_controller.g.dart';

@riverpod
class SignInController extends _$SignInController {
  @override
  FutureOr<void> build() {
    // State awal: belum ada aksi apa pun.
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.signIn(
      email: email,
      password: password,
    );

    state = result.when(
      success: (_) => const AsyncData(null),
      failure: (failure) => AsyncError(failure, StackTrace.current),
    );
  }
}
