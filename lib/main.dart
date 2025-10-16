import 'package:flutter/material.dart';

import 'screens/profiles_screen.dart';
import 'screens/scanner_screen.dart';
import 'screens/settings_screen.dart';
import 'services/hive_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LabelScoutApp());
}

class LabelScoutApp extends StatelessWidget {
  const LabelScoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Label Scout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Color palette: B17F59, A5B68D, C1CFA1, EDE8DC
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFA5B68D), // Muted Green
          primary: const Color(0xFFB17F59), // Warm Brown/Tan
          secondary: const Color(0xFFA5B68D), // Muted Green
          surface: const Color(0xFFEDE8DC), // Off-White/Cream
        ),
        scaffoldBackgroundColor: const Color(0xFFEDE8DC), // Off-White/Cream
        cardColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFB17F59), // Warm Brown/Tan
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB17F59), // Warm Brown/Tan
            foregroundColor: Colors.white,
          ),
        ),
        useMaterial3: true,
      ),
      home: const AppInitializer(),
    );
  }
}

/// Initializes app services before showing main navigation
class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _initialized = false;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      // Initialize Hive database
      await HiveService.initialize();
      
      if (mounted) {
        setState(() {
          _initialized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'Initialization Error',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(_error, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _error = '';
                      _initialized = false;
                    });
                    _initialize();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (!_initialized) {
      return Scaffold(
        backgroundColor: const Color(0xFFEDE8DC),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.qr_code_scanner,
                size: 80,
                color: const Color(0xFFB17F59).withValues(alpha: 0.6),
              ),
              const SizedBox(height: 24),
              const Text(
                'Label Scout',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB17F59),
                ),
              ),
              const SizedBox(height: 32),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB17F59)),
              ),
              const SizedBox(height: 16),
              const Text(
                'Initializing...',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return const MainNavigationScreen();
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // The three main screens for the bottom navigation
  final List<Widget> _screens = const [
    ScannerScreen(),
    ProfilesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: const Color(0xFFB17F59), // Warm Brown/Tan
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profiles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
