import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hoppr_frontend/core/theme/color_tokens.dart';
import 'package:hoppr_frontend/core/theme/shape_tokens.dart';
import 'package:hoppr_frontend/core/theme/text_theme.dart';

/// Theme mode provider
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);

/// Material You dynamic color enabled provider
final dynamicColorEnabledProvider =
    StateNotifierProvider<DynamicColorNotifier, bool>(
  (ref) => DynamicColorNotifier(),
);

/// App theme provider
final appThemeProvider = Provider<AppTheme>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  final dynamicColorEnabled = ref.watch(dynamicColorEnabledProvider);

  return AppTheme(
    themeMode: themeMode,
    dynamicColorEnabled: dynamicColorEnabled,
  );
});

class AppTheme {
  final ThemeMode themeMode;
  final bool dynamicColorEnabled;

  AppTheme({
    required this.themeMode,
    required this.dynamicColorEnabled,
  });

  ThemeData get lightTheme {
    final colorScheme = ColorScheme.light(
      primary: LightColorTokens.primary,
      onPrimary: LightColorTokens.onPrimary,
      primaryContainer: LightColorTokens.primaryContainer,
      onPrimaryContainer: LightColorTokens.onPrimaryContainer,
      secondary: LightColorTokens.secondary,
      onSecondary: LightColorTokens.onSecondary,
      secondaryContainer: LightColorTokens.secondaryContainer,
      onSecondaryContainer: LightColorTokens.onSecondaryContainer,
      tertiary: LightColorTokens.tertiary,
      onTertiary: LightColorTokens.onTertiary,
      tertiaryContainer: LightColorTokens.tertiaryContainer,
      onTertiaryContainer: LightColorTokens.onTertiaryContainer,
      error: LightColorTokens.error,
      onError: LightColorTokens.onError,
      errorContainer: LightColorTokens.errorContainer,
      onErrorContainer: LightColorTokens.onErrorContainer,
      surface: LightColorTokens.surface,
      onSurface: LightColorTokens.onSurface,
      surfaceVariant: LightColorTokens.surfaceVariant,
      onSurfaceVariant: LightColorTokens.onSurfaceVariant,
      outline: LightColorTokens.outline,
      outlineVariant: LightColorTokens.outlineVariant,
      background: LightColorTokens.background,
      onBackground: LightColorTokens.onBackground,
      inverseSurface: LightColorTokens.inverseSurface,
      onInverseSurface: LightColorTokens.onInverseSurface,
      inversePrimary: LightColorTokens.inversePrimary,
      shadow: LightColorTokens.shadow,
      scrim: LightColorTokens.scrim,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: AppTextTheme.lightTextTheme(colorScheme),
      cardTheme: CardTheme(
        shape: AppShapeTokens.cardShape,
        elevation: 1,
        margin: const EdgeInsets.all(8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: AppShapeTokens.buttonShape,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          elevation: 1,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: AppShapeTokens.buttonShape,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: AppShapeTokens.buttonShape,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: AppShapeTokens.chipShape,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppShapeTokens.medium),
        ),
        filled: true,
        fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: AppShapeTokens.bottomSheetShape,
      ),
      dialogTheme: DialogTheme(
        shape: AppShapeTokens.dialogShape,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        shape: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    final colorScheme = ColorScheme.dark(
      primary: DarkColorTokens.primary,
      onPrimary: DarkColorTokens.onPrimary,
      primaryContainer: DarkColorTokens.primaryContainer,
      onPrimaryContainer: DarkColorTokens.onPrimaryContainer,
      secondary: DarkColorTokens.secondary,
      onSecondary: DarkColorTokens.onSecondary,
      secondaryContainer: DarkColorTokens.secondaryContainer,
      onSecondaryContainer: DarkColorTokens.onSecondaryContainer,
      tertiary: DarkColorTokens.tertiary,
      onTertiary: DarkColorTokens.onTertiary,
      tertiaryContainer: DarkColorTokens.tertiaryContainer,
      onTertiaryContainer: DarkColorTokens.onTertiaryContainer,
      error: DarkColorTokens.error,
      onError: DarkColorTokens.onError,
      errorContainer: DarkColorTokens.errorContainer,
      onErrorContainer: DarkColorTokens.onErrorContainer,
      surface: DarkColorTokens.surface,
      onSurface: DarkColorTokens.onSurface,
      surfaceVariant: DarkColorTokens.surfaceVariant,
      onSurfaceVariant: DarkColorTokens.onSurfaceVariant,
      outline: DarkColorTokens.outline,
      outlineVariant: DarkColorTokens.outlineVariant,
      background: DarkColorTokens.background,
      onBackground: DarkColorTokens.onBackground,
      inverseSurface: DarkColorTokens.inverseSurface,
      onInverseSurface: DarkColorTokens.onInverseSurface,
      inversePrimary: DarkColorTokens.inversePrimary,
      shadow: DarkColorTokens.shadow,
      scrim: DarkColorTokens.scrim,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: AppTextTheme.darkTextTheme(colorScheme),
      cardTheme: CardTheme(
        shape: AppShapeTokens.cardShape,
        elevation: 0,
        margin: const EdgeInsets.all(8),
        color: colorScheme.surfaceVariant,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: AppShapeTokens.buttonShape,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          elevation: 1,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: AppShapeTokens.buttonShape,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: AppShapeTokens.buttonShape,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: AppShapeTokens.chipShape,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppShapeTokens.medium),
        ),
        filled: true,
        fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: AppShapeTokens.bottomSheetShape,
      ),
      dialogTheme: DialogTheme(
        shape: AppShapeTokens.dialogShape,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        shape: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
    );
  }
}

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('theme_mode');
    if (themeModeString != null) {
      state = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == themeModeString,
        orElse: () => ThemeMode.system,
      );
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode.toString());
  }
}

class DynamicColorNotifier extends StateNotifier<bool> {
  DynamicColorNotifier() : super(false) {
    _loadDynamicColorEnabled();
  }

  Future<void> _loadDynamicColorEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('dynamic_color_enabled') ?? false;
  }

  Future<void> setDynamicColorEnabled(bool enabled) async {
    state = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dynamic_color_enabled', enabled);
  }
}
