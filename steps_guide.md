# What is this document for?
This document will provide you simple step by step guide to run the project locally and see your changes take effect immediately while you're editing.

## Installation.
- [Download](https://developer.android.com/studio) and install android studio, We will not use android studio but it will install all needed SDK and environment variables we may needed.
- [Install XCode](https://developer.apple.com/xcode/), This step is optional, you will need it only if you intend to run on iPhone.
- [Install flutter](https://flutter.dev/docs/get-started/install) by following the guide of your OS, As a brief, you can follow this [Section](#install-flutter).
- [Install VSCode](https://code.visualstudio.com/).

## Run and see changes.
Clone your fork of the repository, open the folder `zold_wallet` in vscode (by chossing file>open or file>open folder).

open a terminal(Terminal>new terminal) and run the command `flutter packages get`.

If you want to run on an emulator, run `flutter emulators` to see the list of available emulators.

Run `flutter emulators --create` to create a new emulator or `flutter emulators --launch {emulator name ex. Apple}` to run the emulator.

Then use the command `flutter run` to run the app on your emulator, go to the view and edit anything, then press r in the terminal and see the design changes in your screen.

## Install Flutter.
### Linux
[![VIDEO](https://img.youtube.com/vi/bgyTpho2A6w/0.jpg)](https://www.youtube.com/watch?v=bgyTpho2A6w)
- [Download](https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.2.1-stable.tar.xz) the SDK.
- Execute the following commands.
```bash
mkdir ~/development
cd ~/development
tar xf ~/Downloads/flutter_linux_v1.2.1-stable.tar.xz
# execute the next command or append it to your .bashrc to avoid the need of executing it again
export PATH="$PATH:~/development/flutter/bin"
flutter doctor # provide us the output of this command when something is not going okay with you
```
### MacOS
- [Download](https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_v1.2.1-stable.zip) the SDK.
- execute the following commands.
```bash
mkdir ~/development
cd ~/development
tar xf ~/Downloads/flutter_macos_v1.2.1-stable.zip
# execute the next command or append it to your .bash_profile to avoid the need of executing it again
export PATH="$PATH:~/development/flutter/bin"
flutter doctor # provide us the output of this command when something is not going okay with you
```
### Windows
- [Download](https://storage.googleapis.com/flutter_infra/releases/stable/windows/flutter_windows_v1.2.1-stable.zip) the SDK.
- Extract the zip file and place the contained flutter in the desired installation location for the Flutter SDK (eg. C:\src\flutter; do not install Flutter in a directory like C:\Program Files\ that requires elevated privileges).
- Locate the file flutter_console.bat inside the flutter directory. Start it by double-clicking.
- Open the CMD and run `flutter doctor`, provide us the output of this command when something is not going okay with you.
