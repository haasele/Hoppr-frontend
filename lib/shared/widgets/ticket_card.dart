import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:hoppr_frontend/core/router/routes.dart';
import 'package:hoppr_frontend/core/theme/shape_tokens.dart';
import 'package:hoppr_frontend/features/tickets/domain/ticket.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final VoidCallback? onTap;

  const TicketCard({
    required this.ticket,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d, yyyy');

    return Card(
      shape: AppShapeTokens.cardShape,
      child: InkWell(
        onTap: onTap ??
            () => context.go('/tickets/${ticket.id}'),
        borderRadius: BorderRadius.circular(AppShapeTokens.large),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image placeholder
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppShapeTokens.large),
                ),
              ),
              child: ticket.imageUrls != null && ticket.imageUrls!.isNotEmpty
                  ? Image.network(
                      ticket.imageUrls!.first,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildPlaceholder(theme),
                    )
                  : _buildPlaceholder(theme),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (ticket.title != null)
                    Text(
                      ticket.title!,
                      style: theme.textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Expires: ${dateFormat.format(ticket.expiresAt)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  if (ticket.type != null || ticket.provider != null) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        if (ticket.type != null)
                          Chip(
                            label: Text(ticket.type!),
                            visualDensity: VisualDensity.compact,
                          ),
                        if (ticket.provider != null)
                          Chip(
                            label: Text(ticket.provider!),
                            visualDensity: VisualDensity.compact,
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Center(
      child: Icon(
        Icons.receipt_long,
        size: 64,
        color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
      ),
    );
  }
}
