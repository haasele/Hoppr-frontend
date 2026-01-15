import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hoppr_frontend/core/router/routes.dart';
import 'package:hoppr_frontend/core/theme/shape_tokens.dart';
import 'package:hoppr_frontend/core/theme/app_theme.dart';
import 'package:hoppr_frontend/features/auth/data/auth_provider.dart';
import 'package:hoppr_frontend/features/tickets/data/ticket_repository.dart';
import 'package:hoppr_frontend/features/tickets/domain/ticket.dart';
import 'package:hoppr_frontend/shared/widgets/empty_state.dart';
import 'package:hoppr_frontend/shared/widgets/skeleton_loader.dart';
import 'package:hoppr_frontend/shared/widgets/ticket_card.dart';

/// User tickets provider
final userTicketsProvider = FutureProvider<List<Ticket>>((ref) {
  final repository = ref.watch(ticketRepositoryProvider);
  final authState = ref.watch(authStateProvider);
  
  if (!authState.isAuthenticated || authState.userId == null) {
    return Future.value(<Ticket>[]);
  }
  
  // TODO: Implement get user tickets
  return repository.getTickets();
});

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authStateProvider);
    final userTicketsAsync = ref.watch(userTicketsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showSettings(context, ref);
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: !authState.isAuthenticated
          ? _UnauthenticatedProfile()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile header
                  _ProfileHeader(email: authState.email ?? ''),
                  const Divider(height: 1),
                  // Stats section
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Statistics',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _StatCard(
                                icon: Icons.star,
                                label: 'Rating',
                                value: '4.8',
                                color: Colors.amber,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _StatCard(
                                icon: Icons.access_time,
                                label: 'Response',
                                value: '< 1h',
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  // My tickets section
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Tickets',
                              style: theme.textTheme.titleLarge,
                            ),
                            TextButton(
                              onPressed: () {
                                // TODO: Navigate to all tickets
                              },
                              child: const Text('View all'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        userTicketsAsync.when(
                          data: (tickets) {
                            if (tickets.isEmpty) {
                              return const EmptyState(
                                icon: Icons.receipt_long,
                                title: 'No tickets yet',
                                message: 'Upload your first ticket to get started',
                              );
                            }
                            return Column(
                              children: tickets.take(3).map((ticket) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: TicketCard(ticket: ticket),
                                );
                              }).toList(),
                            );
                          },
                          loading: () => Column(
                            children: List.generate(3, (index) {
                              return const Padding(
                                padding: EdgeInsets.only(bottom: 16),
                                child: TicketCardSkeleton(),
                              );
                            }),
                          ),
                          error: (error, stack) => EmptyState(
                            icon: Icons.error_outline,
                            title: 'Error loading tickets',
                            message: error.toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Actions section
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Actions',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          leading: const Icon(Icons.upload),
                          title: const Text('Upload Ticket'),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          shape: AppShapeTokens.cardShape,
                          onTap: () {
                            // TODO: Navigate to upload screen
                          },
                        ),
                        const SizedBox(height: 8),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Sign Out'),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          shape: AppShapeTokens.cardShape,
                          onTap: () {
                            ref.read(authStateProvider.notifier).logout();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _showSettings(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: AppShapeTokens.bottomSheetShape,
      isScrollControlled: true,
      builder: (context) => _SettingsSheet(),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final String email;

  const _ProfileHeader({required this.email});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Icon(
              Icons.person,
              size: 40,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  email,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  'Member since 2024',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: AppShapeTokens.cardShape,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UnauthenticatedProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const EmptyState(
      icon: Icons.person_outline,
      title: 'Sign in to view profile',
      message: 'Create an account to manage your tickets and preferences',
    );
  }
}

class _SettingsSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final dynamicColorEnabled = ref.watch(dynamicColorEnabledProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppShapeTokens.extraLarge),
            ),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Settings',
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    // Theme mode
                    Card(
                      shape: AppShapeTokens.cardShape,
                      child: ExpansionTile(
                        leading: const Icon(Icons.palette),
                        title: const Text('Theme'),
                        children: [
                          RadioListTile<ThemeMode>(
                            title: const Text('System'),
                            value: ThemeMode.system,
                            groupValue: themeMode,
                            onChanged: (value) {
                              if (value != null) {
                                ref.read(themeModeProvider.notifier).setThemeMode(value);
                              }
                            },
                          ),
                          RadioListTile<ThemeMode>(
                            title: const Text('Light'),
                            value: ThemeMode.light,
                            groupValue: themeMode,
                            onChanged: (value) {
                              if (value != null) {
                                ref.read(themeModeProvider.notifier).setThemeMode(value);
                              }
                            },
                          ),
                          RadioListTile<ThemeMode>(
                            title: const Text('Dark'),
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
                    // Material You
                    Card(
                      shape: AppShapeTokens.cardShape,
                      child: SwitchListTile(
                        secondary: const Icon(Icons.color_lens),
                        title: const Text('Material You Dynamic Colors'),
                        subtitle: const Text('Use system accent colors'),
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
            ],
          ),
        );
      },
    );
  }
}
