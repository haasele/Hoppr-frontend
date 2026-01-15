import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoppr_frontend/core/router/app_router.dart';
import 'package:hoppr_frontend/core/theme/app_theme.dart';
import 'package:hoppr_frontend/core/theme/locale_provider.dart';
import 'package:hoppr_frontend/l10n/app_localizations.dart';

class HopprApp extends ConsumerWidget {
  const HopprApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final theme = ref.watch(appThemeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'Hoppr',
      debugShowCheckedModeBanner: false,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: theme.themeMode,
      routerConfig: router,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
