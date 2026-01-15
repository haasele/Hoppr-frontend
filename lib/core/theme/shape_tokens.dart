import 'package:flutter/material.dart';

/// Expressive shape definitions for Material 3
class AppShapeTokens {
  /// Extra small rounded corners (4dp)
  static const double extraSmall = 4.0;

  /// Small rounded corners (8dp)
  static const double small = 8.0;

  /// Medium rounded corners (12dp)
  static const double medium = 12.0;

  /// Large rounded corners (16dp)
  static const double large = 16.0;

  /// Extra large rounded corners (28dp)
  static const double extraLarge = 28.0;

  /// Expressive card shape (large rounded corners)
  static ShapeBorder cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(large),
  );

  /// Expressive button shape (extra large rounded corners)
  static ShapeBorder buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(extraLarge),
  );

  /// Expressive chip shape (extra large rounded corners)
  static ShapeBorder chipShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(extraLarge),
  );

  /// Expressive bottom sheet shape (rounded top corners)
  static ShapeBorder bottomSheetShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(extraLarge),
    ),
  );

  /// Expressive dialog shape
  static ShapeBorder dialogShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(extraLarge),
  );

  /// Expressive input field shape
  static ShapeBorder inputShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(medium),
  );
}
