# App Icon Setup

## Instructions

1. **Create your app icon** (1024x1024px PNG recommended)
   - Use a design tool like Figma, Canva, or Adobe Illustrator
   - Ensure the icon looks good at small sizes
   - Use your brand colors (e.g., #B17F59, #A5B68D from your app theme)
   - Keep the design simple and recognizable

2. **Save the icon as:**
   ```
   assets/icon/app_icon.png
   ```

3. **Generate launcher icons:**
   ```bash
   flutter pub get
   flutter pub run flutter_launcher_icons
   ```

4. **Done!** The package will automatically:
   - Generate all required Android icon sizes (mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi)
   - Generate all required iOS icon sizes
   - Update the necessary configuration files
   - Create adaptive icons for Android 8.0+

## Icon Specifications

### Recommended Size
- **Source Icon:** 1024x1024px PNG (transparent or solid background)

### Android Adaptive Icons
- The configuration uses a white background (#FFFFFF)
- You can customize this in pubspec.yaml under `adaptive_icon_background`

### Tips for a Great App Icon
- Use your app's primary color (#B17F59 - warm brown)
- Include a symbol related to food scanning or labels
- Ensure good contrast
- Test how it looks on both light and dark backgrounds
- Keep text minimal or avoid it entirely (hard to read at small sizes)

## Design Ideas for Label Scout
- 🏷️ A barcode with a magnifying glass
- 📋 A food label being scanned
- ✓ A checkmark over a barcode
- 🔍 A magnifying glass examining ingredients
- Combine your brand colors in a clean, modern design
