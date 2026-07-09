# PayNow 💰

A comprehensive **Flutter-based digital wallet & fintech demo application** that simulates a full-featured personal finance management platform. All data is simulated in-memory — no real transactions, no external APIs, no backend required.

---

## ✨ Features

### 💳 Digital Wallet
- Virtual balance with add money
- Send/receive money to contacts
- UPI/QR code payments
- Transaction history with search and filters
- Payment receipts
- PIN-based transaction security

### 📊 Finance Management
- Spending analytics & charts
- Monthly financial reports
- Budget planner
- Savings goals tracker
- Net worth dashboard
- Calendar view of transactions
- Credit score dashboard (simulated)

### 📈 Investments (Simulated)
- Stock trading portfolio
- Cryptocurrency wallet
- Mutual fund tracker
- Investment portfolio dashboard
- Retirement planner

### 🧮 Financial Calculators
- **EMI Calculator** — Loan equated monthly installments
- **SIP Calculator** — Systematic investment plan returns
- **FD Calculator** — Fixed deposit maturity
- **RD Calculator** — Recurring deposit maturity
- **GST Calculator** — Goods & Services Tax
- **Tip Calculator** — Restaurant tip splitting
- **Currency Converter** — Multi-currency exchange
- **Income Tax Calculator** — Tax liability estimation

### 🛍️ Additional Services
- Loan application & prepayment (BNPL)
- Insurance hub
- Bill splitting & money requests
- Gift cards marketplace
- Subscription manager
- Rewards & loyalty points
- Daily check-in streaks
- Refer & earn program
- Payment reminders
- Notifications center
- Dark mode theme
- Customizable app settings

---

## Screenshots

| Home Dashboard | Send Money | Analytics |
|----------------|------------|-----------|
| Balance card, quick actions, services grid | Contact list, PIN verification | Spending breakdown, charts |

| Calculators | Investments | Profile |
|-------------|------------|---------|
| EMI, SIP, FD, GST, etc. | Stocks, Crypto, Mutual Funds | Stats, finance tools grid |

---

## Tech Stack

| Component | Technology |
|-----------|------------|
| **Language** | Dart (>=3.4.3) |
| **Framework** | Flutter (stable) |
| **State Management** | ChangeNotifier + ListenableBuilder |
| **Design** | Material Design 3 |
| **Platforms** | Android, iOS, Web, Windows, macOS, Linux |

### Key Dependencies

| Package | Purpose |
|---------|---------|
| `image_picker` | Profile image selection |
| `shared_preferences` | Local persistent storage |
| `google_nav_bar` | Google-style bottom navigation |
| `flutter_native_splash` | Native splash screen |
| `flutter_launcher_icons` | App launcher icons |

---

## Getting Started

### Prerequisites

- **Flutter SDK** >=3.4.3 — [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart** (bundled with Flutter)
- Platform toolchain for your target (Android Studio / Xcode / VS Code)

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/paynow.git
cd paynow

# Install dependencies
flutter pub get

# Generate launcher icons (optional)
flutter pub run flutter_launcher_icons

# Generate native splash screen (optional)
flutter pub run flutter_native_splash:create
```

### Run the App

```bash
# Run in debug mode on connected device/emulator
flutter run

# Run on specific platform
flutter run -d chrome          # Web
flutter run -d windows         # Windows desktop
flutter run -d android         # Android
flutter run -d ios             # iOS (macOS only)

# Run in release mode
flutter run --release
```

### Build for Distribution

```bash
# Android
flutter build apk                      # APK
flutter build appbundle                # App Bundle (Play Store)

# iOS (macOS only)
flutter build ios

# Web
flutter build web

# Desktop
flutter build windows
flutter build macos
flutter build linux
```

---

## Project Structure

```
lib/
├── main.dart                      # App entry point, theme configuration
├── splash_screen.dart              # Animated splash screen
├── Login.dart                      # Login screen
├── MainPage2.dart                  # Main home with drawer & bottom nav
├── logout.dart                     # Logout screen
├── subpages.dart                   # Placeholder pages
├── BottomNavigationBar/
│   ├── Home.dart                   # Dashboard
│   ├── Search.dart                 # User search
│   ├── Pay.dart                    # Send money
│   ├── Account.dart                # Profile & tools
│   └── accountmenu.dart            # Account menu
├── Drawer/
│   ├── Analysis.dart               # Spending analysis
│   ├── Customization.dart          # Appearance settings
│   ├── History.dart                # Transaction history
│   └── Settting.dart               # Security, preferences, about
├── screens/                        # 41+ feature screens
│   ├── add_money_screen.dart
│   ├── bill_split_screen.dart
│   ├── bnpl_screen.dart
│   ├── budget_planner_screen.dart
│   ├── calendar_view_screen.dart
│   ├── credit_score_screen.dart
│   ├── crypto_wallet_screen.dart
│   ├── currency_converter_screen.dart
│   ├── daily_checkin_screen.dart
│   ├── emi_calculator_screen.dart
│   ├── fd_calculator_screen.dart
│   ├── gift_cards_screen.dart
│   ├── gst_calculator_screen.dart
│   ├── income_tax_screen.dart
│   ├── insurance_hub_screen.dart
│   ├── investment_portfolio_screen.dart
│   ├── loan_application_screen.dart
│   ├── monthly_report_screen.dart
│   ├── mutual_fund_screen.dart
│   ├── net_worth_screen.dart
│   ├── notifications_screen.dart
│   ├── payment_receipt_screen.dart
│   ├── payment_reminders_screen.dart
│   ├── rd_calculator_screen.dart
│   ├── refer_earn_screen.dart
│   ├── request_money_screen.dart
│   ├── retirement_planner_screen.dart
│   ├── rewards_screen.dart
│   ├── savings_goals_screen.dart
│   ├── set_pin_screen.dart
│   ├── sip_calculator_screen.dart
│   ├── spending_analytics_screen.dart
│   ├── stock_trading_screen.dart
│   ├── subscription_manager_screen.dart
│   ├── support_screen.dart
│   ├── tip_calculator_screen.dart
│   ├── transaction_search_screen.dart
│   ├── upi_qr_screen.dart
│   └── ... (achievements, enter_pin, loan_prepayment)
└── services/
    └── wallet_service.dart        # Singleton state management (ChangeNotifier)
```

---

## Testing

```bash
# Run all tests
flutter test

# Static analysis
flutter analyze

# Format code
dart format .
```

---

## Configuration

This project requires **no environment variables or API keys**. All data is simulated.

- **App icon** — Replace `assets/Images/PayKaro.jpg` and re-run `flutter_launcher_icons`
- **Splash screen** — Configured in `pubspec.yaml` under `flutter_native_splash`

---

## Platform Support

| Platform | Status |
|----------|--------|
| ✅ Android | Fully supported |
| ✅ iOS | Fully supported (macOS build required) |
| ✅ Web | Supported via Chrome |
| ✅ Windows | Supported |
| ✅ macOS | Supported |
| ✅ Linux | Supported |

---

## License

This project is for educational/demonstration purposes only.

---

## Disclaimer

PayNow is a **simulation/demo application**. It does not connect to any real banking system, payment gateway, or financial institution. All balances, prices, and transactions are mock data. Do NOT use this application for real financial transactions.