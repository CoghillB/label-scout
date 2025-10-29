# 🏷️ Label Scout

**Your Personal Ingredient Analysis & Shopping Memory Tool**

Label Scout is a Flutter mobile application that helps users make informed food choices by scanning product barcodes and analyzing ingredients against their dietary preferences and restrictions.

[![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart)](https://dart.dev)
[![Version](https://img.shields.io/badge/Version-1.0.8-green)](https://github.com/CoghillB/label-scout)

---

## 📢 Latest Release - v1.0.8 (October 29, 2025)

### 🌍 Language Localization Enhancement

**What's Fixed:**
- **English-First API Requests** - Product data now consistently returns in English language
- **Language Priority Headers** - Added `Accept-Language` and `lc=en` parameters to all API calls
- **Improved Product Names** - Product names now prioritize English versions (`product_name_en`)
- **Better Ingredient Display** - Ingredients text always shows English version when available
- **Fallback Handling** - Gracefully handles products without English translations

**Why This Matters:**
Previously, users might see product information in French, Spanish, or other languages depending on the product's origin in the Open Food Facts database. This update ensures a consistent English-language experience for all users.

**Technical Changes:**
- Updated `food_api_service.dart` with language-specific API parameters
- Enhanced `getProductName()` to prioritize English product names
- Enhanced `getIngredientsText()` to return only English ingredient lists
- Added proper Accept-Language headers to all HTTP requests

---

## ✨ Features

### 🔍 Core Scanning Features
- **Barcode Scanning** - Scan product barcodes using your device camera
- **Real-time Analysis** - Instant ingredient analysis against your dietary profiles
- **Product Database** - Powered by Open Food Facts API with millions of products
- **Multi-Profile Support** - Analyze against multiple dietary restrictions simultaneously (Pro)

### 👤 Dietary Profiles
Create and manage custom dietary profiles including:
- 🥜 **Nut Allergy** - Tree nuts, peanuts, and derivatives
- 🥛 **Dairy-Free** - Milk, cheese, butter, whey, casein
- 🌾 **Gluten-Free** - Wheat, barley, rye, malt
- 🦐 **Shellfish Allergy** - Shrimp, crab, lobster, mollusks
- 🐟 **Fish Allergy** - All fish and fish products
- 🥚 **Egg-Free** - Eggs and egg derivatives
- 🌱 **Vegan** - All animal products and derivatives
- 🌿 **Vegetarian** - Meat and fish products
- 🍯 **Bee-Free** - Honey and bee products
- 🤰 **Pregnancy-Safe** - Unsafe ingredients for pregnancy

### 🎯 Smart Analysis System
- **Three-Level Rating System**:
  - ✅ **SAFE** - No problematic ingredients detected
  - ⚠️ **CAUTION** - Contains ingredients to be cautious about
  - ❌ **AVOID** - Contains ingredients you should avoid
- **Detailed Ingredient Breakdown** - See exactly which ingredients were flagged
- **Haptic Feedback** - Contextual vibration patterns for scan results

### 💾 Personal Lists (Pro Feature)
- **Save Products** - Build your personal shopping memory
- **Category Organization** - Organize by Pantry, Snacks, Produce, Dairy, and more
- **Quick Access** - Easily find saved safe and avoid items
- **Search & Filter** - Find products quickly in your lists

### 📊 History Tracking (Pro Feature)
- **Scan History** - View all your previous scans
- **Filter by Status** - See all safe, caution, or avoid scans
- **Date Tracking** - Know when you scanned each product
- **Detailed Records** - Product name, brand, barcode, and flagged ingredients

### 🔎 Product Search
- **Search by Name** - Find products without scanning
- **Browse Results** - View product details and ingredient analysis
- **Save from Search** - Add searched products to your lists (Pro)

### ❓ Product Not Found Workflow
- **Smart Error Handling** - Helpful screen when products aren't in database
- **Manual Entry** - Add products manually to your lists (Pro)
- **Shopping Memory** - Track products even if they're not in the database
- **Barcode Preservation** - Copy and save barcodes for future reference

### ⚙️ Settings & Customization
- **Profile Management** - Create, edit, and delete dietary profiles
- **Pro Status** - Unlock premium features
- **Clean Interface** - Intuitive navigation and modern design

---

## 🔄 Recent Updates

### Version 1.0.8 (October 29, 2025)
- 🌍 **Language Localization** - English-first API requests for consistent language display

### Version 1.0.7 (October 25, 2025)
- 📦 **Product Not Found Workflow** - Helpful screen when products aren't in database
- ✍️ **Manual Product Entry** - Pro users can add products manually to lists
- 💾 **Shopping Memory** - Track any product, even if not in database

### Version 1.0.6 & Earlier
- ⚠️ **Caution Status Fix** - Natural flavors now correctly show caution instead of avoid
- 🔍 **Search Feature Fix** - Product search now returns relevant results
- 👤 **Profile Selection UX** - Improved profile checking and user guidance
- 📱 **Crash Fixes** - Fixed Google Mobile Ads initialization crash

---

## 🎨 Screenshots

```
🏠 Home Scanner  |  👤 Profiles  |  📋 Results  |  💾 My Lists  |  📊 History
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.9.2 or higher
- Dart SDK 3.9.2 or higher
- Android Studio / Xcode for mobile development
- An Android or iOS device/emulator

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

3. **Generate Hive adapters**
   ```bash
   flutter pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Build for Release

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

---

## 🏗️ Architecture

### Project Structure
```
lib/
├── main.dart                 # App entry point
├── data/
│   └── food_categories.dart  # Category definitions
├── models/
│   ├── diet_profile.dart     # Dietary profile model
│   ├── saved_food_item.dart  # Saved item model
│   └── scan_history_item.dart# Scan history model
├── screens/
│   ├── scanner_screen.dart           # Main scanner screen
│   ├── barcode_scanner_view.dart     # Camera scanner view
│   ├── result_screen.dart            # Scan result display
│   ├── product_not_found_screen.dart # Product not found handler
│   ├── manual_add_screen.dart        # Manual product entry
│   ├── profiles_screen.dart          # Profile management
│   ├── search_screen.dart            # Product search
│   ├── history_screen.dart           # Scan history
│   ├── my_lists_screen.dart          # Saved products
│   ├── settings_screen.dart          # App settings
│   └── upgrade_screen.dart           # Pro upgrade info
├── services/
│   ├── food_api_service.dart         # Open Food Facts API
│   ├── hive_service.dart             # Local database
│   ├── profile_service.dart          # Profile management
│   ├── ingredient_analysis_service.dart # Ingredient analyzer
│   ├── pro_status_service.dart       # Pro feature management
│   └── haptic_service.dart           # Haptic feedback
└── widgets/
    └── empty_state_widget.dart       # Reusable empty state
```

### Key Technologies

**Core Framework:**
- Flutter 3.9.2 - Cross-platform UI framework
- Dart 3.9.2 - Programming language

**State Management:**
- StatefulWidget - Built-in Flutter state management

**Local Storage:**
- Hive 2.2.3 - Fast, lightweight NoSQL database
- SharedPreferences 2.2.2 - Simple key-value storage

**API Integration:**
- HTTP 1.2.0 - REST API calls
- Open Food Facts API - Product database

**Device Features:**
- mobile_scanner 7.1.2 - Barcode scanning with camera
- Haptic feedback - Native device vibration

**UI/UX:**
- Material Design 3 - Modern UI components
- Custom color scheme - Green/brown nature theme

---

## 🎯 Key Features Implementation

### Barcode Scanning Flow
```
User taps "Scan Barcode" 
    ↓
Check active profiles
    ↓
Open camera scanner
    ↓
Detect barcode
    ↓
Fetch from Open Food Facts API
    ↓
Analyze ingredients
    ↓
Show results with rating
    ↓
Save to history (Pro)
```

### Product Not Found Flow
```
Scan fails (product not in database)
    ↓
Product Not Found Screen
    ↓
    ├─→ Scan Again (retry)
    └─→ Add Manually (Pro users)
            ↓
        Manual Entry Form
            ↓
        Save to My Lists
```

### Ingredient Analysis
The app uses a sophisticated multi-profile analysis system:
1. Extract ingredients text from product data
2. Convert to lowercase for matching
3. Check against "avoid" ingredients (exact matches)
4. Check against "caution" ingredients (partial matches)
5. Return aggregated status across all active profiles

### Haptic Feedback
Contextual vibration patterns enhance UX:
- ✅ **SAFE** - Double tap (success pattern)
- ⚠️ **CAUTION** - Triple tap (warning pattern)
- ❌ **AVOID** - Long buzz (error pattern)

---

## 📦 Dependencies

### Production Dependencies
| Package | Version | Purpose |
|---------|---------|---------|
| flutter | SDK | Core framework |
| cupertino_icons | ^1.0.8 | iOS-style icons |
| http | ^1.2.0 | API requests |
| shared_preferences | ^2.2.2 | Simple storage |
| mobile_scanner | ^7.1.2 | Barcode scanning |
| hive | ^2.2.3 | Local database |
| hive_flutter | ^1.1.0 | Hive Flutter integration |
| path_provider | ^2.1.1 | File system paths |
| intl | ^0.20.2 | Date formatting |

### Development Dependencies
| Package | Version | Purpose |
|---------|---------|---------|
| hive_generator | ^2.0.1 | Generate Hive adapters |
| build_runner | ^2.4.7 | Code generation |
| flutter_test | SDK | Testing framework |
| flutter_lints | ^6.0.0 | Linting rules |
| flutter_launcher_icons | ^0.14.4 | App icon generation |
| flutter_native_splash | ^2.4.0 | Splash screen |

---

## 🎨 Design System

### Color Palette
- **Primary Green**: `#6B8E4E` - Rich forest green (buttons, headers)
- **Secondary Brown**: `#8B5E3C` - Warm brown accent
- **Muted Green**: `#A5B68D` - Soft green backgrounds
- **Light Sage**: `#9CB87C` - Tertiary accent
- **Cream**: `#F5F7F0` - Background color
- **White**: `#FFFFFF` - Card backgrounds

### Theme Philosophy
Nature-inspired, trustworthy color scheme that reflects health and natural food choices.

### Typography
- **Display**: Bold headings for impact
- **Body**: Clear, readable text
- **Monospace**: Barcodes and technical data

---

## 🔐 Privacy & Data

### Local Storage Only
- All user data stored locally on device
- No user accounts or cloud storage
- No personal information collected
- No tracking or analytics

### Data Stored
- Dietary profiles (locally)
- Saved products (locally, Pro feature)
- Scan history (locally, Pro feature)
- Pro status preference (locally)

### External API
- Uses Open Food Facts API for product data
- Read-only access to public product database
- No user data sent to external services

---

## 🎁 Free vs Pro Features

### Free Features
✅ Barcode scanning  
✅ One active dietary profile  
✅ Real-time ingredient analysis  
✅ Product search  
✅ Create unlimited profiles  

### Pro Features
⭐ Multiple active profiles (analyze against several at once)  
⭐ Save products to personal lists  
⭐ Category organization  
⭐ Scan history tracking  
⭐ Manual product entry  
⭐ Filter and search saved items  

---

## 🛠️ Development

### Code Generation
When models change, regenerate Hive adapters:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Running Tests
```bash
flutter test
```

### Code Quality
```bash
flutter analyze
```

### Format Code
```bash
flutter format lib/
```

---

## 🐛 Known Issues & Limitations

- Product data quality depends on Open Food Facts community
- Some products may not be in the database
- Ingredient analysis is text-based (may miss some variations)
- Camera permissions required for scanning
- Internet connection required for product lookup

---

## 🚧 Future Enhancements

### Planned Features
- [ ] Photo upload for manually added products
- [ ] OCR for scanning ingredient labels directly
- [ ] Community product database
- [ ] Share products with other users
- [ ] Export/import profiles
- [ ] Barcode generation for custom products
- [ ] Shopping list integration
- [ ] Nutritional information display
- [ ] Product recommendations
- [ ] Dark mode support

---

## 📄 License

This project is private and not currently licensed for public use.

---

## 👨‍💻 Author

**CoghillB**  
GitHub: [@CoghillB](https://github.com/CoghillB)

---

## 🙏 Acknowledgments

- **Open Food Facts** - Product database API
- **Flutter Team** - Amazing framework
- **Community Contributors** - Inspiration and feedback

---

## 📞 Support

For issues, questions, or feature requests, please open an issue on GitHub.

---

**Built with ❤️ using Flutter**
