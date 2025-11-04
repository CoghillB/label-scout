import 'package:flutter/material.dart';

import '../models/diet_profile.dart';
import '../services/food_api_service.dart';
import '../services/ingredient_analysis_service.dart';
import '../services/pro_status_service.dart';
import '../services/profile_service.dart';
import '../services/search_history_service.dart';
import 'result_screen.dart';
import 'upgrade_screen.dart';

/// Screen for searching food products by name
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FoodApiService _foodApiService = FoodApiService();
  final IngredientAnalysisService _analysisService = IngredientAnalysisService();
  final ProfileService _profileService = ProfileService();
  final ProStatusService _proStatusService = ProStatusService();
  final SearchHistoryService _searchHistoryService = SearchHistoryService();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  List<Map<String, dynamic>> _searchResults = [];
  List<String> _searchSuggestions = [];
  bool _isSearching = false;
  bool _hasSearched = false;
  bool _showSuggestions = false;
  String? _error;
  List<DietProfile> _activeProfiles = [];
  bool _isProUser = false;

  @override
  void initState() {
    super.initState();
    _loadActiveProfiles();
    _loadInitialSuggestions();
    
    // Listen to focus changes to show/hide suggestions
    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus && _searchController.text.isEmpty) {
        _loadSuggestions('');
      } else if (!_searchFocusNode.hasFocus) {
        setState(() {
          _showSuggestions = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  /// Load initial recent searches
  Future<void> _loadInitialSuggestions() async {
    final suggestions = await _searchHistoryService.getSearchHistory();
    if (mounted) {
      setState(() {
        _searchSuggestions = suggestions.take(10).toList();
      });
    }
  }

  /// Load search suggestions based on current query
  Future<void> _loadSuggestions(String query) async {
    final suggestions = await _searchHistoryService.getSearchSuggestions(query);
    if (mounted) {
      setState(() {
        _searchSuggestions = suggestions;
        _showSuggestions = suggestions.isNotEmpty;
      });
    }
  }

  /// Load active dietary profiles
  Future<void> _loadActiveProfiles() async {
    try {
      final isPro = await _proStatusService.isProUser();
      final profiles = isPro
          ? await _profileService.getActiveProfiles()
          : [(await _profileService.getActiveProfile())].whereType<DietProfile>().toList();

      if (mounted) {
        setState(() {
          _activeProfiles = profiles;
          _isProUser = isPro;
        });
      }
    } catch (e) {
      // Silently handle error - will show message if no profiles active
    }
  }

  /// Search for products by name
  Future<void> _searchProducts(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _error = 'Please enter a search term';
      });
      return;
    }

    if (_activeProfiles.isEmpty) {
      setState(() {
        _error = 'No active dietary profile. Please select one in the Profiles tab.';
      });
      return;
    }

    // Save to search history
    await _searchHistoryService.saveSearch(query.trim());

    setState(() {
      _isSearching = true;
      _hasSearched = false;
      _error = null;
      _searchResults = [];
      _showSuggestions = false; // Hide suggestions when searching
    });

    try {
      final results = await _foodApiService.searchProducts(query.trim());

      if (mounted) {
        setState(() {
          _searchResults = results;
          _hasSearched = true;
          _isSearching = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isSearching = false;
          _hasSearched = true;
        });
      }
    }
  }

  /// Analyze a product's safety
  String _analyzeProduct(Map<String, dynamic> productData) {
    final ingredientsText = _foodApiService.getIngredientsText(productData);

    if (_isProUser) {
      return _analysisService.analyzeAgainstMultipleProfiles(
        ingredientsText,
        _activeProfiles,
      );
    } else {
      return _analysisService.analyzeAgainstProfile(
        ingredientsText,
        _activeProfiles.first,
      );
    }
  }

  /// Get status color
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'safe':
        return Colors.green;
      case 'caution':
        return Colors.orange;
      case 'avoid':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  /// Get status icon
  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'safe':
        return Icons.check_circle;
      case 'caution':
        return Icons.warning;
      case 'avoid':
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }

  /// Navigate to detailed result screen
  void _viewProductDetails(Map<String, dynamic> productData) {
    final productName = _foodApiService.getProductName(productData) ?? 'Unknown Product';
    final brand = _foodApiService.getProductBrand(productData) ?? 'Unknown Brand';
    final ingredientsText = _foodApiService.getIngredientsText(productData);
    final barcode = productData['code'] as String? ?? '';

    final status = _isProUser
        ? _analysisService.analyzeAgainstMultipleProfiles(ingredientsText, _activeProfiles)
        : _analysisService.analyzeAgainstProfile(ingredientsText, _activeProfiles.first);

    // Get flagged ingredients
    List<String> flaggedIngredients = [];
    if (_isProUser) {
      final flaggedMap = _analysisService.getFlaggedIngredientsMultiProfile(
        ingredientsText,
        _activeProfiles,
      );
      // Flatten the map into a single list
      flaggedMap.forEach((profileName, ingredients) {
        flaggedIngredients.addAll(ingredients);
      });
      // Remove duplicates
      flaggedIngredients = flaggedIngredients.toSet().toList();
    } else {
      flaggedIngredients = _analysisService.getFlaggedIngredients(
        ingredientsText,
        _activeProfiles.first,
      );
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          barcode: barcode,
          productName: productName,
          brand: brand,
          ingredientsText: ingredientsText ?? 'No ingredients listed',
          status: status,
          flaggedIngredients: flaggedIngredients,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Foods'),
        elevation: 2,
      ),
      body: Column(
        children: [
          // Search bar with suggestions
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                // Search input field
                TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Search for food products...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchResults = [];
                                _hasSearched = false;
                                _error = null;
                                _showSuggestions = false;
                              });
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  onSubmitted: (value) {
                    _searchProducts(value);
                    _searchFocusNode.unfocus();
                  },
                  textInputAction: TextInputAction.search,
                  onChanged: (value) {
                    setState(() {}); // Update to show/hide clear button
                    _loadSuggestions(value);
                  },
                ),
                
                // Suggestions dropdown
                if (_showSuggestions && _searchSuggestions.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    constraints: const BoxConstraints(maxHeight: 250),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: _searchSuggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = _searchSuggestions[index];
                        return ListTile(
                          dense: true,
                          leading: Icon(
                            Icons.history,
                            color: Colors.grey[600],
                            size: 20,
                          ),
                          title: Text(
                            suggestion,
                            style: const TextStyle(fontSize: 14),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.grey[400],
                            ),
                            onPressed: () async {
                              await _searchHistoryService.removeSearch(suggestion);
                              _loadSuggestions(_searchController.text);
                            },
                          ),
                          onTap: () {
                            _searchController.text = suggestion;
                            _searchProducts(suggestion);
                            _searchFocusNode.unfocus();
                          },
                        );
                      },
                    ),
                  ),
                
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isSearching
                        ? null
                        : () {
                            _searchProducts(_searchController.text);
                            _searchFocusNode.unfocus();
                          },
                    icon: _isSearching
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Icon(Icons.search),
                    label: Text(_isSearching ? 'Searching...' : 'Search'),
                  ),
                ),
              ],
            ),
          ),

          // Active profile indicator
          if (_activeProfiles.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Row(
                children: [
                  Icon(
                    _isProUser ? Icons.check_circle : Icons.person,
                    size: 16,
                    color: _isProUser ? Colors.amber : Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _isProUser
                          ? 'Searching against ${_activeProfiles.length} profile(s): ${_activeProfiles.map((p) => p.name).join(', ')}'
                          : 'Searching against: ${_activeProfiles.first.name}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  if (!_isProUser)
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UpgradeScreen(),
                          ),
                        ).then((_) => _loadActiveProfiles());
                      },
                      child: const Text('Upgrade', style: TextStyle(fontSize: 12)),
                    ),
                ],
              ),
            ),

          // Results
          Expanded(
            child: _buildResultsBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsBody() {
    // Error state
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[300],
              ),
              const SizedBox(height: 16),
              Text(
                'Error',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    // Loading state
    if (_isSearching) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Searching products...'),
          ],
        ),
      );
    }

    // Empty state (no search yet)
    if (!_hasSearched) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: 80,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 16),
              Text(
                'Search for Food Products',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Enter a product name above to check if it\'s safe based on your dietary profile',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  _buildExampleChip('Organic Milk'),
                  _buildExampleChip('Peanut Butter'),
                  _buildExampleChip('Whole Wheat Bread'),
                  _buildExampleChip('Greek Yogurt'),
                  _buildExampleChip('Almond Milk'),
                ],
              ),
            ],
          ),
        ),
      );
    }

    // No results found
    if (_searchResults.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 16),
              Text(
                'No Results Found',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Try a different search term or check the spelling',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    // Results list
    return ListView.builder(
      itemCount: _searchResults.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final product = _searchResults[index];
        final productName = _foodApiService.getProductName(product) ?? 'Unknown Product';
        final brand = _foodApiService.getProductBrand(product);
        final imageUrl = _foodApiService.getImageUrl(product);
        final status = _analyzeProduct(product);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: imageUrl != null
                ? Image.network(
                    imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  )
                : Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey[200],
                    child: const Icon(Icons.fastfood),
                  ),
            title: Text(
              productName,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: brand != null
                ? Text(
                    brand,
                    style: TextStyle(color: Colors.grey[600]),
                  )
                : null,
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getStatusColor(status),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getStatusIcon(status),
                    color: _getStatusColor(status),
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      color: _getStatusColor(status),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => _viewProductDetails(product),
          ),
        );
      },
    );
  }

  Widget _buildExampleChip(String text) {
    return ActionChip(
      label: Text(text),
      onPressed: () {
        _searchController.text = text;
        _searchProducts(text);
      },
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
