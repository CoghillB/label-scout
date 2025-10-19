## Proguard/R8 rules for Flutter app
## Keep Flutter and plugin classes that may be removed by aggressive shrinking

# Flutter embedding
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.embedding.** { *; }

# Keep native methods and generated code
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep Hive classes with generated adapters
-keep class **.g.dart { *; }
-keep class **.g*.dart { *; }

# Google Mobile Ads
-keep class com.google.android.gms.** { *; }
-keep class com.google.ads.** { *; }

# Parcelable/Serializable classes used by plugins
-keepclassmembers class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator CREATOR;
}

# Keep OkHttp/Retrofit if used (common http libs)
-dontwarn okhttp3.**
-dontwarn okio.**

# Keep annotations (used by some libraries)
-keepclassmembers class ** {
    @org.jetbrains.annotations.* *;
}

# Prevent warnings for generated classes
-dontwarn **.g.dart

# Play Core / SplitCompat (deferred components / split install)
# Keep and suppress warnings for Play Core classes referenced by Flutter's deferred components integration
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.splitinstall.**
-keep class com.google.android.play.core.splitinstall.** { *; }
-dontwarn com.google.android.play.core.splitcompat.**
-keep class com.google.android.play.core.splitcompat.** { *; }
-dontwarn com.google.android.play.core.tasks.**
-keep class com.google.android.play.core.tasks.** { *; }

# Keep Flutter's Play Store split application wrapper
-keep class io.flutter.embedding.android.FlutterPlayStoreSplitApplication { *; }

## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class com.google.firebase.** { *; }

# Keep native methods
-keepclassmembers class * {
    native <methods>;
}

# Keep Hive classes
-keep class * extends com.hivedb.** { *; }
-keep class * implements com.hivedb.** { *; }

# Keep Google Mobile Ads
-keep public class com.google.android.gms.ads.** {
    public *;
}

-keep public class com.google.ads.** {
    public *;
}

# Keep classes with @Keep annotation
-keep @androidx.annotation.Keep class * {*;}
-keepclasseswithmembers class * {
    @androidx.annotation.Keep <methods>;
}
-keepclasseswithmembers class * {
    @androidx.annotation.Keep <fields>;
}
-keepclasseswithmembers class * {
    @androidx.annotation.Keep <init>(...);
}

# Keep model classes (for Hive)
-keep class com.coghillb.labelscout.** { *; }

# Gson
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Keep generic signature of classes with generics
-keepattributes Signature
