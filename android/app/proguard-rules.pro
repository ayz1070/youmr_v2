# Flutter 관련 ProGuard 규칙
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.plugins.**

# Firebase 관련
-keepclassmembers class * {
    @com.google.firebase.** <fields>;
}
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Google Play Services
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# Google Play Core (Dynamic Features)
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# AdMob
-keep class com.google.android.gms.ads.** { *; }

# Dart/Flutter 관련
-keep class androidx.lifecycle.DefaultLifecycleObserver

# 일반적인 난독화 규칙
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses
-keepattributes EnclosingMethod