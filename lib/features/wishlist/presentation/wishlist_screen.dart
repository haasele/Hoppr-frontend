import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:hoppr_frontend/core/router/routes.dart';
import 'package:hoppr_frontend/core/theme/shape_tokens.dart';
import 'package:hoppr_frontend/features/auth/data/auth_provider.dart';
import 'package:hoppr_frontend/features/tickets/data/ticket_repository.dart';
import 'package:hoppr_frontend/features/tickets/domain/ticket.dart';
import 'package:hoppr_frontend/shared/widgets/empty_state.dart';
import 'package:hoppr_frontend/shared/widgets/skeleton_loader.dart';
import 'package:hoppr_frontend/shared/widgets/ticket_card.dart';

/// Wishlist provider
final wishlistProvider = FutureProvider<List<Ticket>>((ref) {
  final repository = ref.watch(ticketRepositoryProvider);
  // TODO: Implement wishlist repository method
  // For now, return empty list
  return Future.value(<Ticket>[]);
});

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final wishlistAsync = ref.watch(wishlistProvider);

    // Show login prompt if not authenticated
    if (!authState.isAuthenticated) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Wishlist'),
          elevation: 0,
        ),
        body: const EmptyState(
          icon: Icons.favorite_border,
          title: 'Sign in to save tickets',
          message: 'Create an account to save tickets to your wishlist',
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        elevation: 0,
      ),
      body: wishlistAsync.when(
        data: (tickets) {
          if (tickets.isEmpty) {
            return const EmptyState(
              icon: Icons.favorite_border,
              title: 'Your wishlist is empty',
              message: 'Save tickets you like to view them later',
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(wishlistProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticket = tickets[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_) {
                            _removeFromWishlist(context, ref, ticket.id);
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Remove',
                          borderRadius: BorderRadius.circular(AppShapeTokens.large),
                        ),
                      ],
                    ),
                    child: TicketCard(ticket: ticket),
                  ),
                );
              },
            ),
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
          title: 'Error loading wishlist',
          message: error.toString(),
          action: ElevatedButton(
            onPressed: () => ref.invalidate(wishlistProvider),
            child: const Text('Retry'),
          ),
        ),
      ),
    );
  }

  void _removeFromWishlist(BuildContext context, WidgetRef ref, String ticketId) {
    // TODO: Implement remove from wishlist
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Removed from wishlist')),
    );
    ref.invalidate(wishlistProvider);
  }
}
