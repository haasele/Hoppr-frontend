import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hoppr_frontend/core/theme/shape_tokens.dart';
import 'package:hoppr_frontend/features/auth/data/auth_provider.dart';
import 'package:hoppr_frontend/l10n/app_localizations.dart';

class LoginModal extends ConsumerStatefulWidget {
  final VoidCallback? onDismiss;
  final VoidCallback? onLoginSuccess;

  const LoginModal({
    this.onDismiss,
    this.onLoginSuccess,
    super.key,
  });

  @override
  ConsumerState<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends ConsumerState<LoginModal> {
  bool _isLoading = false;
  bool _showRegister = false;

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final success = await ref.read(authStateProvider.notifier).login();
      if (success && mounted) {
        widget.onLoginSuccess?.call();
        Navigator.of(context).pop();
      } else if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.loginFailed),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.error}: ${e.toString()}'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleRegister() async {
    // Open Keycloak registration page
    final registrationUrl = Uri.parse(
      'http://localhost:8080/realms/ticket-platform/protocol/openid-connect/registrations?client_id=hoppr-frontend&redirect_uri=com.hoppr.app://login-callback&response_type=code',
    );
    
    try {
      if (await canLaunchUrl(registrationUrl)) {
        await launchUrl(registrationUrl, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.couldNotOpenRegistrationPage),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.errorOpeningRegistration}: ${e.toString()}'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      shape: AppShapeTokens.dialogShape,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _showRegister ? l10n.createAnAccount : l10n.loginRequired,
                  style: theme.textTheme.headlineSmall,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: widget.onDismiss ?? () => Navigator.of(context).pop(),
                  tooltip: l10n.close,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _showRegister
                  ? l10n.createAccountToManage
                  : l10n.youNeedToBeLoggedIn,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : (_showRegister ? _handleRegister : _handleLogin),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_showRegister ? l10n.registerWithKeycloak : l10n.loginWithKeycloak),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showRegister = !_showRegister;
                    });
                  },
                  child: Text(_showRegister ? l10n.alreadyHaveAccount : l10n.needAccount),
                ),
                TextButton(
                  onPressed: widget.onDismiss ?? () => Navigator.of(context).pop(),
                  child: Text(l10n.cancel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper function to show login modal
Future<void> showLoginModal(
  BuildContext context, {
  VoidCallback? onLoginSuccess,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => LoginModal(
      onLoginSuccess: onLoginSuccess,
    ),
  );
}
