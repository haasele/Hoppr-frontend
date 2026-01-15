import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hoppr_frontend/core/router/routes.dart';
import 'package:hoppr_frontend/core/theme/shape_tokens.dart';
import 'package:hoppr_frontend/features/tickets/data/ticket_repository.dart';
import 'package:hoppr_frontend/features/tickets/domain/ticket.dart';
import 'package:hoppr_frontend/shared/widgets/empty_state.dart';
import 'package:hoppr_frontend/shared/widgets/skeleton_loader.dart';
import 'package:hoppr_frontend/shared/widgets/ticket_card.dart';

/// Search filters state
class SearchFilters {
  final String? type;
  final String? provider;
  final String? location;
  final DateTime? timeFrom;
  final DateTime? timeTo;

  const SearchFilters({
    this.type,
    this.provider,
    this.location,
    this.timeFrom,
    this.timeTo,
  });

  SearchFilters copyWith({
    String? type,
    String? provider,
    String? location,
    DateTime? timeFrom,
    DateTime? timeTo,
  }) {
    return SearchFilters(
      type: type ?? this.type,
      provider: provider ?? this.provider,
      location: location ?? this.location,
      timeFrom: timeFrom ?? this.timeFrom,
      timeTo: timeTo ?? this.timeTo,
    );
  }

  bool get hasFilters =>
      type != null ||
      provider != null ||
      location != null ||
      timeFrom != null ||
      timeTo != null;
}

/// Search filters provider
final searchFiltersProvider =
    StateProvider<SearchFilters>((ref) => const SearchFilters());

/// Search tickets provider
final searchTicketsProvider = FutureProvider.family<List<Ticket>, String?>((ref, query) {
  final repository = ref.watch(ticketRepositoryProvider);
  final filters = ref.watch(searchFiltersProvider);
  
  return repository.getTickets(
    search: query,
    type: filters.type,
    provider: filters.provider,
    location: filters.location,
  );
});

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  String? _currentQuery;
  int _offset = 0;
  final int _limit = 20;
  bool _isLoadingMore = false;
  List<Ticket> _tickets = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    
    // Check for query from navigation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final query = GoRouterState.of(context).uri.queryParameters['q'];
      if (query != null && query.isNotEmpty) {
        _searchController.text = query;
        _performSearch(query);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || _currentQuery == null) return;
    
    setState(() => _isLoadingMore = true);
    try {
      final repository = ref.read(ticketRepositoryProvider);
      final filters = ref.read(searchFiltersProvider);
      final moreTickets = await repository.getTickets(
        search: _currentQuery,
        type: filters.type,
        provider: filters.provider,
        location: filters.location,
        limit: _limit,
        offset: _offset + _tickets.length,
      );
      setState(() {
        _tickets.addAll(moreTickets);
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() => _isLoadingMore = false);
    }
  }

  void _performSearch(String query) {
    setState(() {
      _currentQuery = query.isEmpty ? null : query;
      _offset = 0;
      _tickets = [];
    });
    ref.invalidate(searchTicketsProvider(_currentQuery));
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      shape: AppShapeTokens.bottomSheetShape,
      isScrollControlled: true,
      builder: (context) => _FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filters = ref.watch(searchFiltersProvider);
    final ticketsAsync = ref.watch(searchTicketsProvider(_currentQuery));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.filter_list),
                if (filters.hasFilters)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: _showFilters,
            tooltip: 'Filters',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search tickets...',
              onSubmitted: _performSearch,
              leading: const Icon(Icons.search),
              trailing: [
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      _performSearch('');
                      setState(() {});
                    },
                  ),
              ],
            ),
          ),
          // Active filters
          if (filters.hasFilters)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                children: [
                  if (filters.type != null)
                    Chip(
                      label: Text('Type: ${filters.type}'),
                      onDeleted: () {
                        ref.read(searchFiltersProvider.notifier).state =
                            filters.copyWith(type: null);
                        ref.invalidate(searchTicketsProvider(_currentQuery));
                      },
                    ),
                  if (filters.provider != null)
                    Chip(
                      label: Text('Provider: ${filters.provider}'),
                      onDeleted: () {
                        ref.read(searchFiltersProvider.notifier).state =
                            filters.copyWith(provider: null);
                        ref.invalidate(searchTicketsProvider(_currentQuery));
                      },
                    ),
                  if (filters.location != null)
                    Chip(
                      label: Text('Location: ${filters.location}'),
                      onDeleted: () {
                        ref.read(searchFiltersProvider.notifier).state =
                            filters.copyWith(location: null);
                        ref.invalidate(searchTicketsProvider(_currentQuery));
                      },
                    ),
                ],
              ),
            ),
          // Ticket list
          Expanded(
            child: ticketsAsync.when(
              data: (tickets) {
                if (_tickets.isEmpty) {
                  _tickets = tickets;
                }
                if (tickets.isEmpty && _currentQuery == null) {
                  return const EmptyState(
                    icon: Icons.search,
                    title: 'Start searching',
                    message: 'Enter a search query to find tickets',
                  );
                }
                if (tickets.isEmpty) {
                  return EmptyState(
                    icon: Icons.search_off,
                    title: 'No tickets found',
                    message: 'Try adjusting your search or filters',
                    action: ElevatedButton(
                      onPressed: () {
                        ref.read(searchFiltersProvider.notifier).state =
                            const SearchFilters();
                        _searchController.clear();
                        _performSearch('');
                      },
                      child: const Text('Clear filters'),
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      _tickets = [];
                      _offset = 0;
                    });
                    ref.invalidate(searchTicketsProvider(_currentQuery));
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _tickets.length + (_isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= _tickets.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: TicketCard(ticket: _tickets[index]),
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
                title: 'Error loading tickets',
                message: error.toString(),
                action: ElevatedButton(
                  onPressed: () => ref.invalidate(searchTicketsProvider(_currentQuery)),
                  child: const Text('Retry'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBottomSheet extends ConsumerStatefulWidget {
  @override
  ConsumerState<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends ConsumerState<_FilterBottomSheet> {
  final _typeController = TextEditingController();
  final _providerController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final filters = ref.read(searchFiltersProvider);
    _typeController.text = filters.type ?? '';
    _providerController.text = filters.provider ?? '';
    _locationController.text = filters.location ?? '';
  }

  @override
  void dispose() {
    _typeController.dispose();
    _providerController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    ref.read(searchFiltersProvider.notifier).state = SearchFilters(
      type: _typeController.text.isEmpty ? null : _typeController.text,
      provider: _providerController.text.isEmpty ? null : _providerController.text,
      location: _locationController.text.isEmpty ? null : _locationController.text,
    );
    Navigator.pop(context);
  }

  void _clearFilters() {
    _typeController.clear();
    _providerController.clear();
    _locationController.clear();
    ref.read(searchFiltersProvider.notifier).state = const SearchFilters();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filters',
                      style: theme.textTheme.headlineSmall,
                    ),
                    TextButton(
                      onPressed: _clearFilters,
                      child: const Text('Clear all'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    TextField(
                      controller: _typeController,
                      decoration: const InputDecoration(
                        labelText: 'Ticket Type',
                        hintText: 'e.g., Monthly, Single, Day Pass',
                        prefixIcon: Icon(Icons.category),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _providerController,
                      decoration: const InputDecoration(
                        labelText: 'Provider',
                        hintText: 'e.g., DB, BVG, S-Bahn',
                        prefixIcon: Icon(Icons.train),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        hintText: 'e.g., Berlin, Munich',
                        prefixIcon: Icon(Icons.location_on),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _applyFilters,
                    child: const Text('Apply Filters'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
