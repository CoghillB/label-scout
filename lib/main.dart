import 'package:flutter/material.dart';

import 'screens/history_screen.dart';
import 'screens/profiles_screen.dart';
import 'screens/scanner_screen.dart';
import 'screens/search_screen.dart';
import 'screens/settings_screen.dart';
import 'services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const LabelScoutApp());
}

class LabelScoutApp extends StatefulWidget {
  const LabelScoutApp({super.key});

  @override
  State<LabelScoutApp> createState() => _LabelScoutAppState();
}

class _LabelScoutAppState extends State<LabelScoutApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Label Scout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Enhanced color palette with green and brown harmony: A5B68D, 6B8E4E, B17F59, C1CFA1, EDE8DC
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFA5B68D), // Muted Green
          primary: const Color(
            0xFF6B8E4E,
          ), // Rich Forest Green (primary accent)
          secondary: const Color(0xFF8B5E3C), // Warm Brown (secondary accent)
          tertiary: const Color(0xFF9CB87C), // Light Sage Green
          surface: const Color(
            0xFFFAF8F3,
          ), // Brighter Off-White (enhanced from EDE8DC)
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: const Color(
            0xFF2C2C2C,
          ), // Dark gray for better text contrast
          outline: const Color(0xFFA5B68D), // Muted green for borders
        ),
        scaffoldBackgroundColor: const Color(
          0xFFF5F7F0,
        ), // Subtle green-tinted off-white
        cardColor: Colors.white,
        // Enhanced AppBar with rich green
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6B8E4E), // Rich Forest Green
          foregroundColor: Colors.white,
          elevation: 2, // Subtle shadow for depth
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        // Enhanced buttons with green primary
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6B8E4E), // Rich Forest Green
            foregroundColor: Colors.white,
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        // Enhanced outlined buttons with green
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF6B8E4E),
            side: const BorderSide(color: Color(0xFF6B8E4E), width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        // Enhanced text buttons with green
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF6B8E4E),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
        // Enhanced floating action button with green
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF6B8E4E),
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        // Enhanced card theme
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
          ),
          color: Colors.white,
        ),
        // Enhanced input decoration with green accents
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF5F7F0), // Light green tint
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFA5B68D)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFD0D5CC),
            ), // Green-gray
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF6B8E4E), width: 2),
          ),
          labelStyle: const TextStyle(color: Color(0xFF6B6B6B)),
          hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
        ),
        // Enhanced chip theme with greens
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFF9CB87C), // Light Sage Green
          selectedColor: const Color(0xFF6B8E4E), // Rich Forest Green
          labelStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        // Enhanced bottom navigation bar with green
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF6B8E4E), // Rich Forest Green
          unselectedItemColor: Color(0xFF9E9E9E), // Medium gray
          backgroundColor: Colors.white,
          elevation: 8,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        ),
        // Enhanced text theme
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C2C2C),
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C2C2C),
          ),
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C2C2C),
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C2C2C),
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C2C2C),
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2C2C2C),
          ),
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF3C3C3C)),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF3C3C3C)),
          bodySmall: TextStyle(fontSize: 12, color: Color(0xFF6B6B6B)),
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
        backgroundColor: const Color(0xFFF5F7F0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.qr_code_scanner,
                size: 80,
                color: const Color(0xFF6B8E4E).withValues(alpha: 0.6),
              ),
              const SizedBox(height: 24),
              const Text(
                'Label Scout',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B8E4E),
                ),
              ),
              const SizedBox(height: 32),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6B8E4E)),
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

  // The five main screens for the bottom navigation
  final List<Widget> _screens = const [
    ScannerScreen(),
    SearchScreen(),
    ProfilesScreen(),
    HistoryScreen(),
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
        type: BottomNavigationBarType.fixed, // Needed for 4+ items
        selectedItemColor: const Color(0xFF6B8E4E), // Rich Forest Green
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profiles'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
