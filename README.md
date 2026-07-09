# PayNow

<p align="center">
  <img src="assets/Images/PayKaro.jpg" alt="PayNow Logo" width="120" height="120">
</p>

<p align="center">
  <b>Smart Payments, Simplified</b><br>
  A comprehensive Flutter-based digital wallet & fintech demo application
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.4.3+-02569B?logo=flutter">
  <img src="https://img.shields.io/badge/Dart-3.4.3+-0175C2?logo=dart">
  <img src="https://img.shields.io/badge/Platform-6%20cross--platform-4CAF50">
  <img src="https://img.shields.io/badge/Version-2.1.2-blue">
  <img src="https://img.shields.io/badge/License-Educational%20Only-yellow">
</p>

---

## Table of Contents

- [Overview](#overview)
- [Screenshots](#screenshots)
- [Features](#features)
- [Navigation Flow](#navigation-flow)
- [Architecture](#architecture)
- [State Management](#state-management)
- [Data Models](#data-models)
- [Tech Stack](#tech-stack)
- [Dependencies](#dependencies)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Screen Reference](#screen-reference)
- [WalletService API](#walletservice-api)
- [Theming & Customization](#theming--customization)
- [Testing](#testing)
- [Configuration](#configuration)
- [Platform Support](#platform-support)
- [Performance](#performance)
- [Roadmap](#roadmap)
- [Troubleshooting](#troubleshooting)
- [Changelog](#changelog)
- [Contributing](#contributing)
- [License](#license)
- [Disclaimer](#disclaimer)

---

## Overview

PayNow is an all-in-one **fintech simulation app** built with Flutter, designed to demonstrate what a modern digital wallet and personal finance management platform could look like. It features **50+ screens** covering digital payments, investment tracking, financial calculators, insurance, loans, rewards, and more — all running locally with zero backend dependencies.

### Key Highlights

| Aspect | Detail |
|--------|--------|
| **Total Screens** | 50+ across wallet, finance, investments, calculators, services |
| **Data Layer** | Single `ChangeNotifier` singleton — all data in-memory |
| **No Backend** | Zero network calls, no API keys, no database setup |
| **Instant Startup** | No loading spinners — data is ready on launch |
| **Cross-Platform** | Runs on all 6 Flutter platforms unchanged |
| **Codebase** | ~7,500 lines of Dart, single state file at 889 lines |
| **Total Dependencies** | Only 5 runtime packages beyond Flutter SDK |

### What You Can Do

- Manage a simulated wallet balance (send, receive, request money)
- Track spending with analytics and monthly reports
- Set budgets and savings goals
- Trade stocks and cryptocurrency with simulated market data
- Calculate EMIs, SIP returns, FD maturity, GST, income tax, and more
- Apply for loans, manage BNPL orders, view insurance policies
- Earn rewards, maintain check-in streaks, unlock achievements
- Split bills, send gift cards, manage subscriptions
- Customize the app theme and enable dark mode

---

## Screenshots

### Home Dashboard

| Section | Description |
|---------|-------------|
| **Balance Card** | Gradient card showing wallet balance with Add Money and UPI buttons |
| **Quick Actions** | 5 rows of 4 action buttons each (UPI, Refer, Rewards, Goals, Request, Split, EMI, Currency, Budget, Gifts, Badges, Support, SIP, Loans, Notifications, Check-in, Credit, Invest, Reminders, Search, FD, RD, GST, Tip, Subs, Calendar, BNPL, Insurance, Stocks, Tax, Retire, Net Worth, Mutual Funds, Report, Prepay, Crypto) |
| **Services** | Subscriptions, Insurance, Loans sections with horizontal scroll cards |
| **People** | Grid of contact avatars for quick payments |

### Send Money Screen

| Step | Screen |
|------|--------|
| 1 | Contact list sorted by favorites, amount input field, note field |
| 2 | PIN verification via `EnterPinScreen` (4-digit numeric input) |
| 3 | `PaymentReceiptScreen` showing transaction ID, amount, contact, date, status |

### Calculators

| Calculator | Inputs | Outputs |
|------------|--------|---------|
| EMI | Loan amount, interest rate, tenure (months) | Monthly EMI, total interest, total payment |
| SIP | Monthly investment, expected return %, tenure (years) | Invested amount, estimated returns, total value |
| FD | Principal, interest rate, tenure | Maturity amount, total interest earned |
| RD | Monthly deposit, interest rate, tenure | Maturity amount, total interest earned |
| GST | Amount, GST rate (3/5/12/18/28%), inclusive/exclusive | GST amount, total with GST |
| Income Tax | Annual income, age, deductions (80C, 80D, HRA, LTA), old vs new regime | Tax payable under both regimes side-by-side |
| Currency Converter | Amount, from currency, to currency (USD/EUR/GBP/JPY/AED/INR) | Converted amount with rate display |
| Tip | Bill amount, tip percentage, number of people | Tip amount, total bill, per-person share |

---

## Features

### Digital Wallet

- **Virtual Balance** — Starting balance of ₹5,000. Add money via preset amounts (₹100/500/1000/2000/5000).
- **Send Money** — Select a contact, enter amount and note, verify with 4-digit PIN.
- **Request Money** — Send payment requests to any contact with amount and optional note.
- **UPI / QR Code** — Generate and display a simulated UPI QR code for your wallet.
- **Transaction History** — Paginated list of all sent/received transactions with date formatting, color-coded arrows (green for received, red for sent).
- **Transaction Search** — Filter by contact name, amount range, date range, or transaction type.
- **Payment Receipts** — Full digital receipt shown after every successful payment (transaction ID, amount, contact, date/time, status, payment method).
- **PIN Security** — Set a 4-digit PIN on first use. All send-money transactions require PIN verification. PIN is stored as a hash via `shared_preferences`.
- **Favorites** — Mark contacts as favorites. Favorites appear at the top of the contact list in Pay screen.
- **Refer & Earn** — Share a referral code. When someone uses it (simulated), both parties receive ₹200 bonus.

### Finance Management

- **Spending Analytics** — Break down spending by category (Food, Transport, Shopping, Entertainment, Bills, Healthcare, Education, Other). Each category shown with amount, percentage, and color indicator. Total spending displayed at top.
- **Monthly Reports** — Income vs expense comparison for the current month. Shows top spending categories, total spent, and a short AI-style recommendation (e.g., "You spent heavily on Entertainment this month.").
- **Budget Planner** — Set monthly spending limits across 8 categories. Tracks how much of each budget has been used with a progress bar. Overspent categories highlighted in red.
- **Savings Goals** — Create multiple goals (e.g., "New Laptop — ₹50,000"). Shows target amount, saved so far, deadline, and a circular progress indicator. Add money to any goal from wallet balance.
- **Net Worth Dashboard** — Lists all assets (Cash, Stocks, Crypto, Mutual Funds, Real Estate, Vehicle, Gold, Other) and liabilities (Home Loan, Car Loan, Credit Card, Education Loan, Personal Loan, Other) with total asset value, total liability value, and net worth.
- **Calendar View** — Full month calendar with dots on days that have transactions. Tap a day to see that day's transactions listed below.
- **Credit Score** — Simulated credit score (300-900 scale) with rating: Excellent (750+), Good (650-749), Fair (550-649), or Poor (<550). Shows key factors and tips to improve.

### Investments (Simulated)

- **Stock Trading** — 10 Indian stocks with randomized prices on each launch:
  - RELIANCE ( ₹2,500 ), TCS ( ₹3,800 ), INFY ( ₹1,600 ), HDFC ( ₹1,650 ), ICICI ( ₹1,100 )
  - SBIN ( ₹620 ), WIPRO ( ₹440 ), ITC ( ₹340 ), LT ( ₹2,800 ), AXIS ( ₹980 )
  - Buy/sell shares. Portfolio shows holdings, current value, invested amount, and P&L.
- **Cryptocurrency** — 5 cryptocurrencies with randomized prices:
  - BTC ( ₹4,500,000 ), ETH ( ₹250,000 ), SOL ( ₹12,000 ), XRP ( ₹80 ), ADA ( ₹45 )
  - Track units held, current value, and P&L.
- **Mutual Funds** — Track fund name, units held, NAV, and total value.
- **Investment Portfolio** — Consolidated dashboard showing total invested, current value, overall P&L, and a diversification breakdown (Stocks vs Crypto vs Mutual Funds vs Cash).
- **Retirement Planner** — Input current age, retirement age, monthly expenses expected, expected returns % → calculates required monthly SIP investment to build the target corpus.

### Financial Calculators

| Calculator | File | Description |
|------------|------|-------------|
| **EMI Calculator** | `emi_calculator_screen.dart` | Loan amount, annual interest rate, tenure in months → monthly EMI, total interest payable, total payment |
| **SIP Calculator** | `sip_calculator_screen.dart` | Monthly SIP amount, expected annual return %, investment tenure in years → total invested, estimated returns, total corpus |
| **FD Calculator** | `fd_calculator_screen.dart` | Principal, annual interest rate, tenure → maturity amount, total interest |
| **RD Calculator** | `rd_calculator_screen.dart` | Monthly deposit, annual interest rate, tenure → maturity amount, total interest |
| **GST Calculator** | `gst_calculator_screen.dart` | Net amount, GST rate (3/5/12/18/28%), inclusive/exclusive toggle → GST amount, total with GST |
| **Income Tax Calculator** | `income_tax_screen.dart` | Annual income, age group, deductions (80C, 80D, HRA, LTA, NPS, Home Loan), old vs new regime → tax payable with regime comparison |
| **Currency Converter** | `currency_converter_screen.dart` | Amount, source currency (INR/USD/EUR/GBP/JPY/AED), target currency → converted amount with exchange rate display |
| **Tip Calculator** | `tip_calculator_screen.dart` | Bill amount, tip percentage slider (0-30%), number of people → tip amount, total bill, per-person cost |
| **Loan Prepayment** | `loan_prepayment_screen.dart` | Outstanding balance, annual interest rate, monthly EMI, prepayment amount → new loan tenure, interest saved |

### Additional Services

- **Loan Application** — Apply for personal loans up to ₹50,00,000 with 0-60 month tenure. Choose purpose (Wedding, Travel, Business, Medical, Education, Home Renovation, Other). Status tracking (Pending/Approved/Rejected).
- **BNPL (Buy Now Pay Later)** — Create BNPL orders with merchant name, amount, EMI months. View active BNPL orders with monthly EMI schedule and total outstanding.
- **Insurance Hub** — View 4 insurance policies (Health, Life, Motor, Travel) with provider name, premium amount, coverage amount, and expiry date.
- **Bill Splitting** — Split a bill amount equally among selected contacts. Shows per-person share before confirmation. Creates a transaction for each participant.
- **Gift Cards** — Browse 5 gift card brands (Amazon - ₹500, Flipkart - ₹600, Swiggy - ₹300, Netflix - ₹800, Spotify - ₹200). Buy gift cards for contacts with a personal message.
- **Subscription Manager** — Track recurring subscriptions with name, amount, billing cycle (Monthly/Yearly), and next billing date. Shows total monthly and yearly spend.
- **Rewards & Cashback** — Earn reward points through transactions, check-ins, and referrals. Redeem from a catalog of items at various point prices. 1 point = ₹1 value.
- **Daily Check-In** — Consecutive day streak counter. Rewards escalate: Day 1 = 5 coins, Day 2 = 10 coins, Day 3 = 15 coins, and so on. Bonus 50 points every 7 days.
- **Payment Reminders** — Set one-time or recurring reminders (Daily, Weekly, Monthly) with title, amount, and due date. Mark reminders as paid.
- **Notifications Center** — All app notifications listed with title, message, date, and read/unread status. Badge count on the bell icon in the AppBar.
- **Achievements / Badges** — 13 unlockable achievements tracked automatically:
  | Badge | Requirement |
  |-------|-------------|
  | First Transaction | Complete your first transaction |
  | Big Spender | Spend ₹10,000 in total |
  | Saver | Save ₹5,000 in goals |
  | Investor | Buy your first stock |
  | Crypto Trader | Buy your first cryptocurrency |
  | High Roller | Reach a balance of ₹50,000 |
  | Social | Send money to 5 different contacts |
  | Gift Giver | Send a gift card |
  | Check-in Champion | Achieve a 7-day check-in streak |
  | Referral King | Refer 3 friends |
  | Budget Master | Set budgets for all categories |
  | Loan Taker | Take your first loan |
  | Insurance Buyer | Buy an insurance policy |
- **Support Tickets** — Raise support tickets with subject, message, and category (Technical, Account, Payment, Other). View ticket status (Open/In Progress/Resolved/Closed).
- **Dark Mode** — Toggle between light and dark themes in Settings. Preference persisted via `shared_preferences`.
- **Customization** — RGB slider in drawer to change the app's background color dynamically.

---

## Navigation Flow

```
App Launch
    │
    ▼
SplashScreen (animated fade-in, 3 seconds)
    │
    ▼
Login (any username/password accepted)
    │
    ▼
MainPage2
    ├── Drawer (hamburger menu)
    │   ├── History → Transaction History
    │   ├── Analysis → Spending Analytics
    │   ├── Customization → RGB Color Picker
    │   └── Settings → PIN, Dark Mode, About
    │
    ├── Bottom Navigation Bar
    │   ├── Home (Dashboard)
    │   ├── Search (Contact Search)
    │   ├── Pay (Send Money)
    │   └── Account (Profile + Tools)
    │
    └── Launched Screens (via Navigator.push)
        ├── Add Money
        ├── UPI QR
        ├── Refer & Earn
        ├── Rewards
        ├── Savings Goals
        ├── Request Money
        ├── Bill Split
        ├── EMI Calculator
        ├── Currency Converter
        ├── Budget Planner
        ├── Gift Cards
        ├── Achievements
        ├── Support
        ├── SIP Calculator
        ├── Loan Application
        ├── Notifications
        ├── Daily Check-in
        ├── Credit Score
        ├── Investment Portfolio
        ├── Payment Reminders
        ├── Transaction Search
        ├── FD Calculator
        ├── RD Calculator
        ├── GST Calculator
        ├── Tip Calculator
        ├── Subscription Manager
        ├── Calendar View
        ├── BNPL
        ├── Insurance Hub
        ├── Stock Trading
        ├── Income Tax Calculator
        ├── Retirement Planner
        ├── Net Worth
        ├── Mutual Funds
        ├── Monthly Report
        ├── Loan Prepayment
        ├── Crypto Wallet
        ├── Enter PIN / Set PIN
        └── Payment Receipt
```

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                        UI LAYER (Widgets)                          │
│                                                                     │
│  SplashScreen  Login  MainPage2  Home  Search  Pay  Account        │
│  Drawer pages  All 41+ Screens                                      │
│                                                                     │
│  Each widget calls WalletService.instance.method()                  │
│  and rebuilds via ListenableBuilder                                │
└──────────────────────────┬──────────────────────────────────────────┘
                           │  notifyListeners()
                           ▼
┌─────────────────────────────────────────────────────────────────────┐
│                     SERVICE LAYER (Singleton)                      │
│                                                                     │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │                   WalletService                             │   │
│  │  extends ChangeNotifier                                     │   │
│  │                                                             │   │
│  │  Fields: balance, transactions, contacts, notifications,   │   │
│  │          stocks, crypto, goals, budgets, loans, etc.       │   │
│  │                                                             │   │
│  │  Methods: sendMoney(), addMoney(), buyStock(),             │   │
│  │           calculateEMI(), setBudget(), etc.                 │   │
│  │                                                             │   │
│  │  All data initialized in-memory in constructor              │   │
│  └─────────────────────────────────────────────────────────────┘   │
└──────────────────────────┬──────────────────────────────────────────┘
                           │  shared_preferences (read/write)
                           ▼
┌─────────────────────────────────────────────────────────────────────┐
│                      PERSISTENCE LAYER                             │
│                                                                     │
│  shared_preferences (key-value storage)                            │
│  Stored keys: pinHash, isDarkMode, rewardPoints, checkinStreak    │
│                                                                     │
│  Note: Most data (transactions, stocks, etc.) is NOT persisted     │
│  across restarts to keep the simulation fresh.                     │
└─────────────────────────────────────────────────────────────────────┘
```

### Design Decisions

| Decision | Rationale |
|----------|-----------|
| **No state management library** | Built-in `ChangeNotifier` + `ListenableBuilder` is sufficient for a single-user, single-screen simulation. No Provider, Riverpod, Bloc, or Redux needed. |
| **No routing library** | Uses Flutter's built-in `Navigator.push()` / `Navigator.pop()`. The main hub uses `Drawer` for sections and `GNav` for tabs. |
| **No database** | All data initialized in-memory. `shared_preferences` persists only PIN hash and theme preference. |
| **No network layer** | Everything runs locally. Stock/crypto prices are randomized on each launch. |
| **No code generation** | Pure Dart — no build_runner, no codegen, no generated files. |
| **Single file for state** | All 18 model classes and all business logic live in one 889-line file. Intentional for simplicity. |

### Data Flow

```
User Tap → setState / Widget callback
              │
              ▼
WalletService.instance.methodName()
              │
              ▼
Internal state updated (balance, transactions, etc.)
              │
              ▼
notifyListeners() called
              │
              ▼
ListenableBuilder rebuilds UI
```

---

## State Management

### WalletService (`lib/services/wallet_service.dart`)

The entire application state is managed by a single **889-line** singleton class.

```dart
class WalletService extends ChangeNotifier {
  static final WalletService _instance = WalletService._internal();
  factory WalletService() => _instance;
  WalletService._internal() { _initDefaults(); }
}
```

### State Categories

| Category | Fields | Persisted? |
|----------|--------|------------|
| **Wallet** | `balance`, `transactions`, `favoriteContacts`, `pinHash` | PIN hash only |
| **Profile** | `userName`, `userEmail`, `userPhone`, `profileImage` | No |
| **Contacts** | `contacts` (inline list of 11 users) | No |
| **Finance** | `spendingCategories`, `budgets`, `savingGoals`, `monthlyReport` | No |
| **Investments** | `stockHoldings`, `cryptoHoldings`, `mutualFunds` | No |
| **Notifications** | `notifications`, `unreadCount` | No |
| **Settings** | `isDarkMode`, `backgroundColor`, `rewardPoints`, `checkinStreak` | Theme & rewards |
| **Extras** | `paymentRequests`, `giftCards`, `subscriptions`, `bnplOrders`, `loans`, `insurancePolicies`, `supportTickets`, `paymentReminders`, `achievements`, `recurringPayments`, `referralCode`, `referralCount`, `pendingReferralBonus` | No |

### Key Methods

| Method | Description |
|--------|-------------|
| `reset()` | Reinitializes all state to defaults |
| `sendMoney(contact, amount, note)` | Deducts balance, creates transaction, checks achievements |
| `addMoney(amount)` | Credits balance, creates transaction |
| `requestMoney(from, amount, note)` | Creates a payment request |
| `buyStock(symbol, shares)` | Deducts balance, adds to stock holdings |
| `sellStock(symbol, shares)` | Removes from holdings, credits balance |
| `calculateEMI(principal, rate, tenure)` | Returns monthly EMI, total interest, total payment |
| `calculateSIP(monthly, rate, years)` | Returns invested, returns, total corpus |
| `calculateFD(principal, rate, tenure)` | Returns maturity, interest earned |
| `setBudget(category, limit)` | Sets or updates a category budget |
| `addSavingGoal(name, target, deadline)` | Creates a new savings goal |
| `contributeToGoal(index, amount)` | Adds money to a goal from wallet |
| `checkIn()` | Increments streak, awards coins and bonus points |
| `applyForLoan(amount, tenure, purpose)` | Creates a loan application with random approval |
| `raiseTicket(subject, message)` | Creates a support ticket |
| `redeemReward(points)` | Deducts points if sufficient balance |
| `switchTheme()` | Toggles dark/light mode, persists preference |
| `setBackgroundColor(color)` | Updates background color, notifies listeners |

---

## Data Models

All models are defined inline in `lib/services/wallet_service.dart`:

```dart
class Transaction {
  final String id;
  final double amount;
  final TransactionType type; // sent / received
  final String contact;
  final DateTime date;
  final String note;
  final String category;
}

class SavingGoal {
  String name;
  double targetAmount;
  double savedAmount;
  DateTime deadline;
}

class PaymentRequest {
  final String id;
  final String fromContact;
  final double amount;
  final String note;
  final DateTime date;
  final RequestStatus status; // pending / accepted / declined
}

class GiftCard {
  final String id;
  final String brand;
  final double amount;
  final double price;
  final DateTime expiry;
}

class SupportTicket {
  final String id;
  final String subject;
  final String message;
  final TicketStatus status; // open / inProgress / resolved / closed
  final DateTime date;
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  bool unlocked;
}

class RecurringPayment {
  final String id;
  final String billName;
  final double amount;
  final DateTime dueDate;
  final String frequency; // daily / weekly / monthly
}

class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime date;
  bool isRead;
}

class LoanApplication {
  final String id;
  final double amount;
  final int tenure;
  final String purpose;
  final LoanStatus status; // pending / approved / rejected
  final DateTime date;
}

class Investment {
  final String type;
  final String name;
  final double amount;
  final double returns;
}

class PaymentReminder {
  final String id;
  final String title;
  final double amount;
  final DateTime dueDate;
  bool isRecurring;
  bool isPaid;
}

class Subscription {
  final String name;
  final double amount;
  final String billingCycle; // monthly / yearly
  final DateTime nextBilling;
}

class BnplOrder {
  final String id;
  final String merchant;
  final double amount;
  final int emiMonths;
  final BnplStatus status; // active / completed / defaulted
}

class Stock {
  final String symbol;
  final String name;
  int shares;
  double buyPrice;
  double currentPrice;
}

class Asset {
  final String name;
  final double value;
  final String category;
}

class Liability {
  final String name;
  final double amount;
  final String category;
}

class CryptoHolding {
  final String symbol;
  final String name;
  double units;
  double buyPrice;
  double currentPrice;
}

class InsurancePolicy {
  final String type;
  final String provider;
  final double premium;
  final double coverage;
  final DateTime expiry;
}
```

---

## Tech Stack

| Component | Technology |
|-----------|------------|
| **Language** | Dart (>=3.4.3) |
| **Framework** | Flutter (stable channel, v3.4.3) |
| **State Management** | ChangeNotifier + ListenableBuilder |
| **Design Language** | Material Design 3 |
| **Navigation** | Navigator.push + Drawer + GNav (bottom nav) |
| **Persistence** | shared_preferences (minimal — PIN hash, theme) |
| **Images** | image_picker (camera/gallery) |
| **Theming** | Primary `#4A90E2`, gradient cards, rounded corners, dark mode |

### Architecture Pattern

```
Presentation: Widgets (StatelessWidget / StatefulWidget)
Business Logic: WalletService (ChangeNotifier singleton)
Data: In-memory initialization with SharedPreferences for persistence
```

No BLoC, no Provider, no Riverpod, no Redux, no GetX — intentional simplicity.

---

## Dependencies

### Runtime Dependencies

| Package | Version | Purpose | Usage |
|---------|---------|---------|-------|
| `flutter` | SDK | Core UI framework | Every widget |
| `image_picker` | ^1.2.3 | Select profile image from gallery or camera | Account/profile screens |
| `shared_preferences` | ^2.2.2 | Persistent key-value storage | PIN hash, dark mode, rewards |
| `google_nav_bar` | ^5.0.0 | Google-style bottom navigation bar | MainPage2 bottom tabs |
| `flutter_native_splash` | ^2.2.16 | Native splash screen | Splash on cold start |
| `cupertino_icons` | ^1.0.6 | iOS-style icon set | Fallback icons |

### Dev Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_test` | SDK | Widget and unit testing |
| `flutter_launcher_icons` | ^0.14.4 | Generate app launcher icons for all platforms |
| `flutter_lints` | 3.0.2 | Recommended lint rules from Dart team |

### What's NOT Used (Intentionally)

| Technology | Reason |
|------------|--------|
| Firebase / Supabase | No backend needed — all data is simulated |
| SQLite / Hive / Drift | No database needed — data resets on restart |
| Provider / Riverpod / Bloc | ChangeNotifier is sufficient for this scope |
| GoRouter / AutoRoute | Basic Navigator.push keeps dependencies minimal |
| HTTP / Dio | No network calls whatsoever |
| JSON serialization | No JSON parsing needed — all data created in code |
| build_runner | No code generation needed |
| WebSockets | No real-time features |
| Payment gateways (Stripe, Razorpay) | Simulation only — no real payments |

---

## Getting Started

### Prerequisites

- **Flutter SDK** >=3.4.3 — [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart** (bundled with Flutter SDK)
- A code editor: [VS Code](https://code.visualstudio.com/) with Flutter extension, [Android Studio](https://developer.android.com/studio), or [IntelliJ IDEA](https://www.jetbrains.com/idea/)

### Platform-Specific Requirements

| Platform | Requirement |
|----------|-------------|
| **Android** | Android Studio, Android SDK 21+, emulator or device |
| **iOS** | macOS only, Xcode 15+, CocoaPods (`sudo gem install cocoapods`) |
| **Web** | Chrome browser (or Edge, Safari, Firefox) |
| **Windows** | Windows 10/11, Visual Studio 2022 with "Desktop development with C++" workload |
| **macOS** | macOS only, Xcode 15+, CocoaPods |
| **Linux** | GTK 3 development libraries (`libgtk-3-dev` on Ubuntu/Debian, `gtk3-devel` on Fedora) |

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/paynow.git
cd paynow

# Install Flutter dependencies
flutter pub get

# Verify environment
flutter doctor

# Generate launcher icons (optional — replaces default icon)
flutter pub run flutter_launcher_icons

# Generate native splash screen (optional)
flutter pub run flutter_native_splash:create
```

### Run the App

```bash
# Run in debug mode on connected device or emulator
flutter run

# Run on a specific platform
flutter run -d chrome          # Web
flutter run -d windows         # Windows desktop
flutter run -d macos           # macOS (macOS only)
flutter run -d linux           # Linux
flutter run -d android         # Android emulator or device
flutter run -d ios             # iOS simulator (macOS only)

# Run in release mode
flutter run --release

# Run without flutter tools (already built)
# On Windows: build\windows\runner\Release\paynow.exe
```

### Build for Distribution

```bash
# Android
flutter build apk                       # Signed APK
flutter build appbundle                 # App Bundle (Play Store release)

# iOS (macOS only)
flutter build ios                       # .xcarchive (requires Apple Developer account)

# Web
flutter build web                       # Outputs to build/web/

# Windows
flutter build windows                   # Outputs to build/windows/runner/Release/

# macOS (macOS only)
flutter build macos                     # Outputs to build/macos/Build/Products/Release/

# Linux
flutter build linux                     # Outputs to build/linux/x64/release/bundle/
```

---

## Project Structure

```
paynow/
│
├── android/                           # Android platform configuration
│   ├── app/
│   │   ├── src/main/                  # AndroidManifest, Kotlin, resources
│   │   └── build.gradle.kts           # Android build config
│   └── gradle/                        # Gradle wrapper
│
├── ios/                               # iOS platform configuration
│   ├── Runner/                        # AppDelegate, Info.plist, storyboards
│   └── Podfile                        # CocoaPods config
│
├── web/                               # Web platform
│   ├── index.html                     # Entry point HTML
│   └── manifest.json                  # PWA manifest
│
├── windows/                           # Windows desktop platform
│   ├── runner/                        # Win32 entry point
│   └── flutter/                       # Generated Windows config
│
├── macos/                             # macOS desktop platform (macOS only)
│   ├── Runner/                        # MacOS entry point
│   └── Podfile                        # CocoaPods config
│
├── linux/                             # Linux desktop platform
│   ├── runner/                        # GTK entry point
│   └── flutter/                       # Generated Linux config
│
├── assets/
│   └── Images/                        # App image assets
│       ├── PayKaro.jpg                # App icon & logo
│       ├── Rupee.jpg                  # Rupee symbol image
│       ├── banner.jpg                 # Banner image
│       └── OIP.jpeg                   # Additional image
│
├── test/
│   └── widget_test.dart               # Basic placeholder widget test
│
├── lib/                               # Main Dart source code
│   │
│   ├── main.dart                      # App entry point (41 lines)
│   │   # MaterialApp with blue theme (#4A90E2), Material Design 3,
│   │   # Roboto font, styled buttons/cards/inputs, splash as home
│   │
│   ├── splash_screen.dart             # Animated splash (107 lines)
│   │   # Fade-in animation (1.5s), circular logo, tagline
│   │   # Auto-navigates to Login after 3 seconds
│   │
│   ├── Login.dart                     # Login screen (202 lines)
│   │   # Username/password fields, validation, loading state
│   │   # No real auth — any input accepted
│   │
│   ├── MainPage2.dart                 # Main navigation hub (607 lines)
│   │   # AppBar with drawer toggle, bell icon, profile avatar
│   │   # 50+ drawer items in sections: Payments, Finance, etc.
│   │   # GNav bottom nav: Home, Search, Pay, Account
│   │   # Routes to all feature screens
│   │
│   ├── logout.dart                    # Logout screen (58 lines)
│   │   # Gradient background, navigates back to Login
│   │
│   ├── subpages.dart                  # Utility/placeholder pages (262 lines)
│   │   # LightBill, AddCart, Recharge, YourBusiness, etc.
│   │   # 6 user profile pages (User1-User6)
│   │
│   ├── BottomNavigationBar/           # Bottom tab screens
│   │   ├── Home.dart                  # Dashboard (338 lines)
│   │   │   # Balance card, 5 rows × 4 quick action buttons
│   │   │   # Services section, People contacts grid
│   │   │
│   │   ├── Search.dart                # Contact search (205 lines)
│   │   │   # TextField filter against 11 inline contacts
│   │   │   # Shows name, description, profile image
│   │   │
│   │   ├── Pay.dart                   # Send money (216 lines)
│   │   │   # Balance display, quick actions, sorted contact list
│   │   │   # PIN verification, receipt on success
│   │   │
│   │   ├── Account.dart               # Profile dashboard (262 lines)
│   │   │   # Avatar, balance card, 6 rows finance tools
│   │   │   # Account summary, logout
│   │   │
│   │   └── accountmenu.dart           # Alternative account menu (151 lines)
│   │       # Balance, action buttons, quick stats, logout
│   │
│   ├── Drawer/                        # Drawer section screens
│   │   ├── Analysis.dart              # Spending analysis (11 lines)
│   │   │   # Redirects to SpendingAnalyticsScreen
│   │   │
│   │   ├── Customization.dart         # Appearance (89 lines)
│   │   │   # RGB sliders for background color
│   │   │
│   │   ├── History.dart               # Transaction history (97 lines)
│   │   │   # Paginated list, date formatting, color-coded arrows
│   │   │
│   │   └── Settting.dart              # Settings (105 lines)
│   │       # PIN management, dark mode, rewards, version info
│   │
│   ├── screens/                       # All feature screens (41 files)
│   │   #
│   │   # Wallet
│   │   ├── add_money_screen.dart
│   │   ├── upi_qr_screen.dart
│   │   ├── transaction_search_screen.dart
│   │   ├── payment_receipt_screen.dart
│   │   ├── enter_pin_screen.dart
│   │   ├── set_pin_screen.dart
│   │   ├── request_money_screen.dart
│   │   ├── bill_split_screen.dart
│   │   #
│   │   # Finance
│   │   ├── spending_analytics_screen.dart
│   │   ├── monthly_report_screen.dart
│   │   ├── budget_planner_screen.dart
│   │   ├── savings_goals_screen.dart
│   │   ├── net_worth_screen.dart
│   │   ├── calendar_view_screen.dart
│   │   ├── credit_score_screen.dart
│   │   #
│   │   # Investments
│   │   ├── stock_trading_screen.dart
│   │   ├── crypto_wallet_screen.dart
│   │   ├── mutual_fund_screen.dart
│   │   ├── investment_portfolio_screen.dart
│   │   ├── retirement_planner_screen.dart
│   │   #
│   │   # Calculators
│   │   ├── emi_calculator_screen.dart
│   │   ├── sip_calculator_screen.dart
│   │   ├── fd_calculator_screen.dart
│   │   ├── rd_calculator_screen.dart
│   │   ├── gst_calculator_screen.dart
│   │   ├── income_tax_screen.dart
│   │   ├── currency_converter_screen.dart
│   │   ├── tip_calculator_screen.dart
│   │   ├── loan_prepayment_screen.dart
│   │   #
│   │   # Services
│   │   ├── loan_application_screen.dart
│   │   ├── bnpl_screen.dart
│   │   ├── insurance_hub_screen.dart
│   │   ├── gift_cards_screen.dart
│   │   ├── subscription_manager_screen.dart
│   │   ├── rewards_screen.dart
│   │   ├── daily_checkin_screen.dart
│   │   ├── refer_earn_screen.dart
│   │   ├── payment_reminders_screen.dart
│   │   ├── notifications_screen.dart
│   │   ├── achievements_screen.dart
│   │   ├── support_screen.dart
│   │   #
│   │   # Other
│   │   └── ... (all above screens)
│   │
│   └── services/
│       └── wallet_service.dart        # Singleton ChangeNotifier (889 lines)
│           # All 18 data models, all business logic, all state
│           # Single file — intentional for simplicity
│
├── pubspec.yaml                       # Project manifest
│   # Name: paynow, Version: 2.1.2, SDK: >=3.4.3 <4.0.0
│   # 6 runtime + 3 dev dependencies
│   # Assets: assets/Images/
│   # Launcher icons & splash screen config
│
├── analysis_options.yaml              # Dart linter rules (flutter_lints)
├── .gitignore                         # Git ignore rules
├── .metadata                          # Flutter tool metadata
└── README.md                          # This file
```

---

## Screen Reference

| # | Screen | File | Lines | Category |
|---|--------|------|-------|----------|
| 1 | Splash | `splash_screen.dart` | 107 | Onboarding |
| 2 | Login | `Login.dart` | 202 | Onboarding |
| 3 | Main Navigation | `MainPage2.dart` | 607 | Core |
| 4 | Logout | `logout.dart` | 58 | Core |
| 5 | Home Dashboard | `BottomNavigationBar/Home.dart` | 338 | Core |
| 6 | Search | `BottomNavigationBar/Search.dart` | 205 | Core |
| 7 | Pay | `BottomNavigationBar/Pay.dart` | 216 | Core |
| 8 | Account | `BottomNavigationBar/Account.dart` | 262 | Core |
| 9 | Account Menu | `BottomNavigationBar/accountmenu.dart` | 151 | Core |
| 10 | History | `Drawer/History.dart` | 97 | Core |
| 11 | Analysis | `Drawer/Analysis.dart` | 11 | Core |
| 12 | Customization | `Drawer/Customization.dart` | 89 | Core |
| 13 | Settings | `Drawer/Settting.dart` | 105 | Core |
| 14 | Add Money | `screens/add_money_screen.dart` | — | Wallet |
| 15 | UPI QR | `screens/upi_qr_screen.dart` | — | Wallet |
| 16 | Transaction Search | `screens/transaction_search_screen.dart` | — | Wallet |
| 17 | Payment Receipt | `screens/payment_receipt_screen.dart` | — | Wallet |
| 18 | Enter PIN | `screens/enter_pin_screen.dart` | — | Wallet |
| 19 | Set PIN | `screens/set_pin_screen.dart` | — | Wallet |
| 20 | Request Money | `screens/request_money_screen.dart` | — | Wallet |
| 21 | Bill Split | `screens/bill_split_screen.dart` | — | Wallet |
| 22 | Spending Analytics | `screens/spending_analytics_screen.dart` | — | Finance |
| 23 | Monthly Report | `screens/monthly_report_screen.dart` | — | Finance |
| 24 | Budget Planner | `screens/budget_planner_screen.dart` | — | Finance |
| 25 | Savings Goals | `screens/savings_goals_screen.dart` | — | Finance |
| 26 | Net Worth | `screens/net_worth_screen.dart` | — | Finance |
| 27 | Calendar View | `screens/calendar_view_screen.dart` | — | Finance |
| 28 | Credit Score | `screens/credit_score_screen.dart` | — | Finance |
| 29 | Stock Trading | `screens/stock_trading_screen.dart` | — | Investments |
| 30 | Crypto Wallet | `screens/crypto_wallet_screen.dart` | — | Investments |
| 31 | Mutual Funds | `screens/mutual_fund_screen.dart` | — | Investments |
| 32 | Investment Portfolio | `screens/investment_portfolio_screen.dart` | — | Investments |
| 33 | Retirement Planner | `screens/retirement_planner_screen.dart` | — | Investments |
| 34 | EMI Calculator | `screens/emi_calculator_screen.dart` | — | Calculators |
| 35 | SIP Calculator | `screens/sip_calculator_screen.dart` | — | Calculators |
| 36 | FD Calculator | `screens/fd_calculator_screen.dart` | — | Calculators |
| 37 | RD Calculator | `screens/rd_calculator_screen.dart` | — | Calculators |
| 38 | GST Calculator | `screens/gst_calculator_screen.dart` | — | Calculators |
| 39 | Income Tax | `screens/income_tax_screen.dart` | — | Calculators |
| 40 | Currency Converter | `screens/currency_converter_screen.dart` | — | Calculators |
| 41 | Tip Calculator | `screens/tip_calculator_screen.dart` | — | Calculators |
| 42 | Loan Prepayment | `screens/loan_prepayment_screen.dart` | — | Calculators |
| 43 | Loan Application | `screens/loan_application_screen.dart` | — | Services |
| 44 | BNPL | `screens/bnpl_screen.dart` | — | Services |
| 45 | Insurance Hub | `screens/insurance_hub_screen.dart` | — | Services |
| 46 | Gift Cards | `screens/gift_cards_screen.dart` | — | Services |
| 47 | Subscription Manager | `screens/subscription_manager_screen.dart` | — | Services |
| 48 | Rewards | `screens/rewards_screen.dart` | — | Services |
| 49 | Daily Check-In | `screens/daily_checkin_screen.dart` | — | Services |
| 50 | Refer & Earn | `screens/refer_earn_screen.dart` | — | Services |
| 51 | Payment Reminders | `screens/payment_reminders_screen.dart` | — | Services |
| 52 | Notifications | `screens/notifications_screen.dart` | — | Services |
| 53 | Achievements | `screens/achievements_screen.dart` | — | Services |
| 54 | Support | `screens/support_screen.dart` | — | Services |
| 55-60 | Subpages | `subpages.dart` | 262 | Utility |

---

## WalletService API

### Wallet Operations

```dart
double get balance;
bool get hasPin;
List<Transaction> get transactions;
List<Map<String, dynamic>> get contacts;
List<String> get favoriteContacts;

void addMoney(double amount);
bool sendMoney(String contact, double amount, String note);
void requestMoney(String contact, double amount, String note);
void toggleFavorite(String contact);
bool verifyPin(String pin);
void setPin(String pin);
```

### Finance Operations

```dart
Map<String, double> get spendingCategories;
Map<String, double> get budgets;
List<SavingGoal> get savingGoals;
Map<String, double> get monthlyReport;

void setBudget(String category, double limit);
void addSavingGoal(String name, double target, DateTime deadline);
void contributeToGoal(int index, double amount);
```

### Investment Operations

```dart
List<Stock> get stockHoldings;
List<CryptoHolding> get cryptoHoldings;
List<Map<String, dynamic>> get mutualFunds;

void buyStock(String symbol, int shares);
void sellStock(String symbol, int shares);
void buyCrypto(String symbol, double units);
void sellCrypto(String symbol, double units);
```

### Calculator Methods

```dart
Map<String, double> calculateEMI(double principal, double rate, int tenure);
Map<String, double> calculateSIP(double monthly, double rate, int years);
Map<String, double> calculateFD(double principal, double rate, int tenure);
Map<String, double> calculateRD(double monthly, double rate, int tenure);
Map<String, double> calculateGST(double amount, double rate, bool isInclusive);
Map<String, double> calculateIncomeTax(double income, String regime, Map deductions);
double convertCurrency(double amount, String from, String to);
Map<String, double> calculateTip(double bill, double tipPercent, int people);
```

### Service Operations

```dart
void checkIn();
bool redeemReward(int points);
void applyForLoan(double amount, int tenure, String purpose);
void raiseTicket(String subject, String message);
void buyGiftCard(String brand, String contact, String message);
void addSubscription(String name, double amount, String cycle);
void addPaymentReminder(String title, double amount, DateTime dueDate, bool recurring);
void markNotificationRead(int index);
List<Achievement> get achievements;
```

### Settings

```dart
bool get isDarkMode;
Color get backgroundColor;
int get rewardPoints;
int get checkinStreak;

void switchTheme();
void setBackgroundColor(Color color);
void reset();
```

---

## Theming & Customization

### Color Scheme

| Role | Light Mode | Dark Mode |
|------|-----------|-----------|
| **Primary** | `#4A90E2` (blue) | `#4A90E2` |
| **Scaffold Background** | `#F5F5F5` | `#121212` |
| **Card Background** | `#FFFFFF` | `#1E1E1E` |
| **Text Primary** | `#212121` | `#FFFFFF` |
| **Text Secondary** | `#757575` | `#B0B0B0` |
| **Gradient Start** | `#4A90E2` | `#1A237E` |
| **Gradient End** | `#357ABD` | `#283593` |
| **Success** | `#4CAF50` | `#66BB6A` |
| **Danger** | `#F44336` | `#EF5350` |

### Typography

- **Font Family**: Roboto (default Flutter font)
- **Headings**: `fontWeight: FontWeight.bold`, sizes 18-24
- **Body**: Regular weight, sizes 14-16
- **Balance Display**: Large (size 32-40), bold

### Button Style

```dart
ElevatedButton.styleFrom(
  backgroundColor: primaryColor,
  foregroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
)
```

### Card Style

```dart
Card(
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  // Gradient backgrounds used for balance cards
)
```

---

## Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Generate coverage report (requires lcov)
genhtml coverage/lcov.info -o coverage/html

# Open coverage report
# Windows: start coverage/html/index.html
# macOS: open coverage/html/index.html
# Linux: xdg-open coverage/html/index.html

# Static analysis (linting)
flutter analyze

# Check for outdated dependencies
flutter pub outdated

# Format code
dart format .
```

### Test Structure

```
test/
└── widget_test.dart          # Basic test: app renders, finds PayNow text
```

The project currently has a single placeholder widget test. To improve test coverage:

1. **Unit tests for WalletService** — Create `test/services/wallet_service_test.dart`:
   ```dart
   void main() {
     group('WalletService', () {
       test('sendMoney deducts balance', () {
         final service = WalletService();
         final initialBalance = service.balance;
         service.sendMoney('Test', 500, 'Test payment');
         expect(service.balance, initialBalance - 500);
       });
     });
   }
   ```

2. **Widget tests** — Create `test/screens/add_money_screen_test.dart` using `WidgetTester`

3. **Integration tests** — Create `test/integration/` for full flow tests

---

## Configuration

No environment variables or API keys are required. Everything runs locally with simulated data.

### App Icon

1. Replace `assets/Images/PayKaro.jpg` with your own 1024×1024 image
2. Run `flutter pub run flutter_launcher_icons`
3. Adapted icons are generated for all platforms based on `pubspec.yaml` config

### Splash Screen

Configured in `pubspec.yaml` under `flutter_native_splash`:

```yaml
flutter_native_splash:
  color: "#42a5f5"
  image: assets/PayKaro.jpeg
  android_12:
    image: assets/PayKaro.jpeg
```

To regenerate: `flutter pub run flutter_native_splash:create`

### Customization Points

| What | Where | Default |
|------|-------|---------|
| **Primary color** | `lib/main.dart` → `primaryColor` | `#4A90E2` |
| **Default balance** | `lib/services/wallet_service.dart` → `_balance` | `5000.0` |
| **Default contacts** | `lib/services/wallet_service.dart` → `_initContacts()` | 11 contacts |
| **Stock data** | `lib/services/wallet_service.dart` → `_initStockHoldings()` | 10 Indian stocks |
| **Crypto data** | `lib/services/wallet_service.dart` → `_initCryptoHoldings()` | 5 cryptocurrencies |
| **Notification messages** | `lib/services/wallet_service.dart` → `_initNotifications()` | 10 sample notifications |
| **Splash delay** | `lib/splash_screen.dart` → `Future.delayed(Duration(seconds: 3))` | 3 seconds |
| **App title** | `lib/main.dart` → `title:` | `"PayNow"` |
| **Reward values** | `lib/services/wallet_service.dart` → check-in/referral amounts | various |

---

## Platform Support

| Platform | Status | Build Command | Notes |
|----------|--------|---------------|-------|
| Android | Fully supported | `flutter build apk` | Min SDK 21, APK & App Bundle |
| iOS | Fully supported | `flutter build ios` | Requires macOS, Xcode 15+ |
| Web | Supported | `flutter build web` | Chrome, Edge, Safari, Firefox |
| Windows | Supported | `flutter build windows` | Windows 10/11, Visual Studio 2022 |
| macOS | Supported | `flutter build macos` | macOS 12+, Xcode 15+ |
| Linux | Supported | `flutter build linux` | GTK 3 dev libraries |

### Known Platform Differences

| Feature | Android / iOS | Web | Desktop |
|---------|---------------|-----|---------|
| image_picker | Camera & Gallery | File picker only | File picker only |
| shared_preferences | Native SharedPrefs | localStorage | File-based storage |
| Haptic feedback | Supported | Not supported | Partial |
| App lifecycle | Full | Limited | Full |
| Keyboard handling | Soft keyboard | Browser keyboard | Native keyboard |

---

## Performance

### App Size (Approximate Release Build)

| Platform | Size |
|----------|------|
| Android APK | ~15-20 MB |
| iOS IPA | ~20-30 MB |
| Web | ~2-3 MB (gzipped) |
| Windows | ~15-25 MB |
| macOS | ~20-30 MB |
| Linux | ~15-25 MB |

### Memory Usage

- **Idle**: ~80-120 MB (varies by platform)
- **Active navigation**: ~100-150 MB
- **Heavy screens** (calendar, trading): ~120-180 MB

### Optimization Notes

- All data is in memory — no async database reads
- No network calls — no latency
- Minimal rebuilds due to coarse-grained `notifyListeners()`
- No images loaded from network — only local assets
- No animations that affect layout (fade-in splash is lightweight)

---

## Roadmap

### Short-Term

- [ ] Add `fl_chart` for visualizing spending analytics with pie/bar charts
- [ ] Implement proper input validation across all calculator screens
- [ ] Add empty state illustrations for lists (no transactions, no goals, etc.)
- [ ] Improve accessibility with semantic labels and larger tap targets

### Medium-Term

- [ ] Migrate to Riverpod for better state management and testability
- [ ] Add SQLite database (drift/hive) for data persistence across sessions
- [ ] Biometric authentication (fingerprint / face ID)
- [ ] Export transaction history as CSV / PDF
- [ ] Multi-language support (i18n) with ARB files
- [ ] Add onboarding tutorial screens for first launch

### Long-Term

- [ ] Real API integration mode alongside simulation mode
- [ ] Push notification support (Firebase Cloud Messaging)
- [ ] End-to-end encryption for simulated transactions
- [ ] CI/CD pipeline with GitHub Actions (test, analyze, build)
- [ ] Full widget test coverage for all 50+ screens
- [ ] Integration test suite for critical user flows
- [ ] Performance benchmarking with Flutter DevTools

---

## Troubleshooting

### Flutter Doctor

Always start with `flutter doctor` to identify environment issues:

```bash
flutter doctor -v
```

### Common Issues

| Problem | Likely Cause | Solution |
|---------|-------------|----------|
| `flutter pub get` fails | Flutter SDK not installed or wrong version | Run `flutter doctor`. Install Flutter >=3.4.3 |
| Build errors on Windows | Missing Visual Studio C++ workload | Install VS 2022 with "Desktop development with C++" |
| Build errors on Linux | Missing GTK development libraries | `sudo apt install libgtk-3-dev` (Ubuntu/Debian) |
| `flutter run -d chrome` fails | Web not enabled | `flutter config --enable-web` |
| `flutter run -d ios` fails | Not on macOS or Xcode missing | iOS build requires macOS + Xcode |
| Splash screen not showing | Not generated yet | `flutter pub run flutter_native_splash:create` |
| Navigation doesn't work | File not imported in MainPage2 | Check imports in `MainPage2.dart` |
| Balance shows 0 | WalletService not initialized | `WalletService()` constructor called (creates singleton) |
| PIN screen loops | PIN not set or shared_preferences issue | Clear app data or call `reset()` |
| Stock prices don't change | Randomized on launch only | Re-launch the app for new prices |
| App crashes on Android | Min SDK too high | Check `android/app/build.gradle` → `minSdk` |
| Weird colors / layout | Dark mode artifacts | Toggle dark mode in Settings |
| Images not showing | Asset path incorrect | Verify asset paths in `pubspec.yaml` |

### Reset App Data

To completely reset the app to its initial state:

```dart
// In code
WalletService.instance.reset();
```

Or clear app storage via device settings (Android: Settings → Apps → PayNow → Storage → Clear Data).

### Debug Tips

```bash
# Run with detailed logs
flutter run --verbose

# Profile performance
flutter run --profile

# Check for unnecessary rebuilds
flutter run --trace-startup --profile
```

Then use **Flutter DevTools**:
```bash
flutter pub global activate devtools
flutter devtools
```

---

## Changelog

### Version 2.1.2 (Current)

- Added income tax calculator with old vs new regime comparison
- Added loan prepayment calculator
- Added BNPL order management screen
- Added mutual fund tracking
- Added insurance hub with policy management
- Added currency converter with 6 currencies
- Added net worth dashboard (assets vs liabilities)
- Added retirement planner
- Added achievements/badges system (13 badges)
- Added payment reminders with recurring support
- Added dark mode toggle
- Added app background color customization
- Added notification bell with unread badge
- Enhanced spending analytics with category breakdown
- Enhanced transaction history with search and filter
- Refactored WalletService into dedicated service file

### Version 2.0.0

- Complete UI overhaul with Material Design 3
- Added bottom navigation bar (GNav)
- Added drawer navigation with category sections
- Added all financial calculators (EMI, SIP, FD, RD, GST, Tip)
- Added stock trading simulator with 10 stocks
- Added crypto wallet with 5 cryptocurrencies
- Added rewards and daily check-in system
- Added referral program
- Added savings goals tracker
- Added budget planner
- Added monthly financial reports
- Added calendar transaction view
- Added gift cards marketplace
- Added subscription manager
- Added support ticket system
- Added UPI QR code generation

### Version 1.0.0

- Initial release
- Basic wallet with send/receive money
- Transaction history
- Contact management
- PIN security
- Login/splash screens

---

## Contributing

Contributions, issues, and feature requests are welcome.

### How to Contribute

1. **Fork** the repository
2. **Create a feature branch**: `git checkout -b feature/my-feature`
3. **Commit changes**: `git commit -m 'Add my feature'`
4. **Push to branch**: `git push origin feature/my-feature`
5. **Open a Pull Request**

### Guidelines

- Follow existing code style (Dart's `flutter_lints` recommendations)
- Run `flutter analyze` before committing
- Format code with `dart format .`
- Update the README if adding new features
- Add tests for new functionality where possible
- Keep the `WalletService` singleton as the single source of truth

### Development Workflow

```bash
# Create feature branch
git checkout -b feature/my-feature

# Make changes, then verify
flutter analyze
dart format .
flutter test

# Commit
git add .
git commit -m "Description of changes"

# Push
git push origin feature/my-feature
```

---

## License

This project is for **educational and demonstration purposes only**. All data is simulated. No real financial transactions occur.

---

## Disclaimer

**PayNow is a simulation / demo application.** It does not connect to any real banking system, payment gateway, brokerage, or financial institution. All balances, stock prices, cryptocurrency rates, credit scores, and transactions are mock data generated in-memory.

The stock and cryptocurrency prices shown are randomized on each app launch and do not reflect real market data. Any resemblance to real financial products, services, or companies is purely coincidental.

**Do not use this application for real financial transactions, investments, or banking.** The developers assume no responsibility for any financial decisions made based on this application.

---

<p align="center">
  Made with Flutter<br>
  <sub>Smart Payments, Simplified</sub>
</p>
