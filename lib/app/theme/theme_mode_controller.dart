import 'package:agory_client_mobile/core/storage/theme_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_controller.g.dart';

@riverpod
class ThemeModeController extends _$ThemeModeController {
  @override
  FutureOr<ThemeMode> build() {
    return ThemeLocalStorage.read();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = AsyncData(mode);
    await ThemeLocalStorage.write(mode);
  }
}
