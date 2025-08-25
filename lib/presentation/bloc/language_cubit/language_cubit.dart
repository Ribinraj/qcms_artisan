import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageCubit extends Cubit<void> {
  LanguageCubit() : super(null);

  Future<void> changeLanguage(BuildContext context, Locale locale) async {
    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('langCode', locale.languageCode);

    // Change app language
    // ignore: use_build_context_synchronously
    await context.setLocale(locale);
  }
}
