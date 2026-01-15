import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:hoppr_frontend/core/theme/shape_tokens.dart';
import 'package:hoppr_frontend/l10n/app_localizations.dart';

/// Color picker dialog for custom theme colors
class ColorPickerDialog extends StatefulWidget {
  final Color initialColor;
  final String title;

  const ColorPickerDialog({
    required this.initialColor,
    required this.title,
    super.key,
  });

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: AppShapeTokens.dialogShape,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: theme.textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Color picker
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ColorPicker(
                  color: _selectedColor,
                  onColorChanged: (Color color) {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  width: 40,
                  height: 40,
                  borderRadius: 4,
                  spacing: 5,
                  runSpacing: 5,
                  wheelDiameter: 155,
                  heading: Text(
                    'Select color',
                    style: theme.textTheme.titleMedium,
                  ),
                  subheading: Text(
                    'Select color shade',
                    style: theme.textTheme.titleSmall,
                  ),
                  wheelSubheading: Text(
                    'Selected color and its shades',
                    style: theme.textTheme.titleSmall,
                  ),
                  showMaterialName: true,
                  showColorName: true,
                  showColorCode: true,
                  copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                    longPressMenu: true,
                  ),
                  materialNameTextStyle: theme.textTheme.bodySmall,
                  colorNameTextStyle: theme.textTheme.bodySmall,
                  colorCodeTextStyle: theme.textTheme.bodySmall,
                  pickersEnabled: const <ColorPickerType, bool>{
                    ColorPickerType.both: false,
                    ColorPickerType.primary: true,
                    ColorPickerType.accent: true,
                    ColorPickerType.bw: false,
                    ColorPickerType.custom: true,
                    ColorPickerType.wheel: true,
                  },
                ),
              ),
            ),
            // Actions
            Padding(
              padding: const EdgeInsets.all(16),
              child: Builder(
                builder: (context) {
                  final l10n = AppLocalizations.of(context);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(l10n?.cancel ?? 'Cancel'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.of(context).pop(_selectedColor),
                        child: Text(l10n?.apply ?? 'Apply'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper function to show color picker dialog
Future<Color?> showColorPickerDialog(
  BuildContext context, {
  required Color initialColor,
  required String title,
}) async {
  return await showDialog<Color>(
    context: context,
    builder: (context) => ColorPickerDialog(
      initialColor: initialColor,
      title: title,
    ),
  );
}
