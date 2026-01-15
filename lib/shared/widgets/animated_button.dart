import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hoppr_frontend/core/theme/shape_tokens.dart';

/// Expressive animated button with motion feedback
class AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final bool isLoading;

  const AnimatedButton({
    required this.child,
    this.onPressed,
    this.style,
    this.isLoading = false,
    super.key,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (widget.onPressed != null && !widget.isLoading) {
          setState(() => _isPressed = true);
        }
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        if (widget.onPressed != null && !widget.isLoading) {
          widget.onPressed!();
        }
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        child: widget.isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.style?.foregroundColor?.resolve({}) ??
                        Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              )
            : widget.child,
      )
          .animate(target: _isPressed ? 1 : 0)
          .scale(begin: const Offset(1, 1), end: const Offset(0.95, 0.95), duration: 100.ms),
    );
  }
}

/// Animated Elevated Button
class AnimatedElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final bool isLoading;

  const AnimatedElevatedButton({
    required this.child,
    this.onPressed,
    this.style,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onPressed,
      isLoading: isLoading,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: child,
      ),
    );
  }
}
