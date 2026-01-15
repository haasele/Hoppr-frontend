import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hoppr_frontend/core/router/routes.dart';
import 'package:hoppr_frontend/l10n/app_localizations.dart';

class BottomNavBar extends StatelessWidget {
  final Widget child;

  const BottomNavBar({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final currentIndex = _getCurrentIndex(location);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(milliseconds: 300),
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go(AppRoutes.home);
              break;
            case 1:
              context.go(AppRoutes.search);
              break;
            case 2:
              context.go(AppRoutes.wishlist);
              break;
            case 3:
              context.go(AppRoutes.chat);
              break;
            case 4:
              context.go(AppRoutes.profile);
              break;
          }
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l10n.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.search_outlined),
            selectedIcon: const Icon(Icons.search),
            label: l10n.search,
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite_outline),
            selectedIcon: const Icon(Icons.favorite),
            label: l10n.wishlist,
          ),
          NavigationDestination(
            icon: const Icon(Icons.chat_bubble_outline),
            selectedIcon: const Icon(Icons.chat_bubble),
            label: l10n.chat,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: l10n.profile,
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(String location) {
    if (location == AppRoutes.home) return 0;
    if (location == AppRoutes.search) return 1;
    if (location == AppRoutes.wishlist) return 2;
    if (location == AppRoutes.chat) return 3;
    if (location == AppRoutes.profile) return 4;
    return 0;
  }
}
