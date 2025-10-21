# 🚀 Label Scout - Deployment Preparation Guide

This guide walks through the final steps needed to prepare Label Scout for production deployment to the App Store and Google Play.

---

## ✅ Completed Items

### Core Implementation
- [x] Scan History feature (Pro)
- [x] Hive database with ScanHistoryItem model
- [x] History screen with filters and statistics
- [x] Haptic feedback on scans
- [x] Empty state widgets
- [x] Splash screen configuration
- [x] Android & iOS permissions configured
- [x] App name set in manifests

---

## 📋 Pre-Deployment Checklist

### 1. Generate Required Files

```bash
# Install all dependencies
flutter pub get

# Generate Hive adapters
flutter pub run build_runner build --delete-conflicting-outputs

# Generate app icons (after adding your icon to assets/icon/app_icon.png)
flutter pub run flutter_launcher_icons

# Generate splash screen
flutter pub run flutter_native_splash:create
```

### 2. Remove Testing Features

**File: `lib/screens/settings_screen.dart`**

Remove the Pro status test toggle section (lines containing "Test Toggle Pro Status"):

```dart
// DELETE THIS SECTION BEFORE RELEASE:
ListTile(
  title: const Text('Test Toggle Pro Status'),
  subtitle: const Text('Development only - remove before release'),
  trailing: Switch(
    value: _isProUser,
    onChanged: (value) async {
      await _proStatusService.setProStatus(value);
      _loadProStatus();
    },
  ),
),
```

### 3. Replace Simulated IAP with Real IAP

#### Add Real IAP Package

**File: `pubspec.yaml`**
```yaml
dependencies:
  in_app_purchase: ^3.1.13
```

#### Update IAPService

**File: `lib/services/iap_service.dart`**

Replace the entire file with real IAP implementation:

```dart
import 'package:in_app_purchase/in_app_purchase.dart';
import 'pro_status_service.dart';

class IAPService {
  final ProStatusService _proStatusService = ProStatusService();
  final InAppPurchase _iap = InAppPurchase.instance;
  
  static const String proSubscriptionId = 'label_scout_pro_monthly'; // Configure in stores
  
  Future<bool> purchaseProVersion() async {
    // Implement real IAP flow
    // See: https://pub.dev/packages/in_app_purchase
  }
  
  Future<bool> restorePurchases() async {
    // Implement restore logic
  }
  
  String getProPrice() {
    // Fetch actual price from store
    return '\$9.99/month';
  }
}
```

#### Configure Store Products

**Apple App Store Connect:**
1. Create subscription product: `label_scout_pro_monthly`
2. Set price: $9.99/month
3. Add localized descriptions

**Google Play Console:**
1. Create subscription product: `label_scout_pro_monthly`
2. Set price: $9.99/month
3. Add base plan and offers

### 4. Replace Ad Placeholders with Real Ads

#### Add Google Mobile Ads

**File: `pubspec.yaml`**
```yaml
dependencies:
  google_mobile_ads: ^5.0.0
```

#### Update AdPlaceholder Widget

**File: `lib/widgets/ad_placeholder.dart`**

Replace with real ad implementation:

```dart
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdPlaceholder extends StatefulWidget {
  // Implement real banner ads
  // Ad Unit IDs from AdMob console
}
```

#### Initialize Ads

**File: `lib/main.dart`**
```dart
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(const LabelScoutApp());
}
```

#### Configure Ad Unit IDs

**Android: `android/app/src/main/AndroidManifest.xml`**
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX"/>
```

**iOS: `ios/Runner/Info.plist`**
```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX</string>
```

### 5. App Icon Setup

1. **Create app icon** (1024x1024px PNG)
   - Use your brand colors: #B17F59, #A5B68D
   - Design ideas: Barcode + magnifying glass, food label icon
   - Tools: Figma, Canva, Adobe Express

2. **Place icon:**
   ```
   assets/icon/app_icon.png
   ```

3. **Generate icons:**
   ```bash
   flutter pub run flutter_launcher_icons
   ```

### 6. Version & Build Numbers

**File: `pubspec.yaml`**
```yaml
version: 1.0.0+1  # Update before each release
# Format: MAJOR.MINOR.PATCH+BUILD_NUMBER
```

**Versioning Strategy:**
- `1.0.0+1` - Initial release
- `1.0.1+2` - Bug fix update
- `1.1.0+3` - Minor feature update
- `2.0.0+4` - Major version update

### 7. App Signing

#### Android Signing

1. **Create keystore:**
   ```bash
   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

2. **Create `android/key.properties`:**
   ```properties
   storePassword=<password>
   keyPassword=<password>
   keyAlias=upload
   storeFile=<path-to-keystore>
   ```

3. **Update `android/app/build.gradle`:**
   ```gradle
   def keystoreProperties = new Properties()
   def keystorePropertiesFile = rootProject.file('key.properties')
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
   }
   
   android {
       signingConfigs {
           release {
               keyAlias keystoreProperties['keyAlias']
               keyPassword keystoreProperties['keyPassword']
               storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
               storePassword keystoreProperties['storePassword']
           }
       }
       buildTypes {
           release {
               signingConfig signingConfigs.release
           }
       }
   }
   ```

#### iOS Signing

1. **Enroll in Apple Developer Program** ($99/year)
2. **Create App ID** in App Store Connect
3. **Create provisioning profiles** (Development, Distribution)
4. **Configure signing** in Xcode:
   - Open `ios/Runner.xcworkspace`
   - Select Runner target
   - Set Team and Bundle Identifier

### 8. App Store Assets

#### Screenshots Needed

**iOS:**
- 6.7" Display (iPhone 15 Pro Max) - 1290 x 2796 px
- 6.5" Display (iPhone 11 Pro Max) - 1242 x 2688 px
- 5.5" Display (iPhone 8 Plus) - 1242 x 2208 px
- 12.9" iPad Pro - 2048 x 2732 px

**Android:**
- Phone - 1080 x 1920 px minimum
- 7" Tablet - 1024 x 600 px minimum
- 10" Tablet - 1280 x 800 px minimum

**Minimum Required:** 2 screenshots, **Recommended:** 4-8

#### App Description

**Short Description (80 characters):**
```
Scan barcodes, analyze ingredients for dietary restrictions
```

**Full Description:**

```
🏷️ Label Scout - Your Personal Ingredient Analyzer

Make informed dietary choices with Label Scout! Simply scan any product barcode to instantly analyze ingredients against your dietary profiles.

✨ KEY FEATURES:
• Quick barcode scanning with your camera
• Instant ingredient analysis
• Multiple dietary profile support
• Color-coded safety results (Safe/Caution/Avoid)
• Powered by Open Food Facts database

🌟 PRO FEATURES ($9.99/month):
• Save unlimited items to custom lists
• Complete scan history tracking
• Multiple active profiles simultaneously
• Ad-free experience
• Smart multi-profile analysis

Perfect for anyone with:
• Food allergies
• Dietary restrictions  
• Gluten-free lifestyles
• Vegan/vegetarian diets
• Religious dietary laws (Kosher, Halal)

Download Label Scout today and take control of your dietary health!
```

#### Keywords

**iOS App Store (100 characters max):**
```
barcode,scanner,ingredients,diet,allergy,gluten,vegan,kosher,halal,food
```

**Google Play (50 characters per keyword):**
- barcode scanner
- ingredient analyzer
- dietary restrictions
- food allergy app
- gluten free scanner

### 9. Privacy Policy & Terms

**Required for both stores!**

Create pages including:
- What data is collected (minimal - local storage only)
- How data is used
- Data retention policy
- User rights
- Contact information

**Host at:**
- Your website
- GitHub Pages
- Privacy policy generator service

**Add URL to:**
- App Store Connect → App Information
- Google Play Console → Store Listing

### 10. Build for Release

#### Android (APK/App Bundle)

```bash
# Build App Bundle (recommended for Play Store)
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab

# Or build APK
flutter build apk --release --split-per-abi

# Output: build/app/outputs/flutter-apk/
```

#### iOS (IPA)

```bash
# Build iOS app
flutter build ios --release

# Then in Xcode:
# 1. Open ios/Runner.xcworkspace
# 2. Product → Archive
# 3. Distribute App → App Store Connect
```

### 11. Test Before Submission

#### Functional Testing
- [ ] Test all Pro features with real IAP
- [ ] Test ads appear for free users
- [ ] Test camera permissions
- [ ] Test barcode scanning accuracy
- [ ] Test on multiple devices
- [ ] Test offline functionality
- [ ] Test app resume/background behavior

#### Platform Testing
- [ ] Android 5.0 (API 21) - minimum
- [ ] Android 14 (API 34) - latest
- [ ] iOS 11.0 - minimum
- [ ] iOS 17 - latest
- [ ] Various screen sizes

#### Edge Cases
- [ ] Poor internet connection
- [ ] No internet connection
- [ ] Camera unavailable
- [ ] Product not in database
- [ ] Invalid barcode
- [ ] No active profile selected

### 12. Submit to Stores

#### Google Play Console

1. **Create app** in Play Console
2. **Upload app bundle** (AAB file)
3. **Complete store listing:**
   - App name: "Label Scout"
   - Short description
   - Full description
   - Screenshots
   - Feature graphic (1024 x 500)
   - App icon (512 x 512)
4. **Set content rating**
5. **Set pricing** (Free with in-app purchases)
6. **Add in-app products**
7. **Review and publish**

**Review time:** 1-3 days typically

#### Apple App Store Connect

1. **Create app** in App Store Connect
2. **Upload build** via Xcode or Transporter
3. **Complete app information:**
   - Name: "Label Scout"
   - Subtitle (30 characters)
   - Description
   - Keywords
   - Screenshots
   - App icon (already in build)
4. **Set pricing** (Free with in-app purchases)
5. **Add subscription**
6. **Submit for review**

**Review time:** 24-48 hours typically

---

## 🔍 Final Checks

### Code Quality
- [ ] Remove all `print()` debug statements
- [ ] Remove commented-out code
- [ ] Add proper error handling
- [ ] Verify all imports are used
- [ ] Run `flutter analyze` (0 issues)
- [ ] Run `flutter test` (all pass)

### Performance
- [ ] Test app launch time
- [ ] Check memory usage
- [ ] Verify smooth scrolling
- [ ] Test with large datasets
- [ ] Profile with Flutter DevTools

### Security
- [ ] No hardcoded secrets/API keys
- [ ] Secure local storage
- [ ] HTTPS for all network calls
- [ ] Input validation

---

## 📊 Post-Launch

### Monitoring
- Set up crash reporting (Firebase Crashlytics)
- Monitor app store reviews
- Track key metrics:
  - DAU/MAU (Daily/Monthly Active Users)
  - Scan success rate
  - Pro conversion rate
  - Retention rate

### Updates
- Plan regular updates
- Fix critical bugs within 24-48 hours
- Add requested features
- Keep dependencies updated

---

## 🆘 Common Issues

### "App not installable" on Android
- Check minimum SDK version in build.gradle
- Ensure proper signing configuration
- Verify permissions in manifest

### "Archive not showing in Xcode"
- Ensure "Generic iOS Device" is selected
- Check code signing settings
- Clean build folder (Shift+Cmd+K)

### IAP not working in TestFlight
- Ensure subscription is approved
- Wait 24 hours after creating product
- Use sandbox test account

### Ads not showing
- Check Ad Unit IDs are correct
- Verify AdMob account approved
- Test on real device (not simulator)

---

## 📚 Resources

- [Flutter Deployment Docs](https://docs.flutter.dev/deployment)
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [Google Play Policies](https://play.google.com/about/developer-content-policy/)
- [In-App Purchase Guide](https://pub.dev/packages/in_app_purchase)
- [Google Mobile Ads Setup](https://pub.dev/packages/google_mobile_ads)

---

**Good luck with your launch! 🚀**
