
BigButton Calculator
===========================

A simple calculator in Flutter.



Release
--------------

Instuctions

```bash
# flutter_launcher_icons
flutter pub run flutter_launcher_icons:main

# rename
flutter pub global run rename --bundleId com.jimbong.bigbuttoncalculator
flutter pub global run rename --appname "BigButton Calculator"

# flutter_native_splash
flutter pub run flutter_native_splash:create

# Compile
flutter clean && flutter build appbundle --obfuscate --split-debug-info=./symbols/
```
