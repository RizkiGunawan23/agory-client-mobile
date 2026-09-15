Oke, sekarang fokus ke pertanyaan paling praktis: **kalau mau bikin fitur baru, apa aja yang harus dibuat dan diketik, berurutan**. Aku pakai pola yang sudaj established di fitur sign-up ini sebagai template, contoh kasusnya aku pakai fitur **login** (karena strukturnya paralel & belum ada di project, jadi kebayang jelas).

Urutan ini dari dalam ke luar: domain dulu (kontrak), baru data (implementasi), baru application (state), baru presentation (UI).

**1. Domain layer — kontrak dulu, belum ada logic**
```
lib/features/auth/domain/repositories/auth_repository.dart   (sudah ada, tinggal tambah method)
```
Tambah method baru di interface yang sudah ada:
```dart
abstract interface class AuthRepository {
  Future<Result<AuthAccount>> signUp({required String email, required String password});
  Future<Result<AuthAccount>> login({required String email, required String password}); // baru
}
```
Kalau butuh entity baru (misal `LoginResult` beda dari `AuthAccount`), bikin file baru di `domain/entities/`.

**2. Data layer — model request/response**
```
lib/features/auth/data/models/login_request_model.dart
lib/features/auth/data/models/login_response_model.dart
```
Isinya copy-paste pola `SignUpRequestModel`/`SignUpResponseModel` (freezed + json_serializable), ganti field sesuai kontrak API backend.

**3. Data layer — datasource**
```
lib/features/auth/data/datasources/auth_remote_datasource.dart   (edit file yang sudah ada)
```
Tambah method di interface `AuthRemoteDatasource` dan implementasi dummy-nya:
```dart
abstract interface class AuthRemoteDatasource {
  Future<SignUpResponseModel> signUp(SignUpRequestModel request);
  Future<LoginResponseModel> login(LoginRequestModel request); // baru
}
```

**4. Data layer — repository impl**
```
lib/features/auth/data/repositories/auth_repository_impl.dart   (edit file yang sudah ada)
```
Tambah implementasi method `login` dengan pola try/catch yang sama seperti `signUp`.

**5. `dart run build_runner build`**
Wajib dijalankan setelah bikin/edit model `@freezed` — ini yang generate `.freezed.dart` dan `.g.dart`. Kalau ada perubahan di l10n (`.arb`), jalankan `flutter gen-l10n` **dulu** sebelum `build_runner` (sudah dicatat sebagai gotcha sebelumnya).

**6. Application layer — controller**
```
lib/features/auth/application/login_controller.dart
```
Copy pola `SignUpController` — class dengan `@riverpod`, `extends _$LoginController`, method `build()`, dan method aksi (`login(...)`) yang set `state` pakai `AsyncLoading`/`AsyncData`/`AsyncError`.

Provider `authRepositoryProvider` di `auth_providers.dart` **tidak perlu diubah** — controller baru tinggal `ref.read(authRepositoryProvider)` yang sudah ada.

**7. l10n — teks baru**
```
lib/l10n/arb/app_id.arb   (edit)
```
Tambah key baru (misal `loginScreenTitle`, `loginButtonLabel`) plus `@key` description-nya, lalu `flutter gen-l10n` (poin 5).

**8. Presentation layer — screen**
```
lib/features/auth/presentation/screens/login_screen.dart
```
Copy pola `SignUpScreen` — `HookConsumerWidget`, `useTextEditingController`, `ref.listen` ke `loginControllerProvider`, `Form` + `AppTextField` + `AppButton`.

**9. Routing**
Belum ada file routing eksplisit di project ini sejauh yang aku lihat (`app.dart` masih hardcode `home: const SignUpScreen()`) — ini kemungkinan area yang belum digarap (`go_router` sudah ada di `pubspec.yaml` tapi belum dipakai). Kalau mau nyambung layar login, ini titik yang perlu diputuskan dulu: mau langsung pasang `go_router` sekarang, atau tetap hardcode dulu sampai ada minimal 2-3 screen?

---

**Ringkasan urutan kerja** (dari yang paling jarang berubah ke paling sering):
1. `domain/repositories/*.dart` — tambah method kontrak
2. `data/models/*.dart` — request & response model
3. `data/datasources/*.dart` — tambah method interface + dummy impl
4. `data/repositories/*_impl.dart` — implementasi try/catch
5. `dart run build_runner build`
6. `application/*_controller.dart` — controller riverpod
7. `l10n/arb/app_id.arb` + `flutter gen-l10n`
8. `presentation/screens/*.dart` — UI

Mau aku tunjukin versi lengkap kode `login_controller.dart` dan `login_screen.dart` (isi penuh, bukan cuma pola), atau lebih ke arah rangkuman checklist kayak gini dulu buat sekarang?