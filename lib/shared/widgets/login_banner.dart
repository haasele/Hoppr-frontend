import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hoppr_frontend/core/theme/shape_tokens.dart';
import 'package:hoppr_frontend/features/auth/presentation/login_modal.dart';
import 'package:hoppr_frontend/l10n/app_localizations.dart';

/// Provider for banner dismissal state
final bannerDismissedProvider = StateNotifierProvider<BannerDismissedNotifier, bool>(
  (ref) => BannerDismissedNotifier(),
);

class BannerDismissedNotifier extends StateNotifier<bool> {
  BannerDismissedNotifier() : super(false) {
    _loadDismissedState();
  }

  Future<void> _loadDismissedState() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('login_banner_dismissed') ?? false;
  }

  Future<void> dismiss() async {
    state = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('login_banner_dismissed', true);
  }

  Future<void> reset() async {
    state = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('login_banner_dismissed');
  }
}

/// Dismissible login/register banner widget
class LoginBanner extends ConsumerWidget {
  const LoginBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isDismissed = ref.watch(bannerDismissedProvider);

    if (isDismissed) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppShapeTokens.large),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: theme.colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.welcomeToHoppr,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.signInOrCreateAccount,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => ref.read(bannerDismissedProvider.notifier).dismiss(),
            color: theme.colorScheme.onPrimaryContainer,
            tooltip: l10n.dismiss,
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              showLoginModal(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
            ),
            child: Text(l10n.getStarted),
          ),
        ],
      ),
    );
  }
}
