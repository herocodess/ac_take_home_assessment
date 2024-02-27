import 'package:acumen_technical_assessment/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class Validators {
  static String? validateEmail(BuildContext context, String value) {
    const Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    final regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return context.l10n.validate_email_error;
    } else {
      return null;
    }
  }
}
