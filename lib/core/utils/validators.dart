import 'package:agory_client_mobile/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

abstract final class Validators {
  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? email(BuildContext context, String? value) {
    final trimmed = value?.trim() ?? '';

    if (trimmed.isEmpty) return context.l10n.emailRequiredError;
    if (!_emailRegex.hasMatch(trimmed)) return context.l10n.emailInvalidError;

    return null;
  }

  static String? password(BuildContext context, String? value) {
    if (value == null || value.isEmpty) return context.l10n.passwordRequiredError;
    if (value.length < 8) return context.l10n.passwordTooShortError;

    return null;
  }
}
