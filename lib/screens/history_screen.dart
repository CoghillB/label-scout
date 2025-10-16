import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/scan_history_item.dart';
import '../services/hive_service.dart';
import '../services/pro_status_service.dart';
import 'upgrade_screen.dart';

/// Screen displaying scan history - Pro feature
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final HiveService _hiveService = HiveService();
  final ProStatusService _proStatusService = ProStatusService();
  
  bool _isProUser = false;
  bool _isLoading = true;
  List<ScanHistoryItem> _historyItems = [];
  String _filterStatus = 'All'; // 'All', 'SAFE', 'CAUTION', 'AVOID'

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    _isProUser = await _proStatusService.isProUser();
    
    if (_isProUser) {
      _historyItems = _hiveService.getAllScanHistory();
    }

    setState(() {
      _isLoading = false;
    });
  }

  List<ScanHistoryItem> get _filteredItems {
    if (_filterStatus == 'All') {
      return _historyItems;
    }
    return _historyItems
        .where((item) => item.resultStatus.toUpperCase() == _filterStatus)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Show upgrade screen if not Pro user
    if (!_isProUser) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Scan History',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.history,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Scan History',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Track all your scans and review past results',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.amber),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 8),
                      Text(
                        'Pro Feature',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpgradeScreen(),
                      ),
                    ).then((_) => _loadData());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: const Text(
                    'Upgrade to Pro',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Pro user - show history
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (_historyItems.isNotEmpty)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'clear') {
                  _showClearConfirmation();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'clear',
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Clear History'),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      body: Column(
        children: [
          // Stats bar
          if (_historyItems.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    'Total Scans',
                    _hiveService.getTotalScans().toString(),
                    Icons.qr_code_scanner,
                  ),
                  _buildStatItem(
                    'Today',
                    _hiveService.getScansToday().toString(),
                    Icons.today,
                  ),
                  _buildStatItem(
                    'Safe Items',
                    _historyItems
                        .where((i) => i.resultStatus == 'SAFE')
                        .length
                        .toString(),
                    Icons.check_circle,
                  ),
                ],
              ),
            ),
          
          // Filter chips
          if (_historyItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All'),
                    const SizedBox(width: 8),
                    _buildFilterChip('SAFE'),
                    const SizedBox(width: 8),
                    _buildFilterChip('CAUTION'),
                    const SizedBox(width: 8),
                    _buildFilterChip('AVOID'),
                  ],
                ),
              ),
            ),
          
          // History list
          Expanded(
            child: _filteredItems.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      return _buildHistoryItem(_filteredItems[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String status) {
    final isSelected = _filterStatus == status;
    return FilterChip(
      label: Text(status),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _filterStatus = status;
        });
      },
      selectedColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
    );
  }

  Widget _buildHistoryItem(ScanHistoryItem item) {
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');
    final statusColor = _getStatusColor(item.resultStatus);

    return Dismissible(
      key: Key(item.scanDate.toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _deleteHistoryItem(item);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: ListTile(
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                item.statusIcon,
                style: TextStyle(
                  fontSize: 24,
                  color: statusColor,
                ),
              ),
            ),
          ),
          title: Text(
            item.productName,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                dateFormat.format(item.scanDate),
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              if (item.flaggedIngredients.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  'Flagged: ${item.flaggedIngredients.join(", ")}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange[700],
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
          trailing: Chip(
            label: Text(
              item.resultStatus,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: statusColor,
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'No Scan History Yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _filterStatus == 'All'
                  ? 'Start scanning products to see your history here'
                  : 'No scans with status "$_filterStatus" found',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'SAFE':
        return Colors.green;
      case 'CAUTION':
        return Colors.orange;
      case 'AVOID':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<void> _deleteHistoryItem(ScanHistoryItem item) async {
    await _hiveService.deleteScanHistoryItem(item);
    setState(() {
      _historyItems.remove(item);
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Deleted ${item.productName}'),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              // Note: Undo would require caching the item before deletion
              _loadData();
            },
          ),
        ),
      );
    }
  }

  Future<void> _showClearConfirmation() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All History?'),
        content: const Text(
          'This will permanently delete all scan history. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _hiveService.clearScanHistory();
      setState(() {
        _historyItems.clear();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('History cleared'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }
}
