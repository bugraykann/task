import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:task/core/constants/constants.dart';
import 'package:task/core/enum/language.dart';

class LanguageCubit extends Cubit<Locale?> {
  LanguageCubit() : super(const Locale('tr', 'TR'));

  void changeLanguage(Languages language) {
    emit(language.locale);
  }
}
