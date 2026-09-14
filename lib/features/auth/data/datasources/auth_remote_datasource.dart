import 'package:agory_client_mobile/core/constants/error_codes.dart';
import 'package:agory_client_mobile/features/auth/data/models/sign_up_request_model.dart';
import 'package:agory_client_mobile/features/auth/data/models/sign_up_response_model.dart';

final class ServerException implements Exception {
  const ServerException({required this.code, required this.message});

  final String code;
  final String message;
}

abstract interface class AuthRemoteDatasource {
  Future<SignUpResponseModel> signUp(SignUpRequestModel request);
}

final class DummyAuthRemoteDataSource implements AuthRemoteDatasource {
  @override
  Future<SignUpResponseModel> signUp(SignUpRequestModel request) async {
    await Future.delayed(const Duration(seconds: 1));

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
}
