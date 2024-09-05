#!/bin/sh

#  ci_post_clone.sh
#  Runner
#
#  Created by 大野純平 on 2024/06/25.
#  
# Fail this script if any subcommand fails.
set -e

# Installed Flutter version
FLUTTER_VERSION=3.16.3

# Install Flutter using FVM
brew tap leoafarias/fvm
brew install fvm
fvm install "${FLUTTER_VERSION}"
fvm global "${FLUTTER_VERSION}"
fvm flutter --version

# Install Flutter artifacts for iOS
fvm flutter precache --ios

# Get Flutter packages
cd "${CI_PRIMARY_REPOSITORY_PATH}"
fvm flutter pub get

# Install CocoaPods using Homebrew.
HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew's automatic updates.
brew install cocoapods

# Install CocoaPods dependencies.
cd ios && pod install

copy
