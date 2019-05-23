<img src="https://github.com/ammaratef45/zold-flutter-client/raw/master/zold_wallet/assets/icon/icon.png" height="100px"/>

[![Managed by Zerocrat](https://www.0crat.com/badge/CGC59KB9B.svg)](https://www.0crat.com/p/CGC59KB9B)
[![Donate via Zerocracy](https://www.0crat.com/contrib-badge/CGC59KB9B.svg)](https://www.0crat.com/contrib/CGC59KB9B)
[![DevOps By Rultor.com](http://www.rultor.com/b/ammaratef45/zold-flutter-client)](http://www.rultor.com/p/ammaratef45/zold-flutter-client)

[![PDD status](http://www.0pdd.com/svg?name=ammaratef45/zold-flutter-client)](http://www.0pdd.com/p?name=ammaratef45/zold-flutter-client)
[![codecov](https://codecov.io/gh/ammaratef45/zold-flutter-client/branch/master/graph/badge.svg)](https://codecov.io/gh/ammaratef45/zold-flutter-client)
[![CircleCI](https://circleci.com/gh/ammaratef45/zold-flutter-client/tree/master.svg?style=svg)](https://circleci.com/gh/ammaratef45/zold-flutter-client/tree/master)
[![Codemagic build status](https://api.codemagic.io/apps/5c9e3459da789b000d1c42b4/5c9e3459da789b000d1c42b3/status_badge.svg)](https://codemagic.io/apps/5c9e3459da789b000d1c42b4/5c9e3459da789b000d1c42b3/latest_build)

Zold wallet built in flutter (Android and iOS platform).

Use it to pay or receive zolds and view your wallet balance and transactions.
[![Get it on Google Play](https://github.com/Volorf/Badges/blob/master/Google%20Play/Google%20Play%20Badge.svg)](https://play.google.com/store/apps/details?id=com.ammar.zold.wallet)
[![Get it on App Store](https://github.com/Volorf/Badges/blob/master/App%20Store/App%20Store%20Badge.svg)](https://testflight.apple.com/join/cqdKZoig)

### Features

* [x] Pull wallet.
* [x] See Transactions History.
* [x] Generate QR code to accept payment.
* [x] Pay by scanning QR or by entering data.
* [x] Login with fingerprint sensor.
* [x] Restart wallet.

## Getting Started with Flutter

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

# How to contribute
 You can follow [this guide](steps_guide.md) to get started without prior knoledge about flutter.
 
 However, I recommend you go through the steps below if you have enough time.

## Installation ##

  - Install [Android Studio](https://developer.android.com/studio) for building Android.
  - Install [xCode](https://developer.apple.com/xcode/) for building iOS.
  - Install Flutter, See [Getting Started with Flutter](#getting-started-with-flutter).
  - Install PDD, [More about PDD here](https://github.com/yegor256/0pdd).
  - We prefer using [VSCode](https://code.visualstudio.com/)
  
## Building ##
  - Run `flutter packages get` first to download the dependencies.
Before running tests, create a file `zold_wallet/test/secret.dart`
execute all commands in the die `zold_wallet`
  - Run `flutter test` to execute tests.
  - Run `flutter run` to try it live on running emulator or usb connected device.
  - Run `flutter build apk` to generate APK file.
  - Run `flutter build ios` to package iOS app.
  
## Submiting a PR ##

Before submitting a PR make sure all these commands work.
 - `flutter test`
 - `flutter build apk`
 - `pdd -f /dev/null -v`
 
