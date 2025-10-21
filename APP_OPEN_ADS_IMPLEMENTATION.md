# App Open Ads Implementation - Label Scout

## Overview
App Open Ads are implemented for Label Scout using Google Mobile Ads SDK. These ads appear when users open the app or return to it from the background.

## Configuration

### AdMob IDs

**App ID:** `ca-app-pub-6648737877378523~1142671831`  
**Ad Unit ID (App Open):** `ca-app-pub-6648737877378523/9996806950`

### Platform Configuration

#### Android
✅ **File:** `android/app/src/main/AndroidManifest.xml`
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-6648737877378523~1142671831"/>
```

#### iOS
✅ **File:** `ios/Runner/Info.plist`
```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-6648737877378523~1142671831</string>
```

## Implementation Files

### 1. App Open Ad Manager
**File:** `lib/services/app_open_ad_manager.dart`

**Features:**
- Loads and manages App Open Ads
- Respects Pro user status (no ads for Pro users)
- Handles ad expiration (4-hour cache)
- Auto-reloads ads after they're shown or expired
- Platform-specific ad unit IDs

**Key Methods:**
- `loadAd()` - Loads a new app open ad
- `showAdIfAvailable()` - Shows ad if loaded and not expired
- `isAdAvailable` - Checks if ad is ready to show
- `isAdExpired` - Checks if cached ad is stale
- `dispose()` - Cleanup when no longer needed

### 2. App Lifecycle Reactor
**File:** `lib/services/app_lifecycle_reactor.dart`

**Features:**
- Listens to app lifecycle state changes
- Triggers app open ads when app comes to foreground
- Uses Flutter's WidgetsBindingObserver
- Stream-based architecture for clean separation

**Key Components:**
- `AppLifecycleReactor` - Main reactor class
- `AppStateEventNotifier` - Notifies on state changes
- `AppState` enum - Foreground/Background states

### 3. Main App Integration
**File:** `lib/main.dart`

**Changes:**
- Converted `LabelScoutApp` from StatelessWidget to StatefulWidget
- Initialized `AppOpenAdManager` on app start
- Set up `AppLifecycleReactor` to monitor app state
- Loads first ad immediately on app launch
- Proper cleanup in dispose method

## How It Works

### App Launch Flow
```
1. App starts
   ↓
2. Google Mobile Ads SDK initializes
   ↓
3. AppOpenAdManager created
   ↓
4. First app open ad loads in background
   ↓
5. AppLifecycleReactor starts listening
   ↓
6. App UI displays normally
   ↓
7. If ad loaded, shows on next foreground event
```

### App Resume Flow
```
1. User returns to app (from background)
   ↓
2. AppLifecycleReactor detects foreground state
   ↓
3. Calls appOpenAdManager.showAdIfAvailable()
   ↓
4. Checks:
   - Is user Pro? → Skip ad
   - Is ad loaded? → Show ad
   - Is ad expired? → Load new ad
   ↓
5. Shows ad (if available)
   ↓
6. After ad dismissed, loads new ad for next time
```

## Pro User Handling

App Open Ads respect the Pro subscription status:

```dart
final isPro = await _proStatusService.isProUser();
if (isPro) {
  return; // Don't load or show ads
}
```

**Pro users will NEVER see:**
- App Open Ads
- Banner ads
- Any other ads in the app

## Ad Expiration Policy

- **Cache Duration:** 4 hours
- **Behavior:** Ads older than 4 hours are considered stale
- **Action:** Expired ads are discarded and new ones loaded
- **Why:** Ensures users see fresh, relevant ads

## Testing

### Test Scenarios

#### 1. First Launch (Free User)
1. Install and open app
2. App initializes
3. ✅ First ad loads in background
4. Navigate around app
5. Close app and reopen
6. ✅ App Open Ad appears

#### 2. Pro User (No Ads)
1. Enable Pro status in Settings
2. Close and reopen app
3. ✅ NO App Open Ad shows
4. Ads are not even loaded (saves bandwidth)

#### 3. App Resume
1. Open app (free user)
2. Navigate around
3. Press Home button
4. Wait a few seconds
5. Reopen app
6. ✅ App Open Ad appears

#### 4. Ad Expiration
1. Open app
2. Leave app open for 4+ hours
3. Background and foreground app
4. ✅ New ad loads and shows

### Debug Output

The implementation includes debug print statements:

```
App Open Ad loaded
App Open Ad showed full screen content
App Open Ad dismissed
App state changed to: AppState.foreground
```

## Important Notes

### Ad Loading
- Ads load asynchronously in the background
- First app launch may not show ad immediately
- Subsequent resumes will show ads

### Frequency Capping
- Google automatically limits ad frequency
- Users won't see ads on every single resume
- This is controlled by AdMob settings

### Performance
- Ad loading doesn't block UI
- Minimal impact on app startup time
- Efficient memory management with auto-disposal

## AdMob Console Setup

### Required Steps
1. ✅ App registered with ID: `ca-app-pub-6648737877378523~1142671831`
2. ✅ App Open ad unit created: `ca-app-pub-6648737877378523/9996806950`
3. Configure ad settings in AdMob console:
   - Set frequency capping (recommended: max 4 per day)
   - Enable mediation if desired
   - Set up ad filtering

## Troubleshooting

### Ad Not Showing?

**Check:**
1. Is user Pro? → Ads disabled for Pro users
2. Is app in test mode? → May need test device ID
3. Is ad loaded? → Check debug output
4. AdMob account active? → Verify in console
5. Ad inventory available? → May take time for new apps

### Debug Mode

For testing, you can use AdMob test ad units:

**Test App Open Ad Unit:**
- Android: `ca-app-pub-3940256099942544/9257395921`
- iOS: `ca-app-pub-3940256099942544/5575463023`

Replace in `app_open_ad_manager.dart` temporarily for testing.

## Revenue Optimization

### Best Practices
- ✅ Show on cold start (app launch)
- ✅ Show on warm start (app resume)
- ✅ Respect user experience (Pro users)
- ✅ Cache ads for instant display
- ✅ Auto-reload after dismiss

### Avoid
- ❌ Showing too frequently (use frequency caps)
- ❌ Showing to Pro users
- ❌ Blocking critical user flows
- ❌ Using expired/stale ads

## Analytics

Track ad performance in AdMob console:
- Impressions
- Click-through rate (CTR)
- Estimated earnings
- Fill rate
- eCPM (effective cost per mille)

## Future Enhancements

### Potential Improvements
1. **A/B Testing** - Test different ad frequencies
2. **User Segmentation** - Different strategies per user type
3. **Analytics Integration** - Firebase Analytics tracking
4. **Ad Mediation** - Multiple ad networks for better fill
5. **Custom Frequency** - Per-user frequency management

---

## Quick Reference

### Files Modified
- ✅ `lib/main.dart` - App integration
- ✅ `android/app/src/main/AndroidManifest.xml` - Android config
- ✅ `ios/Runner/Info.plist` - iOS config

### Files Created
- ✅ `lib/services/app_open_ad_manager.dart` - Ad manager
- ✅ `lib/services/app_lifecycle_reactor.dart` - Lifecycle listener

### Ad IDs
- **App ID:** `ca-app-pub-6648737877378523~1142671831`
- **App Open Unit:** `ca-app-pub-6648737877378523/9996806950`

---

**Implementation Date:** October 20, 2025  
**Status:** ✅ Complete and Ready for Production  
**SDK:** Google Mobile Ads v5.3.1
