import 'dart:async';

import 'package:agory_client_mobile/features/auth/application/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_controller.g.dart';

@riverpod
class SignUpController extends _$SignUpController {
  @override
  FutureOr<void> build() {
    // State awal: belum ada aksi apa pun.
  }

  Future<void> signUp({required String email, required String password}) async {
    state = const AsyncLoading();

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.signUp(email: email, password: password);

    state = result.when(
      success: (_) => const AsyncData(null),
      failure: (failure) => AsyncError(failure, StackTrace.current),
    );
  }
}
