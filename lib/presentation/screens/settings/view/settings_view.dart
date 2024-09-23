import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/infrastructure/cubit/language_cubit.dart';
import 'package:task/infrastructure/cubit/theme_cubit.dart';
import 'package:task/presentation/screens/settings/view_model/settings_view_model.dart';
import 'package:task/core/enum/language.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final languageCubit = context.read<LanguageCubit>();
    final viewModel = SettingsViewModel(themeCubit, languageCubit);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Switch(
                      value: themeMode == ThemeMode.dark,
                      onChanged: (val) {
                        viewModel.toggleTheme();
                      },
                    ),
                    const Text('Temayı Değiştir'),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<LanguageCubit, Locale?>(
              builder: (context, locale) {
                return DropdownButton<Languages>(
                  value: viewModel.currentLanguage,
                  items: Languages.values.map((Languages language) {
                    return DropdownMenuItem<Languages>(
                      value: language,
                      child: Text(language.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      viewModel.changeLanguage(value);
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
