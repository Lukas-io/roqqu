# 🜂 Roqqu - Cryptocurrency Trading Platform

> *"Code flows. Bytes breathe. The app awakens."*

A mystical take on a crypto mobile experience — where design meets rhythm and code becomes
expression.  
Built with Flutter, animated by intent, and guided by simplicity.


---

## 📱 Demo

### 🎥 Video Walkthrough

[**▶️ Watch the app in action**](https://youtu.be/0Hutg5knaME)

*The video demonstrates:*

- Real-time cryptocurrency price updates via WebSocket
- Smooth animations and transitions throughout the UI
- Copy trading flow and trader selection
- Biometric authentication
- Responsive design across different screen sizes

---

<details>
  <summary><h2>📱 ▼ View App Screenshots</h2></summary>
  <br>
  
<div style="
  overflow-x: auto;
  white-space: nowrap;
  padding-bottom: 10px;
  scroll-behavior: smooth;
">
  <img src="https://github.com/user-attachments/assets/c307ace1-da9f-42cf-8e88-d81449875cf5" alt="Screenshot 1" style="width: 250px; height: auto; margin-right: 8px; border-radius: 8px;" />
  <img src="https://github.com/user-attachments/assets/040de716-b8fe-490c-bb8d-ebafc7a165dd" alt="Screenshot 2" style="width: 250px; height: auto; margin-right: 8px; border-radius: 8px;" />
  <img src="https://github.com/user-attachments/assets/63deccad-bb74-4faa-8c47-aa2ac65cae34" alt="Screenshot 3" style="width: 250px; height: auto; margin-right: 8px; border-radius: 8px;" />
  <img src="https://github.com/user-attachments/assets/da2bf5bc-f63b-4eae-9a7f-f186249922b5" alt="Screenshot 4" style="width: 250px; height: auto; margin-right: 8px; border-radius: 8px;" />
  <img src="https://github.com/user-attachments/assets/fc972dfc-f666-4762-9728-747e56c294c5" alt="Screenshot 5" style="width: 250px; height: auto; margin-right: 8px; border-radius: 8px;" />
  <img src="https://github.com/user-attachments/assets/7dd983ee-d2e2-4f3f-8b6b-46a639bbfd88" alt="Screenshot 6" style="width: 250px; height: auto; margin-right: 8px; border-radius: 8px;" />
  <img src="https://github.com/user-attachments/assets/df935945-b624-4fbc-9e66-b5823083cbfd" alt="Screenshot 7" style="width: 250px; height: auto; margin-right: 8px; border-radius: 8px;" />
  <img src="https://github.com/user-attachments/assets/a028cf2a-3744-45b0-bc86-5ca0b7cac994" alt="Screenshot 8" style="width: 250px; height: auto; margin-right: 8px; border-radius: 8px;" />
  <img src="https://github.com/user-attachments/assets/03e18a5c-e6ee-483d-8910-054921a98c8a" alt="Screenshot 9" style="width: 250px; height: auto; margin-right: 8px; border-radius: 8px;" />
  <img src="https://github.com/user-attachments/assets/71a1ed6a-34ea-4317-b32a-f4b51235a9a8" alt="Screenshot 10" style="width: 250px; height: auto; margin-right: 8px; border-radius: 8px;" />
  <img src="https://github.com/user-attachments/assets/10ec9426-ae0e-4fb9-b2af-b03cee2a3fa0" alt="Screenshot 11" style="width: 250px; height: auto; margin-right: 8px; border-radius: 8px;" />
  <img src="https://github.com/user-attachments/assets/b6c799a3-2542-467d-a34f-cfafb3f599b3" alt="Screenshot 12" style="width: 250px; height: auto; margin-right: 8px; border-radius: 8px;" />
  <img src="https://github.com/user-attachments/assets/c64e371e-127f-44d6-b702-7bde4127406e" alt="Screenshot 13" style="width: 250px; height: auto; margin-right: 8px; border-radius: 8px;" />
  <img src="https://github.com/user-attachments/assets/e1c66c05-f759-4c55-bba9-35a9dcab2399" alt="Screenshot 14" style="width: 250px; height: auto; margin-right: 8px; border-radius: 8px;" />
  <img src="https://github.com/user-attachments/assets/12a4bb69-3760-4478-aa84-e4f262ed9cd9" alt="Screenshot 15" style="width: 250px; height: auto; margin-right: 8px; border-radius: 8px;" />
  <img src="https://github.com/user-attachments/assets/5f1368f5-aafa-4955-b152-23551f1fb41d" alt="Screenshot 16" style="width: 250px; height: auto; margin-right: 8px; border-radius: 8px;" />
</div>

</details>

---

## 📱 Overview

Roqqu is a comprehensive cryptocurrency trading application that provides real-time market data,
copy trading capabilities, and an intuitive user interface. The app connects to the Binance
WebSocket API to deliver live cryptocurrency prices and market updates.

### Key Features

- **Real-time Market Data**: Live cryptocurrency prices via Binance WebSocket API
- **Copy Trading**: Follow successful traders with risk-based investment options
- **Animated UI**: Smooth transitions and visual feedback using Flutter Animate
- **Biometric Authentication**: Secure login with fingerprint or face recognition
- **Market Analytics**: Detailed statistics and historical data visualization

---

## 🛠️ Technical Specifications

### Essential Info

- **Project Name**: Roqqu
- **Flutter Version**: SDK ^3.9.2
- **State Management**: GetX
- **WebSocket API**: Binance (`wss://stream.binance.com:9443/stream`)
- **Supported Cryptocurrencies**: BTC, ETH, ADA, DOGE

### Dependencies

- `get`: ^4.7.2 (State management)
- `dio`: ^5.9.0 (HTTP client)
- `web_socket_channel`: ^3.0.3 (WebSocket communication)
- `flutter_animate`: ^4.5.2 (UI animations)
- `sprung`: ^3.0.1 (Advanced animation curves)
- `local_auth`: ^3.0.0 (Biometric authentication)
- `flutter_svg`: ^2.2.1 (SVG rendering)
- `google_fonts`: ^6.3.2 (Custom fonts)
- `intl`: ^0.20.2 (Internationalization)

---

## 🚀 Setup Instructions

### Prerequisites

- Flutter SDK ^3.9.2
- Android Studio or Xcode for mobile development
- CocoaPods (for iOS development)

### Installation Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/Lukas-io/roqqu.git
   cd roqqu
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. For iOS development, install CocoaPods dependencies:
   ```bash
   cd ios
   pod install
   cd ..
   ```

### How to Run

1. Connect a device or start an emulator
2. Run the app:
   ```bash
   flutter run
   ```

---

## 🏗️ Implementation Notes

### Key Architectural Decisions

- **Clean Architecture**: Separation of concerns with distinct layers for business logic, data
  models, services, and UI
- **GetX State Management**: Lightweight reactive state management solution
- **Repository Pattern**: Centralized data access through service layer
- **Responsive Design**: Adaptive UI for different screen sizes

### Folder Structure

```
lib/
├── src/
│   ├── controller/      # Business logic (GetX controllers)
│   ├── core/           # Shared utilities, themes, constants
│   ├── model/          # Data models and entities
│   ├── service/        # API clients and platform services
│   └── view/           # UI components organized by feature
│       ├── copy_trading/
│       ├── dashboard/
│       ├── home/
│       ├── trader/
│       ├── transfer/
│       └── widgets/
├── initialize.dart     # App initialization
└── main.dart          # Entry point
```

### Notable Features

1. **Real-time WebSocket Integration**: Continuous data streaming from Binance
2. **Intelligent Reconnection Logic**: Exponential backoff strategy for network resilience
3. **Advanced Charting**: Custom painters for price visualization
4. **Biometric Security**: Local authentication for secure access
5. **Smooth Animations**: Physics-based animations using Sprung library

### Challenges & Solutions

1. **WebSocket Connection Management**: Implemented exponential backoff reconnection strategy
2. **Data Synchronization**: Used reactive programming with GetX for seamless UI updates
3. **Memory Management**: Proper disposal of streams and controllers to prevent leaks
4. **Cross-platform Compatibility**: Unified approach for iOS and Android biometric authentication

### Known Limitations

- Currently supports only 4 major cryptocurrencies (BTC, ETH, ADA, DOGE)
- No offline mode for market data
- Limited trading pair options (USDT pairs only)

---

## 🧪 Testing Approach

### Unit Tests

The project includes comprehensive unit tests for business logic, data models, and services:

- **Controller Tests**: Business logic validation for CryptoController
- **Model Tests**: Data structure integrity and copyWith functionality
- **Service Tests**: API interaction and error handling with mocked responses

### Running Tests

To run only the unit tests (recommended approach):

```bash
./run_unit_tests.sh
```

Or manually:

```bash
flutter test test/unit
```

### Test Dependencies

- `flutter_test`: Core testing framework
- `mockito`: Mocking framework for unit tests
- `build_runner`: Code generation for mocks

### Widget Testing

Widget tests are not included in the automated test suite as they require manual testing with the
Flutter debugger for optimal results.

---

## ⚡ Performance Optimizations

1. **Efficient Data Structures**: Observable maps for reactive updates
2. **Lazy Loading**: Components loaded only when needed
3. **Animation Optimization**: Custom animation curves for smooth transitions
4. **Memory Management**: Proper disposal of resources and subscriptions
5. **Network Optimization**: WebSocket for real-time data instead of polling

---

## 🎨 Design Philosophy

The app emphasizes:

- **Simplicity**: Clean, uncluttered interfaces
- **Rhythm**: Consistent motion and timing
- **Expressiveness**: Meaningful animations and transitions
- **Character**: Use of FormaDJR/Encode font for warmth and personality

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

> *"Tap. Transact. Transcend."*
