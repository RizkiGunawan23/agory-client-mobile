sealed class Failure {
  const Failure({required this.code, required this.message});

  final String code;
  final String message;
}

final class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, this.fieldErrors = const {}})
    : super(code: 'VALIDATION_ERROR');

  final Map<String, String> fieldErrors;
}

final class ServerFailure extends Failure {
  const ServerFailure({required super.code, required super.message});
}

final class NetworkFailure extends Failure {
  const NetworkFailure()
    : super(code: 'NETWORK_ERROR', message: 'Tidak dapat terhubung ke server');
}

final class UnknownFailure extends Failure {
  const UnknownFailure()
    : super(
        code: 'UNKNOWN_ERROR',
        message: 'Terjadi kesalahan yang tidak diketahui',
      );
}
