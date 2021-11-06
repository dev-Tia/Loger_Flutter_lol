## 이 설정은 Flutter 엔진 라이브러리를 보호합니다. 
## 다른 라이브러리(예. Firebase)를 보호하기 위해서는 추가적으로 규칙을 작성해야합니다.

## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**