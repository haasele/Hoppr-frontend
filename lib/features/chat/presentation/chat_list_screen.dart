import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:hoppr_frontend/core/router/routes.dart';
import 'package:hoppr_frontend/core/theme/shape_tokens.dart';
import 'package:hoppr_frontend/data/api/api_service.dart';
import 'package:hoppr_frontend/data/api/models/chat_dto.dart';
import 'package:hoppr_frontend/features/auth/data/auth_provider.dart';
import 'package:hoppr_frontend/shared/widgets/empty_state.dart';
import 'package:hoppr_frontend/shared/widgets/skeleton_loader.dart';
import 'package:hoppr_frontend/l10n/app_localizations.dart';

/// Conversations provider
final conversationsProvider = FutureProvider<List<ConversationDto>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getConversations();
});

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final conversationsAsync = ref.watch(conversationsProvider);
    final l10n = AppLocalizations.of(context)!;

    // Show login prompt if not authenticated
    if (!authState.isAuthenticated) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.chat),
          elevation: 0,
        ),
        body: EmptyState(
          icon: Icons.chat_bubble_outline,
          title: l10n.signInToChat,
          message: l10n.createAccountToStartConversations,
          showLoginActions: true,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.chat),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Implement new conversation flow
            },
            tooltip: 'New conversation',
          ),
        ],
      ),
      body: conversationsAsync.when(
        data: (conversations) {
          if (conversations.isEmpty) {
            return EmptyState(
              icon: Icons.chat_bubble_outline,
              title: l10n.noConversations,
              message: 'Start a conversation from a ticket detail page',
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(conversationsProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return _ConversationListItem(conversation: conversation);
              },
            ),
          );
        },
        loading: () => ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 5,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: ListItemSkeleton(),
            );
          },
        ),
        error: (error, stack) => EmptyState(
          icon: Icons.error_outline,
          title: l10n.errorLoadingConversations,
          message: error.toString(),
          action: ElevatedButton(
            onPressed: () => ref.invalidate(conversationsProvider),
            child: Text(l10n.retry),
          ),
        ),
      ),
    );
  }
}

class _ConversationListItem extends StatelessWidget {
  final ConversationDto conversation;

  const _ConversationListItem({required this.conversation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d');
    final timeFormat = DateFormat('HH:mm');

    String? lastMessageTime;
    if (conversation.lastMessageAt != null) {
      try {
        final date = DateTime.parse(conversation.lastMessageAt!);
        final now = DateTime.now();
        if (date.year == now.year && date.month == now.month && date.day == now.day) {
          lastMessageTime = timeFormat.format(date);
        } else {
          lastMessageTime = dateFormat.format(date);
        }
      } catch (e) {
        // Ignore parse errors
      }
    }

    return Card(
      shape: AppShapeTokens.cardShape,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(
            Icons.person,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          'User ${conversation.userId.substring(0, 8)}',
          style: theme.textTheme.titleMedium,
        ),
        subtitle: conversation.lastMessage != null
            ? Text(
                conversation.lastMessage!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              )
            : null,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (lastMessageTime != null)
              Text(
                lastMessageTime,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            if (conversation.unreadCount > 0) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  conversation.unreadCount.toString(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ],
        ),
        onTap: () {
          context.go('${AppRoutes.chatDetail.replaceAll(':id', conversation.id)}');
        },
      ),
    );
  }
}
