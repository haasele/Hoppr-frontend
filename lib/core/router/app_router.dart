import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hoppr_frontend/core/router/routes.dart';
import 'package:hoppr_frontend/features/chat/presentation/chat_list_screen.dart';
import 'package:hoppr_frontend/features/chat/presentation/chat_detail_screen.dart';
import 'package:hoppr_frontend/features/profile/presentation/profile_screen.dart';
import 'package:hoppr_frontend/features/tickets/presentation/home_screen.dart';
import 'package:hoppr_frontend/features/tickets/presentation/search_screen.dart';
import 'package:hoppr_frontend/features/tickets/presentation/ticket_detail_screen.dart';
import 'package:hoppr_frontend/features/wishlist/presentation/wishlist_screen.dart';
import 'package:hoppr_frontend/shared/widgets/bottom_nav_bar.dart';

/// Router provider
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return BottomNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: AppRouteNames.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.search,
            name: AppRouteNames.search,
            builder: (context, state) => const SearchScreen(),
          ),
          GoRoute(
            path: AppRoutes.wishlist,
            name: AppRouteNames.wishlist,
            builder: (context, state) => const WishlistScreen(),
          ),
          GoRoute(
            path: AppRoutes.chat,
            name: AppRouteNames.chat,
            builder: (context, state) => const ChatListScreen(),
          ),
          GoRoute(
            path: AppRoutes.profile,
            name: AppRouteNames.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.ticketDetail,
        name: AppRouteNames.ticketDetail,
        builder: (context, state) {
          final ticketId = state.pathParameters['id']!;
          return TicketDetailScreen(ticketId: ticketId);
        },
      ),
      GoRoute(
        path: AppRoutes.chatDetail,
        name: AppRouteNames.chatDetail,
        builder: (context, state) {
          final chatId = state.pathParameters['id']!;
          return ChatDetailScreen(chatId: chatId);
        },
      ),
    ],
  );
});
