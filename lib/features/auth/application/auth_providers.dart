import 'package:agory_client_mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:agory_client_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:agory_client_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRemoteDatasource authRemoteDatasource(Ref ref) {
  return DummyAuthRemoteDataSource();
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.watch(authRemoteDatasourceProvider));
}
