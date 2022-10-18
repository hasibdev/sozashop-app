import 'package:flutter/material.dart';

const String enCode = 'en';
const String bnCode = 'bn';

class L10n {
  static final all = [
    const Locale(enCode),
    const Locale(bnCode),
  ];

  static String getLanguageName(String code) {
    switch (code) {
      case enCode:
        return 'English';
      case bnCode:
        return 'বাংলা';
      default:
        return 'English';
    }
  }
}
