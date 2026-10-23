/// Model representing paginated API response data.
class PaginationModel<T> {
  final List<T> items;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int limit;
  final bool hasMore;

  const PaginationModel({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    this.limit = 10,
    required this.hasMore,
  });

  /// Factory constructor to parse common pagination JSON structures safely.
  factory PaginationModel.fromJson({
    required Map<String, dynamic> json,
    required T Function(dynamic itemJson) fromItemJson,
    String itemsKey = 'items',
    String pageKey = 'page',
    String totalPagesKey = 'total_pages',
    String totalItemsKey = 'total',
    String limitKey = 'limit',
  }) {
    final rawList = (json[itemsKey] as List<dynamic>?) ??
        (json['data'] as List<dynamic>?) ??
        (json['results'] as List<dynamic>?) ??
        [];

    final items = rawList.map((item) => fromItemJson(item)).toList();
    final page = (json[pageKey] as num?)?.toInt() ?? 1;
    final total = (json[totalItemsKey] as num?)?.toInt() ?? items.length;
    final limit = (json[limitKey] as num?)?.toInt() ?? (items.isNotEmpty ? items.length : 10);
    final totalPages = (json[totalPagesKey] as num?)?.toInt() ??
        (limit > 0 ? (total / limit).ceil() : 1);

    final hasMore = page < totalPages;

    return PaginationModel<T>(
      items: items,
      currentPage: page,
      totalPages: totalPages,
      totalItems: total,
      limit: limit,
      hasMore: hasMore,
    );
  }

  /// Creates an empty pagination model.
  factory PaginationModel.empty() {
    return const PaginationModel(
      items: [],
      currentPage: 1,
      totalPages: 0,
      totalItems: 0,
      limit: 10,
      hasMore: false,
    );
  }

  /// Appends more items to this pagination instance (for infinite scrolling).
  PaginationModel<T> appendMore(PaginationModel<T> next) {
    return PaginationModel<T>(
      items: [...items, ...next.items],
      currentPage: next.currentPage,
      totalPages: next.totalPages,
      totalItems: next.totalItems,
      limit: next.limit,
      hasMore: next.hasMore,
    );
  }
}
