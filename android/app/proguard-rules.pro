# Retain Google Crypto Tink and annotations
-keep class com.google.crypto.** { *; }
-keepattributes *Annotation*
-dontwarn com.google.crypto.**
-keep class javax.annotation.** { *; }
-keep class com.google.errorprone.annotations.** { *; }
-keep class javax.lang.model.** { *; }
-dontwarn javax.lang.model.**
