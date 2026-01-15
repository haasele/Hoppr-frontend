import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoppr_frontend/l10n/app_localizations.dart';
import 'package:hoppr_frontend/core/theme/app_theme.dart';
import 'package:hoppr_frontend/core/theme/custom_color_provider.dart';
import 'package:hoppr_frontend/core/theme/locale_provider.dart';
import 'package:hoppr_frontend/core/theme/shape_tokens.dart';
import 'package:hoppr_frontend/features/profile/presentation/color_picker_dialog.dart';

/// Settings dialog widget
class SettingsDialog extends ConsumerWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    final dynamicColorEnabled = ref.watch(dynamicColorEnabledProvider);
    final currentLocale = ref.watch(localeProvider);
    final customAccentColor = ref.watch(customAccentColorProvider);

    return Dialog(
      shape: AppShapeTokens.dialogShape,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with title and close button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.settings,
                    style: theme.textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: l10n.cancel,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Settings content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Theme mode
                    Card(
                      shape: AppShapeTokens.cardShape,
                      child: ExpansionTile(
                        leading: const Icon(Icons.palette),
                        title: Text(l10n.theme),
                        children: [
                          RadioListTile<ThemeMode>(
                            title: Text(l10n.system),
                            value: ThemeMode.system,
                            groupValue: themeMode,
                            onChanged: (value) {
                              if (value != null) {
                                ref.read(themeModeProvider.notifier).setThemeMode(value);
                              }
                            },
                          ),
                          RadioListTile<ThemeMode>(
                            title: Text(l10n.light),
                            value: ThemeMode.light,
                            groupValue: themeMode,
                            onChanged: (value) {
                              if (value != null) {
                                ref.read(themeModeProvider.notifier).setThemeMode(value);
                              }
                            },
                          ),
                          RadioListTile<ThemeMode>(
                            title: Text(l10n.dark),
                            value: ThemeMode.dark,
                            groupValue: themeMode,
                            onChanged: (value) {
                              if (value != null) {
                                ref.read(themeModeProvider.notifier).setThemeMode(value);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Language
                    Card(
                      shape: AppShapeTokens.cardShape,
                      child: ExpansionTile(
                        leading: const Icon(Icons.language),
                        title: Text(l10n.language),
                        children: [
                          RadioListTile<Locale>(
                            title: Text(l10n.english),
                            value: const Locale('en'),
                            groupValue: currentLocale,
                            onChanged: (value) {
                              if (value != null) {
                                ref.read(localeProvider.notifier).setLocale(value);
                              }
                            },
                          ),
                          RadioListTile<Locale>(
                            title: Text(l10n.german),
                            value: const Locale('de'),
                            groupValue: currentLocale,
                            onChanged: (value) {
                              if (value != null) {
                                ref.read(localeProvider.notifier).setLocale(value);
                              }
                            },
                          ),
                          RadioListTile<Locale>(
                            title: Text(l10n.french),
                            value: const Locale('fr'),
                            groupValue: currentLocale,
                            onChanged: (value) {
                              if (value != null) {
                                ref.read(localeProvider.notifier).setLocale(value);
                              }
                            },
                          ),
                          RadioListTile<Locale>(
                            title: Text(l10n.spanish),
                            value: const Locale('es'),
                            groupValue: currentLocale,
                            onChanged: (value) {
                              if (value != null) {
                                ref.read(localeProvider.notifier).setLocale(value);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Custom Accent Color
                    Card(
                      shape: AppShapeTokens.cardShape,
                      child: ListTile(
                        leading: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: customAccentColor ?? theme.colorScheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.colorScheme.outline,
                              width: 2,
                            ),
                          ),
                        ),
                        title: Text(l10n.accentColor),
                        subtitle: Text(
                          customAccentColor != null
                              ? l10n.customColorApplied
                              : l10n.tapToCustomize,
                          style: theme.textTheme.bodySmall,
                        ),
                        trailing: customAccentColor != null
                            ? IconButton(
                                icon: const Icon(Icons.refresh),
                                onPressed: () {
                                  ref.read(customAccentColorProvider.notifier).clearAccentColor();
                                },
                                tooltip: l10n.resetToDefault,
                              )
                            : const Icon(Icons.chevron_right),
                        onTap: () async {
                          final color = await showColorPickerDialog(
                            context,
                            initialColor: customAccentColor ?? theme.colorScheme.primary,
                            title: l10n.chooseAccentColor,
                          );
                          if (color != null) {
                            ref.read(customAccentColorProvider.notifier).setAccentColor(color);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Material You
                    Card(
                      shape: AppShapeTokens.cardShape,
                      child: SwitchListTile(
                        secondary: const Icon(Icons.color_lens),
                        title: Text(l10n.materialYouDynamicColors),
                        subtitle: Text(l10n.useSystemAccentColors),
                        value: dynamicColorEnabled,
                        onChanged: (value) {
                          ref.read(dynamicColorEnabledProvider.notifier)
                              .setDynamicColorEnabled(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper function to show settings dialog
Future<void> showSettingsDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => const SettingsDialog(),
  );
}
