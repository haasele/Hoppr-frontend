import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hoppr_frontend/core/theme/shape_tokens.dart';
import 'package:hoppr_frontend/features/auth/data/auth_provider.dart';
import 'package:hoppr_frontend/features/tickets/domain/ticket.dart';
import 'package:hoppr_frontend/shared/widgets/empty_state.dart';
import 'package:hoppr_frontend/shared/widgets/skeleton_loader.dart';
import 'package:hoppr_frontend/shared/widgets/ticket_card.dart';
import 'package:hoppr_frontend/l10n/app_localizations.dart';

/// Wishlist provider
final wishlistProvider = FutureProvider<List<Ticket>>((ref) {
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
    final l10n = AppLocalizations.of(context)!;

    // Show login prompt if not authenticated
    if (!authState.isAuthenticated) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.wishlist),
          elevation: 0,
        ),
        body: EmptyState(
          icon: Icons.favorite_border,
          title: l10n.signInToSaveTickets,
          message: l10n.createAccountToSaveTickets,
          showLoginActions: true,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.wishlist),
        elevation: 0,
      ),
      body: wishlistAsync.when(
        data: (tickets) {
          if (tickets.isEmpty) {
            return EmptyState(
              icon: Icons.favorite_border,
              title: l10n.yourWishlistIsEmpty,
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
                          label: l10n.remove,
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
          title: l10n.errorLoadingWishlist,
          message: error.toString(),
          action: ElevatedButton(
            onPressed: () => ref.invalidate(wishlistProvider),
            child: Text(l10n.retry),
          ),
        ),
      ),
    );
  }

  void _removeFromWishlist(BuildContext context, WidgetRef ref, String ticketId) {
    // TODO: Implement remove from wishlist
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.removedFromWishlist)),
    );
    ref.invalidate(wishlistProvider);
  }
}
