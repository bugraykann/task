import 'package:task/core/config/config.dart';
import 'package:task/core/enum/language.dart';
import 'package:task/infrastructure/cubit/theme_cubit.dart';

import '../../../../infrastructure/cubit/language_cubit.dart';

class SettingsViewModel {
  final ThemeCubit themeCubit;
  final LanguageCubit languageCubit;

  SettingsViewModel(this.themeCubit, this.languageCubit);

  void toggleTheme() {
    themeCubit.toggleTheme();
  }

  ThemeMode get currentTheme => themeCubit.state;

  void changeLanguage(Languages language) {
    languageCubit.changeLanguage(language);
  }

  Languages get currentLanguage {
    final locale = languageCubit.state;
    if (locale?.languageCode == 'en') {
      return Languages.english;
    } else if (locale?.languageCode == 'tr') {
      return Languages.turkish;
    }
    return Languages.english;
  }
}
