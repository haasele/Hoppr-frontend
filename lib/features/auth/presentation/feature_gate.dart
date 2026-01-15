import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoppr_frontend/features/auth/data/auth_provider.dart';
import 'package:hoppr_frontend/features/auth/presentation/login_modal.dart';

/// Widget that gates features behind authentication
/// Shows login modal if user is not authenticated
class FeatureGate extends ConsumerWidget {
  final Widget child;
  final VoidCallback? onAuthenticated;

  const FeatureGate({
    required this.child,
    this.onAuthenticated,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    if (authState.isAuthenticated) {
      return child;
    }

    return GestureDetector(
      onTap: () {
        showLoginModal(
          context,
          onLoginSuccess: onAuthenticated,
        );
      },
      child: child,
    );
  }
}

/// Helper function to check if action requires auth and show modal if needed
Future<bool> requireAuth(BuildContext context, WidgetRef ref) async {
  final authState = ref.read(authStateProvider);
  if (authState.isAuthenticated) {
    return true;
  }

  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (context) => LoginModal(),
  );

  return result ?? false;
}
