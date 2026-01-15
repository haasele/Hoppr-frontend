import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hoppr_frontend/core/theme/color_tokens.dart';
import 'package:hoppr_frontend/core/theme/custom_color_provider.dart';
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
  final customAccentColor = ref.watch(customAccentColorProvider);

  return AppTheme(
    themeMode: themeMode,
    dynamicColorEnabled: dynamicColorEnabled,
    customAccentColor: customAccentColor,
  );
});

class AppTheme {
  final ThemeMode themeMode;
  final bool dynamicColorEnabled;
  final Color? customAccentColor;

  AppTheme({
    required this.themeMode,
    required this.dynamicColorEnabled,
    this.customAccentColor,
  });

  /// Generate Material 3 ColorScheme from a single seed color
  /// This generates the complete color scheme including backgrounds from one accent color
  ColorScheme _generateColorSchemeFromSeed(Color seedColor, Brightness brightness) {
    return ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );
  }

  ThemeData get lightTheme {
    final colorScheme = customAccentColor != null
        ? _generateColorSchemeFromSeed(customAccentColor!, Brightness.light)
        : const ColorScheme.light(
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
      surfaceContainerHighest: LightColorTokens.surfaceVariant,
      surfaceContainerHigh: Color(0xFFEDE7F0),
      surfaceContainer: Color(0xFFE7E0EC),
      surfaceContainerLow: Color(0xFFE1DAE8),
      surfaceContainerLowest: Color(0xFFFFFBFE),
      onSurfaceVariant: LightColorTokens.onSurfaceVariant,
      outline: LightColorTokens.outline,
      outlineVariant: LightColorTokens.outlineVariant,
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
      cardTheme: CardThemeData(
        shape: AppShapeTokens.cardShape,
        elevation: 0,
        margin: const EdgeInsets.all(8),
        color: colorScheme.surfaceContainerHighest,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppShapeTokens.extraLarge),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppShapeTokens.extraLarge),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppShapeTokens.extraLarge),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppShapeTokens.extraLarge),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppShapeTokens.medium),
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: AppShapeTokens.bottomSheetShape,
      ),
      dialogTheme: DialogThemeData(
        shape: AppShapeTokens.dialogShape,
        elevation: 0,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
          ),
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    final colorScheme = customAccentColor != null
        ? _generateColorSchemeFromSeed(customAccentColor!, Brightness.dark)
        : const ColorScheme.dark(
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
      surfaceContainerHighest: DarkColorTokens.surfaceVariant,
      surfaceContainerHigh: Color(0xFF3F3A47),
      surfaceContainer: Color(0xFF49454F),
      surfaceContainerLow: Color(0xFF53505A),
      surfaceContainerLowest: Color(0xFF1C1B1F),
      onSurfaceVariant: DarkColorTokens.onSurfaceVariant,
      outline: DarkColorTokens.outline,
      outlineVariant: DarkColorTokens.outlineVariant,
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
      cardTheme: CardThemeData(
        shape: AppShapeTokens.cardShape,
        elevation: 0,
        margin: const EdgeInsets.all(8),
        color: colorScheme.surfaceContainerHighest,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppShapeTokens.extraLarge),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppShapeTokens.extraLarge),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppShapeTokens.extraLarge),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppShapeTokens.extraLarge),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppShapeTokens.medium),
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: AppShapeTokens.bottomSheetShape,
      ),
      dialogTheme: DialogThemeData(
        shape: AppShapeTokens.dialogShape,
        elevation: 0,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
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
