import 'package:flutter/material.dart';

import 'screens/profiles_screen.dart';
import 'screens/scanner_screen.dart';
import 'screens/settings_screen.dart';
import 'services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive database
  await HiveService.initialize();
  
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
      home: const MainNavigationScreen(),
    );
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
