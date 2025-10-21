import 'dart:async';

import 'package:flutter/widgets.dart';

import 'app_open_ad_manager.dart';

/// Listens to app lifecycle changes and shows app open ads
class AppLifecycleReactor {
  final AppOpenAdManager appOpenAdManager;

  AppLifecycleReactor({required this.appOpenAdManager});

  /// Handle app lifecycle state changes
  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream.forEach((state) {
      _onAppStateChanged(state);
    });
  }

  /// Called when app state changes
  void _onAppStateChanged(AppState appState) {
    print('App state changed to: $appState');
    
    // Show ad when app comes to foreground
    if (appState == AppState.foreground) {
      appOpenAdManager.showAdIfAvailable();
    }
  }
}

/// Notifies when app state changes
class AppStateEventNotifier {
  static Stream<AppState> get appStateStream => _appStateSubject.stream;
  static final _appStateSubject = StreamController<AppState>.broadcast();

  static AppState? _currentState;

  static void startListening() {
    if (_currentState != null) {
      return; // Already listening
    }

    final binding = WidgetsBinding.instance;
    binding.addObserver(_AppLifecycleObserver(_appStateSubject));
    _currentState = AppState.foreground;
  }

  static void stopListening() {
    final binding = WidgetsBinding.instance;
    binding.removeObserver(_AppLifecycleObserver(_appStateSubject));
    _currentState = null;
  }
}

/// Observer for app lifecycle events
class _AppLifecycleObserver extends WidgetsBindingObserver {
  final StreamController<AppState> _appStateSubject;

  _AppLifecycleObserver(this._appStateSubject);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _appStateSubject.add(AppState.foreground);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        _appStateSubject.add(AppState.background);
        break;
    }
  }
}

/// App state enum
enum AppState {
  foreground,
  background,
}
