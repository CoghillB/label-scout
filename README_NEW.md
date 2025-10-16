# 🏷️ Label Scout

A Flutter mobile application that helps users make informed dietary choices by scanning product barcodes and analyzing ingredients against their dietary profiles.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

---

## 📱 Features

### Core Features (Free)
- **📷 Barcode Scanner** - Scan product barcodes using your device camera
- **🔍 Ingredient Analysis** - Automatic ingredient analysis against dietary restrictions
- **👤 Single Active Profile** - Choose one dietary profile at a time
- **✅ Real-time Results** - Instant feedback on product safety (Safe/Caution/Avoid)
- **🌐 Product Database** - Powered by Open Food Facts API

### Pro Features ($9.99/month)
- **📝 My Lists** - Save unlimited items to Safe Foods and Avoid Lists with categories
- **📊 Scan History** - Track all your scans with detailed history and statistics
- **👥 Multiple Active Profiles** - Activate multiple dietary profiles simultaneously
- **🚫 Ad-Free Experience** - Clean interface without advertisements
- **💪 Most Restrictive Analysis** - Smart multi-profile analysis showing the most cautious result
- **💾 Persistent Storage** - All data saved locally with Hive database

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** `^3.9.2` or higher
- **Dart SDK** (included with Flutter)
- **Android Studio** or **VS Code** with Flutter extensions
- **iOS**: Xcode (for iOS development)
- **Android**: Android SDK 21+ (Android 5.0 Lollipop or higher)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/CoghillB/label-scout.git
   cd label-scout
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code** (Hive adapters)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Running on Specific Platforms

```bash
# Android
flutter run -d android

# iOS (requires macOS)
flutter run -d ios

# Chrome (web - limited camera support)
flutter run -d chrome
```

---

## 🎨 App Icon & Splash Screen Setup

### Generate App Icon

1. Place your 1024x1024px icon at: `assets/icon/app_icon.png`
2. Run the icon generator:
   ```bash
   flutter pub run flutter_launcher_icons
   ```

### Generate Splash Screen

1. Ensure your icon is at `assets/icon/app_icon.png`
2. Run the splash screen generator:
   ```bash
   flutter pub run flutter_native_splash:create
   ```

---

## 🏗️ Project Structure

```
lib/
├── main.dart                          # App entry point with navigation
├── data/
│   ├── food_categories.dart           # Predefined food categories
│   └── predefined_profiles.dart       # Built-in dietary profiles
├── models/
│   ├── diet_profile.dart              # Dietary profile data model
│   ├── saved_food_item.dart           # Saved item model (Hive)
│   ├── saved_food_item.g.dart         # Generated Hive adapter
│   ├── scan_history_item.dart         # Scan history model (Hive)
│   └── scan_history_item.g.dart       # Generated Hive adapter
├── screens/
│   ├── barcode_scanner_view.dart      # Camera barcode scanner
│   ├── history_screen.dart            # Scan history (Pro)
│   ├── my_lists_screen.dart           # Saved items lists (Pro)
│   ├── profiles_screen.dart           # Dietary profile selection
│   ├── result_screen.dart             # Scan result display
│   ├── scanner_screen.dart            # Scanner home screen
│   ├── settings_screen.dart           # App settings & Pro upgrade
│   └── upgrade_screen.dart            # Pro subscription details
├── services/
│   ├── food_api_service.dart          # Open Food Facts API integration
│   ├── haptic_service.dart            # Vibration feedback
│   ├── hive_service.dart              # Local database operations
│   ├── iap_service.dart               # Simulated in-app purchases
│   ├── ingredient_analysis_service.dart # Ingredient checking logic
│   ├── pro_status_service.dart        # Pro subscription management
│   └── profile_service.dart           # Profile persistence
├── utils/
│   └── (utility files)
└── widgets/
    ├── ad_placeholder.dart            # Ad widget (hidden for Pro)
    └── empty_state_widget.dart        # Reusable empty state UI
```

---

## 🔧 Technologies & Packages

### Core Dependencies
- **flutter** - UI framework
- **hive** `^2.2.3` - Local NoSQL database
- **hive_flutter** `^1.1.0` - Hive Flutter integration
- **mobile_scanner** `^5.0.0` - Barcode scanning
- **http** `^1.2.0` - API requests
- **shared_preferences** `^2.2.2` - Simple key-value storage
- **intl** `^0.19.0` - Date formatting
- **vibration** `^1.9.0` - Haptic feedback

### Dev Dependencies
- **build_runner** `^2.4.7` - Code generation
- **hive_generator** `^2.0.1` - Hive adapter generation
- **flutter_launcher_icons** `^0.13.1` - Icon generation
- **flutter_native_splash** `^2.4.0` - Splash screen generation
- **flutter_lints** `^5.0.0` - Linting rules

---

## 📊 Architecture

### State Management
- **StatefulWidget** - For local component state
- **Services Pattern** - Business logic separated into service classes
- **SharedPreferences** - For user settings persistence
- **Hive** - For structured data (saved items, scan history)

### Data Flow
1. **Scanner** → Captures barcode
2. **API Service** → Fetches product data from Open Food Facts
3. **Analysis Service** → Checks ingredients against active profile(s)
4. **Hive Service** → Saves scan history and saved items
5. **UI** → Displays results with color-coded status

### Pro Feature Gating
```dart
final isPro = await ProStatusService().isProUser();
if (isPro) {
  // Show Pro features
} else {
  // Show upgrade prompt
}
```

---

## 🎯 Key Features Implementation

### Multi-Profile Analysis (Pro)
When Pro users have multiple profiles active, the app uses **most restrictive logic**:
- If ANY profile says "AVOID" → Result = AVOID
- If ANY profile says "CAUTION" (and none say AVOID) → Result = CAUTION
- If ALL profiles say "SAFE" → Result = SAFE

### Scan History (Pro)
Every scan is automatically saved with:
- Product name and brand
- Scan timestamp
- Result status (SAFE/CAUTION/AVOID)
- Flagged ingredients list
- Filterable by status
- Swipe to delete

### My Lists (Pro)
Save items to two organized lists:
- **My Safe Foods** - Products you can eat
- **My Avoid List** - Products to stay away from
- Category-based filtering
- Search functionality

### Haptic Feedback
Contextual vibration patterns:
- ✅ **Success** - Double tap (SAFE scan)
- ⚠️ **Warning** - Triple tap (CAUTION scan)
- ❌ **Error** - Long buzz (AVOID scan)

---

## 🧪 Testing Features

### Pro Status Toggle
For development and testing, a toggle switch is available in Settings to instantly switch between Free and Pro modes without purchase.

**⚠️ Remove before production release!**

### Simulated IAP
The app includes a simulated In-App Purchase system:
- 90% success rate (to test failures)
- 2-second processing delay
- Realistic purchase dialog UI
- **Replace with real IAP before production**

---

## 🚢 Deployment Checklist

### Before Release

- [ ] Remove Pro status test toggle from Settings
- [ ] Replace simulated IAP with real platform IAP
  - [ ] Integrate `in_app_purchase` package
  - [ ] Set up Apple App Store Connect
  - [ ] Set up Google Play Console
  - [ ] Configure product IDs and pricing
- [ ] Replace ad placeholders with real ads
  - [ ] Integrate `google_mobile_ads`
  - [ ] Set up AdMob accounts
  - [ ] Configure ad unit IDs
- [ ] Add app icon (1024x1024px)
- [ ] Generate all icon sizes: `flutter pub run flutter_launcher_icons`
- [ ] Generate splash screen: `flutter pub run flutter_native_splash:create`
- [ ] Update version in `pubspec.yaml`
- [ ] Add privacy policy URL
- [ ] Create app store screenshots
- [ ] Write app store descriptions
- [ ] Test on multiple devices
- [ ] Run `flutter build appbundle` (Android)
- [ ] Run `flutter build ipa` (iOS)

### Android Specific
- [ ] Update `android/app/src/main/AndroidManifest.xml` ✅
- [ ] Set proper permissions ✅
- [ ] Configure signing keys
- [ ] Test on various Android versions (5.0+)

### iOS Specific
- [ ] Update `ios/Runner/Info.plist` ✅
- [ ] Add proper usage descriptions ✅
- [ ] Configure signing certificates
- [ ] Test on various iOS versions (11.0+)

---

## 🐛 Known Limitations

1. **MVP Status** - This is a Minimum Viable Product
2. **Simulated IAP** - Not connected to real payment systems
3. **Placeholder Ads** - Not showing real advertisements
4. **Limited Product Data** - Depends on Open Food Facts database coverage
5. **No Custom Profiles** - Only predefined dietary profiles available
6. **No Cloud Sync** - All data stored locally only
7. **English Only** - No internationalization support yet

---

## 🔮 Future Enhancements

- [ ] Custom profile creation
- [ ] Cloud sync across devices
- [ ] Profile sharing with family/friends
- [ ] Barcode history search
- [ ] Export data (CSV/PDF)
- [ ] Dark mode
- [ ] Multiple language support
- [ ] Nutrition facts display
- [ ] Alternative product suggestions
- [ ] Social features (share safe products)
- [ ] Widget support
- [ ] Apple Watch companion app

---

## 📄 License

This project is private and not currently licensed for public use.

---

## 👨‍💻 Developer

**CoghillB**
- GitHub: [@CoghillB](https://github.com/CoghillB)

---

## 🙏 Acknowledgments

- **Open Food Facts** - Product database API
- **Flutter Team** - Amazing cross-platform framework
- **Hive** - Fast local database solution
- **Mobile Scanner** - Barcode scanning package

---

## 📞 Support

For issues or questions:
1. Check the [Issues](https://github.com/CoghillB/label-scout/issues) page
2. Create a new issue with detailed description
3. Include device info and steps to reproduce

---

**Built with ❤️ using Flutter**
