import 'package:agory_client_mobile/core/error/failure.dart';
import 'package:agory_client_mobile/core/error/result.dart';
import 'package:agory_client_mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:agory_client_mobile/features/auth/domain/entities/auth_account.dart';
import 'package:agory_client_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:agory_client_mobile/features/auth/sign_in/data/models/sign_in_request_model.dart';
import 'package:agory_client_mobile/features/auth/sign_up/data/models/sign_up_request_model.dart';

final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDatasource);

  final AuthRemoteDatasource _remoteDatasource;

  @override
  Future<Result<AuthAccount>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDatasource.signUp(
        SignUpRequestModel(
          email: email,
          password: password,
        ),
      );

      return Success(
        AuthAccount(
          id: response.id,
          email: response.email,
        ),
      );
    } on ServerException catch (e) {
      return ResultFailure(
        ServerFailure(
          code: e.code,
          message: e.message,
        ),
      );
    } catch (_) {
      return const ResultFailure(UnknownFailure());
    }
  }

  @override
  Future<Result<AuthAccount>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDatasource.signIn(
        SignInRequestModel(
          email: email,
          password: password,
        ),
      );

      return Success(
        AuthAccount(
          id: response.id,
          email: response.email,
        ),
      );
    } on ServerException catch (e) {
      return ResultFailure(
        ServerFailure(
          code: e.code,
          message: e.message,
        ),
      );
    } catch (_) {
      return const ResultFailure(UnknownFailure());
    }
  }
}
