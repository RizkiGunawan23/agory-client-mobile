import 'package:agory_client_mobile/core/error/result.dart';
import 'package:agory_client_mobile/features/auth/domain/entities/auth_account.dart';

abstract interface class AuthRepository {
  Future<Result<AuthAccount>> signUp({
    required String email,
    required String password,
  });
}
