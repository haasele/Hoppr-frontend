import 'package:flutter/material.dart';
import 'package:hoppr_frontend/l10n/app_localizations.dart';
import 'package:hoppr_frontend/features/auth/presentation/login_modal.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;
  final Widget? action;
  final bool showLoginActions;

  const EmptyState({
    required this.icon,
    required this.title,
    this.message,
    this.action,
    this.showLoginActions = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ],
            if (showLoginActions && action == null) ...[
              const SizedBox(height: 24),
              Builder(
                builder: (context) {
                  final l10n = AppLocalizations.of(context);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showLoginModal(context);
                        },
                        child: Text(l10n?.login ?? 'Login'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {
                          // Show registration - for now, same as login
                          // In the future, this could open a registration page
                          showLoginModal(context);
                        },
                        child: Text(l10n?.register ?? 'Register'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
