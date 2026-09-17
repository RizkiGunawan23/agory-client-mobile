import 'package:agory_client_mobile/core/constants/error_codes.dart';
import 'package:agory_client_mobile/features/auth/sign_in/data/models/sign_in_request_model.dart';
import 'package:agory_client_mobile/features/auth/sign_in/data/models/sign_in_response_model.dart';
import 'package:agory_client_mobile/features/auth/sign_up/data/models/sign_up_request_model.dart';
import 'package:agory_client_mobile/features/auth/sign_up/data/models/sign_up_response_model.dart';

final class ServerException implements Exception {
  const ServerException({required this.code, required this.message});

  final String code;
  final String message;
}

abstract interface class AuthRemoteDatasource {
  Future<SignUpResponseModel> signUp(SignUpRequestModel request);
  Future<SignInResponseModel> signIn(SignInRequestModel request);
}

final class DummyAuthRemoteDataSource implements AuthRemoteDatasource {
  @override
  Future<SignUpResponseModel> signUp(SignUpRequestModel request) async {
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );

    if (request.email == 'test@exist.com') {
      throw const ServerException(
        code: ErrorCodes.emailAlreadyRegistered,
        message: 'Email sudah terdaftar',
      );
    }

    return SignUpResponseModel(
      id: 'dummy=${DateTime.now().millisecondsSinceEpoch}',
      email: request.email,
    );
  }

  @override
  Future<SignInResponseModel> signIn(SignInRequestModel request) async {
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );

    if (request.password != 'password123') {
      throw const ServerException(
        code: ErrorCodes.invalidCredentials,
        message: 'Email atau password salah',
      );
    }

    return SignInResponseModel(
      id: 'dummy-${DateTime.now().microsecondsSinceEpoch}',
      email: request.email,
    );
  }
}
