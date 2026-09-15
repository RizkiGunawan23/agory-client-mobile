// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Agory';

  @override
  String get signUpScreenTitle => 'Daftar Akun';

  @override
  String get emailFieldLabel => 'Email';

  @override
  String get passwordFieldLabel => 'Password';

  @override
  String get signUpButtonLabel => 'Daftar';

  @override
  String get signUpSuccessMessage => 'Sign up berhasil!';

  @override
  String get genericErrorMessage => 'Terjadi kesalahan';

  @override
  String get emailRequiredError => 'Email wajib diisi';

  @override
  String get emailInvalidError => 'Format email tidak valid';

  @override
  String get passwordRequiredError => 'Password wajib diisi';

  @override
  String get passwordTooShortError => 'Password minimal 8 karakter';

  @override
  String get signInScreenTitle => 'Masuk';

  @override
  String get signInButtonLabel => 'Masuk';

  @override
  String get signInSuccessMessage => 'Sign in berhasil!';
}
