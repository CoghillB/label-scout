import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'pro_status_service.dart';

/// Manager for App Open Ads that appear when the app is launched or resumed
class AppOpenAdManager {
  /// Toggle between test ads and production ads
  static const bool _useTestAds = true; // TODO: Set to false when AdMob account is approved
  
  /// Your AdMob App Open Ad Unit ID
  String get _adUnitId {
    if (_useTestAds) {
      // Use Google's test ad units during development
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/9257395921'; // Android test ad
      } else {
        return 'ca-app-pub-3940256099942544/5575463023'; // iOS test ad
      }
    } else {
      // Use your real ad units (after AdMob approval)
      if (Platform.isAndroid) {
        return 'ca-app-pub-6648737877378523/9996806950';
      } else {
        return 'ca-app-pub-6648737877378523/9996806950';
      }
    }
  }

  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  final ProStatusService _proStatusService = ProStatusService();

  /// Maximum duration before an ad is considered stale and should be reloaded
  final Duration maxCacheDuration = const Duration(hours: 4);

  /// Date and time when the ad was loaded
  DateTime? _appOpenAdLoadTime;

  /// Load a new app open ad
  Future<void> loadAd() async {
    // Check if user is Pro - don't load ads for Pro users
    final isPro = await _proStatusService.isProUser();
    if (isPro) {
      return;
    }

    await AppOpenAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          print('✅ App Open Ad loaded successfully!');
          _appOpenAdLoadTime = DateTime.now();
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          print('❌ App Open Ad failed to load:');
          print('   Code: ${error.code}');
          print('   Message: ${error.message}');
          if (error.code == 3) {
            print('   ℹ️  This usually means:');
            print('      - AdMob account not approved yet (normal for new accounts)');
            print('      - Use test ads during development');
            print('      - Check: https://support.google.com/admob/answer/9905175');
          }
          _appOpenAd = null;
        },
      ),
    );
  }

  /// Whether an ad is available to show
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  /// Whether the ad has expired and should be reloaded
  bool get isAdExpired {
    if (_appOpenAdLoadTime == null) return true;
    final now = DateTime.now();
    final difference = now.difference(_appOpenAdLoadTime!);
    return difference >= maxCacheDuration;
  }

  /// Show the app open ad if available
  Future<void> showAdIfAvailable() async {
    // Check if user is Pro - don't show ads for Pro users
    final isPro = await _proStatusService.isProUser();
    if (isPro) {
      return;
    }

    if (!isAdAvailable) {
      print('App Open Ad not available');
      await loadAd();
      return;
    }

    if (_isShowingAd) {
      print('App Open Ad already showing');
      return;
    }

    if (isAdExpired) {
      print('App Open Ad expired, loading new ad');
      _appOpenAd?.dispose();
      _appOpenAd = null;
      await loadAd();
      return;
    }

    // Set the fullScreenContentCallback
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        print('App Open Ad showed full screen content');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('App Open Ad failed to show: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
      onAdDismissedFullScreenContent: (ad) {
        print('App Open Ad dismissed');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );

    await _appOpenAd!.show();
  }

  /// Dispose of the ad when no longer needed
  void dispose() {
    _appOpenAd?.dispose();
    _appOpenAd = null;
  }
}
