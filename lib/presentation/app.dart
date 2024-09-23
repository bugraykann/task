import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:task/core/config/rotues.dart';
import 'package:task/core/utils/theme.dart';
import 'package:task/infrastructure/cubit/language_cubit.dart';
import 'package:task/infrastructure/cubit/theme_cubit.dart';
import 'package:task/infrastructure/implementions/global_bloc_provider.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: GlobalBlocProviders.all(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, themeMode) {
        final locale = context.watch<LanguageCubit>().state;
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: ClassicTheme.light,
            darkTheme: ClassicTheme.dark,
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            routerConfig: Routes.routerConfig,
            localeResolutionCallback: (locale, supportedLocales) {
              final supportedLocale = supportedLocales.firstOrNullWhere(
                      (x) => x.toString() == locale?.languageCode) ??
                  const Locale('en');
              Intl.defaultLocale = supportedLocale.toString();
              return supportedLocale;
            },
          ),
        );
      }),
    );
  }
}
