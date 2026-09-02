# ReformFIT iOS App

ReformFIT is a SwiftUI-based iOS fitness application designed for gym and wellness services. The app includes location-based fitness discovery, class information, community/social sections, video content, member profile features, and extended health-related tools.

## Project Overview

This workspace contains a large SwiftUI app for a fitness brand, with multiple feature directories and modular view files. The app is built around a tabbed main interface and uses Firebase for app configuration and cloud services.

## Tech Stack

- SwiftUI
- Firebase
  - Analytics
  - Auth
  - Firestore
  - Core
  - Database
- CocoaPods
- LiveChat SDK
- Xcode project/workspace

## Key Entry Points

- App startup: `ReformFIT/ReformFITApp.swift`
- Main tab navigation: `ReformFIT/Main.swift`
- Global shared state: `ReformFIT/GlobalVariable.swift`

## Main App Structure

```text
ReformFIT/
├── Main.swift                     # Main tab navigation and root app layout
├── ReformFITApp.swift            # App entry point
├── GlobalVariable.swift          # Shared app/global state
├── MainTab/                      # Main tab screens
├── LocationMain/                 # Gym/location pages
├── ClassMain2/                   # Class-related views and models
├── MineMain/                     # Profile and member features
├── Login_up/                     # Sign in / sign up UI and view models
├── MindodyNetworkRequest/        # Network requests / purchase logic
├── Purchases Views 1/            # Purchase flow screens and helpers
├── 1 Expanded functionalities/   # Extra features like calculators/blogs/videos
├── Assets.xcassets/              # App assets
├── GoogleService-Info.plist      # Firebase config file
├── Info.plist                    # App configuration
└── Preview Content/
```

## Features Included

- Location and gym discovery
- Service cards and class categories
- Social/community section
- Video overview and media content
- Member profile and device info
- Blog and wellness content
- BMI / BMR / TDEE calculators
- Purchase and checkout-related views
- Live chat integration

## Firebase Setup

The app includes Firebase configuration via `GoogleService-Info.plist` and initializes Firebase in `ReformFIT/ReformFITApp.swift`.

Before running the app, ensure:

1. Xcode can access the project workspace.
2. CocoaPods dependencies are installed.
3. Your Firebase config file matches your app bundle identifier.
4. You open the `.xcworkspace` file instead of the `.xcodeproj` file when running in Xcode.

## Run the App

### Prerequisites

- Xcode installed
- iOS simulator or physical device
- CocoaPods installed

### Setup

```bash
cd /Users/tot/Documents/Dev/ReformFITAPPIOS
pod install
open ReformFIT.xcworkspace
```

Then select a simulator or device and run the app from Xcode.

## Important Note

From the current code, the app initializer in `ReformFIT/ReformFITApp.swift` is temporarily set to show `LiveChatView()` instead of the main tabbed UI. The main tab navigation still exists in `ReformFIT/Main.swift` and may be restored as the actual root view in future iterations.

## Current Status

This repository appears to be a feature-heavy prototype / development build rather than a finalized production app. It contains many screens and duplicated view folders, so some areas may still be in testing, staging, or migration states.

## License

This project does not currently show a repository license file in the root. Please confirm the intended licensing before publishing or distributing the app.

## Notes for Developers

- Prefer opening the `.xcworkspace` file for CocoaPods dependencies.
- Some modules look duplicated across related folders; check naming and imports before editing to avoid confusion.
- Firebase and LiveChat APIs may require additional configuration depending on your environment.

---

If you want, I can also generate a more polished version of this README tailored for GitHub, including badges, screenshots, and a cleaner architecture section.
