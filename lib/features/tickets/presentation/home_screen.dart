import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hoppr_frontend/core/router/routes.dart';
import 'package:hoppr_frontend/features/tickets/data/ticket_repository.dart';
import 'package:hoppr_frontend/features/tickets/domain/ticket.dart';
import 'package:hoppr_frontend/features/auth/data/auth_provider.dart';
import 'package:hoppr_frontend/shared/widgets/empty_state.dart';
import 'package:hoppr_frontend/shared/widgets/login_banner.dart';
import 'package:hoppr_frontend/shared/widgets/skeleton_loader.dart';
import 'package:hoppr_frontend/shared/widgets/ticket_card.dart';
import 'package:hoppr_frontend/l10n/app_localizations.dart';

/// Home screen provider
final homeTicketsProvider = FutureProvider<List<Ticket>>((ref) {
  final repository = ref.watch(ticketRepositoryProvider);
  return repository.getTickets(limit: 10);
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    if (query.isNotEmpty) {
      context.go('${AppRoutes.search}?q=$query');
    } else {
      context.go(AppRoutes.search);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ticketsAsync = ref.watch(homeTicketsProvider);
    final authState = ref.watch(authStateProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Login banner (only show if not authenticated)
          if (!authState.isAuthenticated) const LoginBanner(),
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              controller: _searchController,
              hintText: l10n.searchTickets,
              onSubmitted: _handleSearch,
              leading: const Icon(Icons.search),
              trailing: [
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  ),
              ],
            ),
          ),
          // Recent tickets
          Expanded(
            child: ticketsAsync.when(
              data: (tickets) {
                if (tickets.isEmpty) {
                  return EmptyState(
                    icon: Icons.search_off,
                    title: l10n.noRecentTickets,
                    message: l10n.startSearching,
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: tickets.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TicketCard(ticket: tickets[index])
                          .animate()
                          .fadeIn(duration: 300.ms, delay: (index * 50).ms)
                          .slideY(begin: 0.1, end: 0, duration: 300.ms, delay: (index * 50).ms),
                    );
                  },
                );
              },
              loading: () => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: TicketCardSkeleton(),
                  );
                },
              ),
              error: (error, stack) => EmptyState(
                icon: Icons.error_outline,
                title: l10n.errorLoadingTickets,
                message: error.toString(),
                action: ElevatedButton(
                  onPressed: () => ref.invalidate(homeTicketsProvider),
                  child: Text(l10n.retry),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
