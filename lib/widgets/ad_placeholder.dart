import 'package:flutter/material.dart';

import '../services/pro_status_service.dart';

/// Placeholder widget for ads that displays only for free users
/// In a production app, this would be replaced with actual ad widgets
/// from google_mobile_ads or similar packages
class AdPlaceholder extends StatefulWidget {
  final AdSize size;
  final EdgeInsetsGeometry? margin;

  const AdPlaceholder({
    super.key,
    this.size = AdSize.banner,
    this.margin,
  });

  @override
  State<AdPlaceholder> createState() => _AdPlaceholderState();
}

class _AdPlaceholderState extends State<AdPlaceholder> {
  final ProStatusService _proStatusService = ProStatusService();
  bool _isProUser = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkProStatus();
  }

  Future<void> _checkProStatus() async {
    final isPro = await _proStatusService.isProUser();
    if (mounted) {
      setState(() {
        _isProUser = isPro;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Don't show anything while loading or if user is Pro
    if (_isLoading || _isProUser) {
      return const SizedBox.shrink();
    }

    final dimensions = widget.size.dimensions;
    
    return Container(
      margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 8),
      width: dimensions.width,
      height: dimensions.height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.ads_click,
            size: 32,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 8),
          Text(
            'Advertisement',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '(Placeholder - removed with Pro)',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[500],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

/// Predefined ad sizes
class AdSize {
  final double width;
  final double height;

  const AdSize({required this.width, required this.height});

  AdDimensions get dimensions => AdDimensions(width: width, height: height);

  /// Standard banner ad (320x50)
  static const AdSize banner = AdSize(width: 320, height: 50);

  /// Large banner ad (320x100)
  static const AdSize largeBanner = AdSize(width: 320, height: 100);

  /// Medium rectangle ad (300x250)
  static const AdSize mediumRectangle = AdSize(width: 300, height: 250);

  /// Full width banner (matches screen width, 50 height)
  static const AdSize fullBanner = AdSize(width: double.infinity, height: 50);
}

class AdDimensions {
  final double width;
  final double height;

  AdDimensions({required this.width, required this.height});
}
