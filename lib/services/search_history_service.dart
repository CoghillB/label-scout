import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing search history using SharedPreferences
class SearchHistoryService {
  static const String _searchHistoryKey = 'search_history';
  static const int _maxHistoryItems = 50; // Keep last 50 searches

  /// Saves a search query to history
  Future<void> saveSearch(String query) async {
    if (query.trim().isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final history = await getSearchHistory();

    // Remove if already exists (to move it to top)
    history.remove(query.trim());

    // Add to beginning of list
    history.insert(0, query.trim());

    // Limit to max items
    if (history.length > _maxHistoryItems) {
      history.removeRange(_maxHistoryItems, history.length);
    }

    // Save back to preferences
    await prefs.setStringList(_searchHistoryKey, history);
  }

  /// Gets all search history (most recent first)
  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_searchHistoryKey) ?? [];
  }

  /// Gets filtered search suggestions based on query
  Future<List<String>> getSearchSuggestions(String query) async {
    if (query.trim().isEmpty) {
      // Return recent searches if no query
      final history = await getSearchHistory();
      return history.take(10).toList();
    }

    final history = await getSearchHistory();
    final lowercaseQuery = query.toLowerCase().trim();

    // Filter history that starts with or contains the query
    final matches = history.where((item) {
      final lowercaseItem = item.toLowerCase();
      return lowercaseItem.startsWith(lowercaseQuery) ||
          lowercaseItem.contains(lowercaseQuery);
    }).toList();

    return matches.take(10).toList();
  }

  /// Clears all search history
  Future<void> clearSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_searchHistoryKey);
  }

  /// Removes a specific search from history
  Future<void> removeSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getSearchHistory();

    history.remove(query);

    await prefs.setStringList(_searchHistoryKey, history);
  }
}
