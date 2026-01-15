import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Custom accent color provider - stores a single accent color that drives the entire theme
final customAccentColorProvider =
    StateNotifierProvider<CustomAccentColorNotifier, Color?>(
  (ref) => CustomAccentColorNotifier(),
);

class CustomAccentColorNotifier extends StateNotifier<Color?> {
  CustomAccentColorNotifier() : super(null) {
    _loadCustomColor();
  }

  Future<void> _loadCustomColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt('custom_accent_color');
    if (colorValue != null) {
      state = Color(colorValue);
    }
  }

  Future<void> setAccentColor(Color color) async {
    state = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('custom_accent_color', color.value);
  }

  Future<void> clearAccentColor() async {
    state = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('custom_accent_color');
  }
}
