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
- Fund transfer functionality
- Responsive design across different screen sizes

### 📸 Screenshots

 ![Home Screen](screenshots/home.png) | ![Copy Trading](screenshots/copy_trading.png) | ![Market Data](screenshots/market.png) 
|:------------------------------------:|:---------------------------------------------:|:--------------------------------------:|
|             Home Screen              |                 Copy Trading                  |             Real-time Data             |

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
- **Fund Transfers**: Secure movement of assets between accounts

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

## 📸 Demo

*(Note: Include screenshots or GIFs showing key features like the home screen, real-time price
updates, copy trading flow, and biometric authentication)*

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

> *"Tap. Transact. Transcend."*
