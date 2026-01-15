import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:hoppr_frontend/core/router/routes.dart';
import 'package:hoppr_frontend/core/theme/shape_tokens.dart';
import 'package:hoppr_frontend/features/auth/presentation/feature_gate.dart';
import 'package:hoppr_frontend/features/tickets/data/ticket_repository.dart';
import 'package:hoppr_frontend/features/tickets/domain/ticket.dart';
import 'package:hoppr_frontend/shared/widgets/empty_state.dart';
import 'package:hoppr_frontend/shared/widgets/skeleton_loader.dart';

/// Ticket detail provider
final ticketDetailProvider = FutureProvider.family<Ticket?, String>((ref, id) {
  final repository = ref.watch(ticketRepositoryProvider);
  return repository.getTicketById(id);
});

class TicketDetailScreen extends ConsumerWidget {
  final String ticketId;

  const TicketDetailScreen({
    required this.ticketId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final ticketAsync = ref.watch(ticketDetailProvider(ticketId));

    return Scaffold(
      body: ticketAsync.when(
        data: (ticket) {
          if (ticket == null) {
            return const EmptyState(
              icon: Icons.error_outline,
              title: 'Ticket not found',
              message: 'This ticket does not exist or has been removed',
            );
          }
          return _TicketDetailContent(ticket: ticket);
        },
        loading: () => const _TicketDetailSkeleton(),
        error: (error, stack) => EmptyState(
          icon: Icons.error_outline,
          title: 'Error loading ticket',
          message: error.toString(),
          action: ElevatedButton(
            onPressed: () => ref.invalidate(ticketDetailProvider(ticketId)),
            child: const Text('Retry'),
          ),
        ),
      ),
      bottomNavigationBar: _BottomCTA(ticketId: ticketId),
    );
  }
}

class _TicketDetailContent extends StatelessWidget {
  final Ticket ticket;

  const _TicketDetailContent({required this.ticket});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d, yyyy • HH:mm');

    return CustomScrollView(
      slivers: [
        // App bar with image carousel
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                // TODO: Implement share functionality
              },
              tooltip: 'Share',
            ),
            FeatureGate(
              child: IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  // TODO: Implement wishlist add
                },
                tooltip: 'Save to wishlist',
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: _ImageCarousel(
              imageUrls: ticket.imageUrls ?? [],
            ),
          ),
        ),
        // Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                if (ticket.title != null) ...[
                  Text(
                    ticket.title!,
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                ],
                // Info table
                Card(
                  shape: AppShapeTokens.cardShape,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _InfoRow(
                          icon: Icons.calendar_today,
                          label: 'Valid Until',
                          value: dateFormat.format(ticket.expiresAt),
                        ),
                        const Divider(height: 32),
                        if (ticket.zones != null && ticket.zones!.isNotEmpty)
                          _InfoRow(
                            icon: Icons.map,
                            label: 'Zones',
                            value: ticket.zones!.join(', '),
                          ),
                        if (ticket.zones != null && ticket.zones!.isNotEmpty)
                          const Divider(height: 32),
                        if (ticket.provider != null)
                          _InfoRow(
                            icon: Icons.train,
                            label: 'Provider',
                            value: ticket.provider!,
                          ),
                        if (ticket.provider != null)
                          const Divider(height: 32),
                        if (ticket.type != null)
                          _InfoRow(
                            icon: Icons.category,
                            label: 'Type',
                            value: ticket.type!,
                          ),
                        if (ticket.location != null) ...[
                          const Divider(height: 32),
                          _InfoRow(
                            icon: Icons.location_on,
                            label: 'Location',
                            value: ticket.location!,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Description
                if (ticket.description != null) ...[
                  Text(
                    'Description',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ticket.description!,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                ],
                // User profile snippet
                Card(
                  shape: AppShapeTokens.cardShape,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Icon(
                        Icons.person,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    title: const Text('Ticket Owner'),
                    subtitle: const Text('View all tickets'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Navigate to user profile
                    },
                  ),
                ),
                const SizedBox(height: 100), // Space for bottom CTA
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ImageCarousel extends StatelessWidget {
  final List<String> imageUrls;

  const _ImageCarousel({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (imageUrls.isEmpty) {
      return Container(
        color: theme.colorScheme.surfaceVariant,
        child: Center(
          child: Icon(
            Icons.receipt_long,
            size: 80,
            color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
        ),
      );
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1.0,
        autoPlay: imageUrls.length > 1,
        autoPlayInterval: const Duration(seconds: 3),
      ),
      items: imageUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
              ),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 64,
                      color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                    ),
                  );
                },
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TicketDetailSkeleton extends StatelessWidget {
  const _TicketDetailSkeleton();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          flexibleSpace: Container(
            color: Colors.grey[300],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 32,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: List.generate(4, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: 12,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: 16,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomCTA extends ConsumerWidget {
  final String ticketId;

  const _BottomCTA({required this.ticketId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: FeatureGate(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Navigate to chat or ticket request
              },
              icon: const Icon(Icons.chat),
              label: const Text('Chat / Request Ticket'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
