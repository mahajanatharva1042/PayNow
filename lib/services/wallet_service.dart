import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String type;
  final String fromTo;
  final double amount;
  final DateTime date;
  final String status;
  final String category;
  String note;

  Transaction({
    required this.id,
    required this.type,
    required this.fromTo,
    required this.amount,
    DateTime? date,
    this.status = 'Success',
    this.category = 'Transfer',
    this.note = '',
  }) : date = date ?? DateTime.now();
}

class SavingGoal {
  final String id;
  final String title;
  final double targetAmount;
  double savedAmount;
  final DateTime createdAt;
  SavingGoal({required this.id, required this.title, required this.targetAmount, this.savedAmount = 0, DateTime? createdAt})
      : createdAt = createdAt ?? DateTime.now();
  double get progress => targetAmount > 0 ? (savedAmount / targetAmount).clamp(0, 1) : 0;
}

class PaymentRequest {
  final String id;
  final String from;
  final String to;
  final double amount;
  final String note;
  final DateTime date;
  bool isPaid;
  PaymentRequest({required this.id, required this.from, required this.to, required this.amount, this.note = '', DateTime? date, this.isPaid = false})
      : date = date ?? DateTime.now();
}

class GiftCard {
  final String id;
  final String to;
  final double amount;
  final String message;
  final DateTime date;
  bool isRedeemed;
  GiftCard({required this.id, required this.to, required this.amount, this.message = '', DateTime? date, this.isRedeemed = false}) : date = date ?? DateTime.now();
}

class SupportTicket {
  final String id;
  final String subject;
  final String message;
  final DateTime date;
  String status;
  String response;
  SupportTicket({required this.id, required this.subject, required this.message, DateTime? date, this.status = 'Open', this.response = ''})
      : date = date ?? DateTime.now();
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  bool isUnlocked;
  Achievement({required this.id, required this.title, required this.description, required this.icon, this.isUnlocked = false});
}

class RecurringPayment {
  final String id;
  final String to;
  final double amount;
  final String frequency;
  final String label;
  bool isActive;
  RecurringPayment({required this.id, required this.to, required this.amount, required this.frequency, this.label = '', this.isActive = true});
}

class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime date;
  bool isRead;
  AppNotification({required this.id, required this.title, required this.body, DateTime? date, this.isRead = false}) : date = date ?? DateTime.now();
}

class LoanApplication {
  final String id;
  final double amount;
  final int tenureMonths;
  final String purpose;
  final DateTime date;
  String status;
  LoanApplication({required this.id, required this.amount, required this.tenureMonths, required this.purpose, DateTime? date, this.status = 'Pending'})
      : date = date ?? DateTime.now();
}

class Investment {
  final String id;
  final String name;
  final String type;
  final double investedAmount;
  final double currentValue;
  final DateTime date;
  Investment({required this.id, required this.name, required this.type, required this.investedAmount, required this.currentValue, DateTime? date})
      : date = date ?? DateTime.now();
  double get returns => currentValue - investedAmount;
  double get returnsPercent => investedAmount > 0 ? (returns / investedAmount * 100) : 0;
}

class PaymentReminder {
  final String id;
  final String title;
  final double amount;
  final DateTime dueDate;
  bool isPaid;
  PaymentReminder({required this.id, required this.title, required this.amount, required this.dueDate, this.isPaid = false});
}

class Subscription {
  final String id;
  final String name;
  final double amount;
  final String frequency;
  final String category;
  bool isActive;
  Subscription({required this.id, required this.name, required this.amount, required this.frequency, this.category = 'Other', this.isActive = true});
}

class BnplOrder {
  final String id;
  final String merchant;
  final double totalAmount;
  final double paidAmount;
  final int totalInstallments;
  final int paidInstallments;
  final DateTime date;
  BnplOrder({required this.id, required this.merchant, required this.totalAmount, required this.totalInstallments, this.paidAmount = 0, this.paidInstallments = 0, DateTime? date})
      : date = date ?? DateTime.now();
  double get remainingAmount => totalAmount - paidAmount;
  double get installmentAmount => totalAmount / totalInstallments;
  bool get isComplete => paidInstallments >= totalInstallments;
}

class Stock {
  final String id;
  final String symbol;
  final String name;
  double buyPrice;
  int quantity;
  Stock({required this.id, required this.symbol, required this.name, required this.buyPrice, this.quantity = 0});
  double get currentValue => buyPrice * quantity;
}

class Asset {
  final String id;
  final String name;
  final String category;
  double value;
  Asset({required this.id, required this.name, required this.category, required this.value});
}

class Liability {
  final String id;
  final String name;
  final String category;
  double amount;
  Liability({required this.id, required this.name, required this.category, required this.amount});
}

class CryptoHolding {
  final String id;
  final String symbol;
  final String name;
  double buyPrice;
  double quantity;
  CryptoHolding({required this.id, required this.symbol, required this.name, required this.buyPrice, this.quantity = 0});
  double get currentValue => buyPrice * quantity;
}

class InsurancePolicy {
  final String id;
  final String type;
  final String provider;
  final double premium;
  final double coverage;
  final String tenure;
  bool isActive;
  InsurancePolicy({required this.id, required this.type, required this.provider, required this.premium, required this.coverage, required this.tenure, this.isActive = true});
}

class WalletService extends ChangeNotifier {
  static final WalletService _instance = WalletService._internal();
  factory WalletService() => _instance;
  WalletService._internal();

  double _balance = 5000.0;
  String? _pin;
  final List<Transaction> _transactions = [];
  String _username = 'Admin';
  int _rewardPoints = 0;
  final List<SavingGoal> _savingsGoals = [];
  final List<String> _favorites = [];
  final List<PaymentRequest> _paymentRequests = [];
  bool _isDarkMode = false;

  final String _upiId = 'admin@paykaro';
  String _referralCode = 'PAYKARO_ADMIN';
  int _referralCount = 0;
  final Map<String, double> _budgets = {};
  final List<GiftCard> _giftCards = [];
  final List<SupportTicket> _supportTickets = [];
  final List<Achievement> _achievements = [];
  final List<RecurringPayment> _recurringPayments = [];
  int _transactionCount = 0;

  // NEW feature data
  final List<AppNotification> _notifications = [];
  final List<LoanApplication> _loanApplications = [];
  final List<Investment> _investments = [];
  final List<PaymentReminder> _reminders = [];
  DateTime _lastCheckin = DateTime(2000);
  int _checkinStreak = 0;
  final List<Subscription> _subscriptions = [];
  final List<BnplOrder> _bnplOrders = [];
  final List<InsurancePolicy> _insurancePolicies = [];
  final List<Stock> _stocks = [];
  final List<Asset> _assets = [];
  final List<Liability> _liabilities = [];
  final List<CryptoHolding> _cryptoHoldings = [];
  final Map<String, double> _stockPrices = {
    'RELIANCE': 2850, 'TCS': 3950, 'HDFC': 1650, 'INFY': 1480, 'ITC': 440,
    'SBIN': 780, 'BHARTI': 1250, 'WIPRO': 510, 'TATASTEEL': 135, 'HINDUNILVR': 2680,
  };
  final Map<String, double> _cryptoPrices = {
    'BTC': 5200000, 'ETH': 310000, 'BNB': 58000, 'SOL': 14000, 'XRP': 75,
  };
  int _stockMarketDay = 0;

  // Getters
  double get balance => _balance;
  String? get pin => _pin;
  bool get hasPin => _pin != null;
  List<Transaction> get transactions => List.unmodifiable(_transactions);
  String get username => _username;
  int get rewardPoints => _rewardPoints;
  List<SavingGoal> get savingsGoals => List.unmodifiable(_savingsGoals);
  List<String> get favorites => List.unmodifiable(_favorites);
  List<PaymentRequest> get paymentRequests => List.unmodifiable(_paymentRequests);
  bool get isDarkMode => _isDarkMode;
  String get upiId => _upiId;
  String get referralCode => _referralCode;
  int get referralCount => _referralCount;
  Map<String, double> get budgets => Map.unmodifiable(_budgets);
  List<GiftCard> get giftCards => List.unmodifiable(_giftCards);
  List<SupportTicket> get supportTickets => List.unmodifiable(_supportTickets);
  List<Achievement> get achievements => List.unmodifiable(_achievements);
  List<RecurringPayment> get recurringPayments => List.unmodifiable(_recurringPayments);
  int get transactionCount => _transactionCount;
  double get cashbackValue => _rewardPoints * 0.5;
  List<AppNotification> get notifications => List.unmodifiable(_notifications);
  List<LoanApplication> get loanApplications => List.unmodifiable(_loanApplications);
  List<Investment> get investments => List.unmodifiable(_investments);
  List<PaymentReminder> get reminders => List.unmodifiable(_reminders);
  DateTime get lastCheckin => _lastCheckin;
  int get checkinStreak => _checkinStreak;
  int get unreadNotificationCount => _notifications.where((n) => !n.isRead).length;
  List<Subscription> get subscriptions => List.unmodifiable(_subscriptions);
  List<BnplOrder> get bnplOrders => List.unmodifiable(_bnplOrders);
  List<InsurancePolicy> get insurancePolicies => List.unmodifiable(_insurancePolicies);
  List<Stock> get stocks => List.unmodifiable(_stocks);
  List<Asset> get assets => List.unmodifiable(_assets);
  List<Liability> get liabilities => List.unmodifiable(_liabilities);
  List<CryptoHolding> get cryptoHoldings => List.unmodifiable(_cryptoHoldings);
  Map<String, double> get stockPrices => Map.unmodifiable(_stockPrices);
  Map<String, double> get cryptoPrices => Map.unmodifiable(_cryptoPrices);
  int get stockMarketDay => _stockMarketDay;
  double get totalAssets => _assets.fold(0.0, (s, a) => s + a.value) + _balance + totalInvestmentValue + _cryptoHoldings.fold(0.0, (s, c) => s + c.currentValue);
  double get totalLiabilities => _liabilities.fold(0.0, (s, l) => s + l.amount);
  double get netWorth => totalAssets - totalLiabilities;
  double get totalSubscriptionMonthly => _subscriptions.where((s) => s.isActive).fold(0.0, (sum, s) => sum + (s.frequency == 'Monthly' ? s.amount : s.frequency == 'Yearly' ? s.amount / 12 : s.amount));

  void _addNotification(String title, String body) {
    _notifications.insert(0, AppNotification(id: DateTime.now().millisecondsSinceEpoch.toString(), title: title, body: body));
  }

  void markNotificationRead(int index) {
    if (index >= 0 && index < _notifications.length) { _notifications[index].isRead = true; notifyListeners(); }
  }

  void markAllRead() { for (final n in _notifications) n.isRead = true; notifyListeners(); }

  String applyForLoan(double amount, int tenure, String purpose) {
    if (amount <= 0) return 'Invalid amount';
    if (tenure < 1) return 'Invalid tenure';
    _loanApplications.add(LoanApplication(id: DateTime.now().millisecondsSinceEpoch.toString(), amount: amount, tenureMonths: tenure, purpose: purpose));
    _addNotification('Loan Application Submitted', '₹${amount.toStringAsFixed(0)} loan for $purpose is under review');
    notifyListeners();
    return 'Success';
  }

  void approveLoan(int index) {
    if (index >= 0 && index < _loanApplications.length) {
      _loanApplications[index].status = 'Approved';
      _balance += _loanApplications[index].amount;
      _addNotification('Loan Approved', '₹${_loanApplications[index].amount.toStringAsFixed(0)} loan credited to your wallet');
      _transactions.insert(0, Transaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'Credit', fromTo: 'Loan Approved', amount: _loanApplications[index].amount, category: 'Loan'));
      notifyListeners();
    }
  }

  void rejectLoan(int index) {
    if (index >= 0 && index < _loanApplications.length) { _loanApplications[index].status = 'Rejected'; notifyListeners(); }
  }

  String addInvestment(String name, String type, double amount) {
    if (amount <= 0) return 'Invalid amount';
    if (amount > _balance) return 'Insufficient balance';
    _balance -= amount;
    final returns = amount * (0.05 + (DateTime.now().millisecondsSinceEpoch % 15) / 100);
    _investments.add(Investment(id: DateTime.now().millisecondsSinceEpoch.toString(), name: name, type: type, investedAmount: amount, currentValue: amount + returns));
    _addNotification('Investment Made', '₹${amount.toStringAsFixed(0)} invested in $name');
    _transactions.insert(0, Transaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'Debit', fromTo: 'Investment: $name', amount: amount, category: 'Investment'));
    notifyListeners();
    return 'Success';
  }

  String addReminder(String title, double amount, DateTime dueDate) {
    if (title.isEmpty) return 'Enter title';
    if (amount <= 0) return 'Enter valid amount';
    _reminders.add(PaymentReminder(id: DateTime.now().millisecondsSinceEpoch.toString(), title: title, amount: amount, dueDate: dueDate));
    notifyListeners();
    return 'Success';
  }

  void markReminderPaid(int index) {
    if (index >= 0 && index < _reminders.length) { _reminders[index].isPaid = true; notifyListeners(); }
  }

  String dailyCheckin() {
    final now = DateTime.now();
    final last = _lastCheckin;
    if (now.year == last.year && now.month == last.month && now.day == last.day) return 'Already checked in today';
    final yesterday = now.subtract(const Duration(days: 1));
    if (yesterday.year == last.year && yesterday.month == last.month && yesterday.day == last.day) {
      _checkinStreak++;
    } else {
      _checkinStreak = 1;
    }
    _lastCheckin = now;
    final bonus = 10 + (_checkinStreak * 2);
    _rewardPoints += bonus;
    _addNotification('Daily Check-in', 'Day $_checkinStreak streak! Earned $bonus reward points');
    notifyListeners();
    return 'Checked in! Day $_checkinStreak streak, +$bonus points';
  }

  // Existing methods
  void _initAchievements() {
    if (_achievements.isNotEmpty) return;
    _achievements.addAll([
      Achievement(id: 'first_txn', title: 'First Transaction', description: 'Make your first payment', icon: Icons.send, isUnlocked: _transactionCount >= 1),
      Achievement(id: 'five_txn', title: 'Regular User', description: 'Complete 5 transactions', icon: Icons.star, isUnlocked: _transactionCount >= 5),
      Achievement(id: 'ten_txn', title: 'Power User', description: 'Complete 10 transactions', icon: Icons.bolt, isUnlocked: _transactionCount >= 10),
      Achievement(id: 'first_goal', title: 'Goal Setter', description: 'Create a savings goal', icon: Icons.flag, isUnlocked: _savingsGoals.isNotEmpty),
      Achievement(id: 'first_add', title: 'First Deposit', description: 'Add money to wallet', icon: Icons.add_circle, isUnlocked: false),
      Achievement(id: 'friend', title: 'Social', description: 'Add a favorite contact', icon: Icons.people, isUnlocked: _favorites.isNotEmpty),
      Achievement(id: 'saver', title: 'Saver', description: 'Save ₹1000 in goals', icon: Icons.savings, isUnlocked: false),
      Achievement(id: 'spender', title: 'Big Spender', description: 'Spend over ₹5000 total', icon: Icons.trending_up, isUnlocked: false),
      Achievement(id: 'lucky', title: 'Lucky Draw', description: 'Earn 100 reward points', icon: Icons.card_giftcard, isUnlocked: _rewardPoints >= 100),
      Achievement(id: 'investor', title: 'Investor', description: 'Make your first investment', icon: Icons.trending_up, isUnlocked: false),
      Achievement(id: 'loan', title: 'Borrower', description: 'Get a loan approved', icon: Icons.account_balance, isUnlocked: false),
      Achievement(id: 'streak_7', title: 'Weekly Streak', description: 'Check in 7 days in a row', icon: Icons.local_fire_department, isUnlocked: false),
      Achievement(id: 'streak_30', title: 'Monthly Streak', description: 'Check in 30 days in a row', icon: Icons.whatshot, isUnlocked: false),
    ]);
  }

  void _checkAchievements() {
    _initAchievements();
    for (final a in _achievements) {
      if (a.isUnlocked) continue;
      switch (a.id) {
        case 'first_txn': a.isUnlocked = _transactionCount >= 1; break;
        case 'five_txn': a.isUnlocked = _transactionCount >= 5; break;
        case 'ten_txn': a.isUnlocked = _transactionCount >= 10; break;
        case 'first_goal': a.isUnlocked = _savingsGoals.isNotEmpty; break;
        case 'first_add': a.isUnlocked = _transactions.any((t) => t.category == 'Deposit'); break;
        case 'friend': a.isUnlocked = _favorites.isNotEmpty; break;
        case 'saver': a.isUnlocked = _savingsGoals.fold(0.0, (s, g) => s + g.savedAmount) >= 1000; break;
        case 'spender': a.isUnlocked = totalSpent >= 5000; break;
        case 'lucky': a.isUnlocked = _rewardPoints >= 100; break;
        case 'investor': a.isUnlocked = _investments.isNotEmpty; break;
        case 'loan': a.isUnlocked = _loanApplications.any((l) => l.status == 'Approved'); break;
        case 'streak_7': a.isUnlocked = _checkinStreak >= 7; break;
        case 'streak_30': a.isUnlocked = _checkinStreak >= 30; break;
      }
    }
    notifyListeners();
  }

  void setUsername(String name) { _username = name; notifyListeners(); }
  void setPin(String newPin) { _pin = newPin; notifyListeners(); }
  bool verifyPin(String input) => _pin == input;
  void toggleDarkMode() { _isDarkMode = !_isDarkMode; notifyListeners(); }
  void setDarkMode(bool val) { _isDarkMode = val; notifyListeners(); }

  bool addMoney(double amount) {
    if (amount <= 0) return false;
    _balance += amount;
    _transactions.insert(0, Transaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'Credit', fromTo: 'Self (Add Money)', amount: amount, category: 'Deposit'));
    _checkAchievements();
    notifyListeners();
    return true;
  }

  String sendMoney(String to, double amount) {
    if (amount <= 0) return 'Invalid amount';
    if (amount > _balance) return 'Insufficient balance';
    _balance -= amount;
    _transactionCount++;
    final cashback = (amount * 0.01).floor();
    if (cashback > 0) _rewardPoints += cashback;
    _transactions.insert(0, Transaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'Debit', fromTo: to, amount: amount, category: 'Payment'));
    _addNotification('Payment Sent', '₹${amount.toStringAsFixed(0)} sent to $to');
    _checkAchievements();
    notifyListeners();
    return 'Success';
  }

  void receiveMoney(String from, double amount) {
    _balance += amount;
    _transactionCount++;
    _transactions.insert(0, Transaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'Credit', fromTo: from, amount: amount, category: 'Payment'));
    _addNotification('Payment Received', '₹${amount.toStringAsFixed(0)} received from $from');
    _checkAchievements();
    notifyListeners();
  }

  String redeemCashback() {
    if (_rewardPoints < 100) return 'Need at least 100 points';
    final redeemValue = (_rewardPoints ~/ 100) * 50;
    final pointsUsed = (_rewardPoints ~/ 100) * 100;
    _rewardPoints -= pointsUsed;
    _balance += redeemValue;
    _transactions.insert(0, Transaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'Credit', fromTo: 'Cashback Redeemed', amount: redeemValue.toDouble(), category: 'Rewards'));
    notifyListeners();
    return 'Redeemed ₹$redeemValue';
  }

  String addSavingGoal(String title, double target) {
    if (title.isEmpty) return 'Enter a title';
    if (target <= 0) return 'Enter valid target';
    _savingsGoals.add(SavingGoal(id: DateTime.now().millisecondsSinceEpoch.toString(), title: title, targetAmount: target));
    _checkAchievements();
    notifyListeners();
    return 'Success';
  }

  String contributeToGoal(String goalId, double amount) {
    if (amount <= 0) return 'Invalid amount';
    if (amount > _balance) return 'Insufficient balance';
    final goal = _savingsGoals.where((g) => g.id == goalId).firstOrNull;
    if (goal == null) return 'Goal not found';
    _balance -= amount;
    goal.savedAmount += amount;
    _transactions.insert(0, Transaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'Debit', fromTo: 'Goal: ${goal.title}', amount: amount, category: 'Savings'));
    _checkAchievements();
    notifyListeners();
    return 'Success';
  }

  void toggleFavorite(String name) { if (_favorites.contains(name)) _favorites.remove(name); else _favorites.add(name); _checkAchievements(); notifyListeners(); }
  bool isFavorite(String name) => _favorites.contains(name);

  String createRequest(String to, double amount, String note) {
    if (amount <= 0) return 'Invalid amount';
    _paymentRequests.add(PaymentRequest(id: DateTime.now().millisecondsSinceEpoch.toString(), from: _username, to: to, amount: amount, note: note));
    notifyListeners();
    return 'Success';
  }

  String payRequest(int index) {
    if (index < 0 || index >= _paymentRequests.length) return 'Not found';
    final req = _paymentRequests[index];
    if (req.isPaid) return 'Already paid';
    if (_balance < req.amount) return 'Insufficient balance';
    _balance -= req.amount;
    req.isPaid = true;
    _transactions.insert(0, Transaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'Debit', fromTo: req.from, amount: req.amount, category: 'Request'));
    notifyListeners();
    return 'Success';
  }

  List<MapEntry<String, double>> get spendingByCategory {
    final map = <String, double>{};
    for (final t in _transactions) { if (t.type == 'Debit') map[t.category] = (map[t.category] ?? 0) + t.amount; }
    return map.entries.toList();
  }

  double get totalSpent { double s = 0; for (final t in _transactions) { if (t.type == 'Debit') s += t.amount; } return s; }

  String applyReferral(String code) { if (code == _referralCode) { _balance += 200; _referralCount++; _addNotification('Referral Bonus', '₹200 bonus from referral'); return 'Success'; } return 'Invalid referral code'; }

  void setBudget(String category, double amount) { _budgets[category] = amount; notifyListeners(); }
  void removeBudget(String category) { _budgets.remove(category); notifyListeners(); }
  double get spentThisMonth { final now = DateTime.now(); double s = 0; for (final t in _transactions) { if (t.type == 'Debit' && t.date.month == now.month && t.date.year == now.year) s += t.amount; } return s; }
  double budgetFor(String category) => _budgets[category] ?? 0;

  String sendGiftCard(String to, double amount, String message) {
    if (amount <= 0) return 'Invalid amount';
    if (amount > _balance) return 'Insufficient balance';
    _balance -= amount;
    _giftCards.add(GiftCard(id: DateTime.now().millisecondsSinceEpoch.toString(), to: to, amount: amount, message: message));
    _transactions.insert(0, Transaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'Debit', fromTo: 'Gift: $to', amount: amount, category: 'Gift'));
    notifyListeners();
    return 'Success';
  }

  String createTicket(String subject, String message) {
    if (subject.isEmpty || message.isEmpty) return 'Fill all fields';
    _supportTickets.add(SupportTicket(id: DateTime.now().millisecondsSinceEpoch.toString(), subject: subject, message: message));
    notifyListeners();
    return 'Success';
  }
  void resolveTicket(int index, String response) { if (index >= 0 && index < _supportTickets.length) { _supportTickets[index].status = 'Resolved'; _supportTickets[index].response = response; notifyListeners(); } }

  String addRecurring(String to, double amount, String frequency, String label) {
    if (amount <= 0) return 'Invalid amount';
    _recurringPayments.add(RecurringPayment(id: DateTime.now().millisecondsSinceEpoch.toString(), to: to, amount: amount, frequency: frequency, label: label));
    notifyListeners();
    return 'Success';
  }
  void toggleRecurring(int index) { if (index >= 0 && index < _recurringPayments.length) { _recurringPayments[index].isActive = !_recurringPayments[index].isActive; notifyListeners(); } }

  void setReferralCode(String code) { _referralCode = code; notifyListeners(); }
  String get qrData => 'upi://pay?pa=$_upiId&pn=$_username';

  double usdRate = 0.012, eurRate = 0.011, gbpRate = 0.0095, jpyRate = 1.82, aedRate = 0.044;
  double convertToINR(double amount, String c) { switch (c) { case 'USD': return amount / usdRate; case 'EUR': return amount / eurRate; case 'GBP': return amount / gbpRate; case 'JPY': return amount / jpyRate; case 'AED': return amount / aedRate; default: return amount; } }
  double convertFromINR(double amount, String c) { switch (c) { case 'USD': return amount * usdRate; case 'EUR': return amount * eurRate; case 'GBP': return amount * gbpRate; case 'JPY': return amount * jpyRate; case 'AED': return amount * aedRate; default: return amount; } }

  void updateTransactionNote(int index, String note) { if (index >= 0 && index < _transactions.length) { _transactions[index].note = note; notifyListeners(); } }

  List<Transaction> searchTransactions(String query) {
    if (query.isEmpty) return transactions;
    final q = query.toLowerCase();
    return _transactions.where((t) =>
      t.fromTo.toLowerCase().contains(q) ||
      t.category.toLowerCase().contains(q) ||
      t.type.toLowerCase().contains(q) ||
      t.note.toLowerCase().contains(q) ||
      t.amount.toString().contains(q)
    ).toList();
  }

  double get totalInvested => _investments.fold(0.0, (s, i) => s + i.investedAmount);
  double get totalInvestmentValue => _investments.fold(0.0, (s, i) => s + i.currentValue);
  double get investmentReturns => totalInvestmentValue - totalInvested;

  String addSubscription(String name, double amount, String frequency, String category) {
    if (name.isEmpty || amount <= 0) return 'Invalid details';
    _subscriptions.add(Subscription(id: DateTime.now().millisecondsSinceEpoch.toString(), name: name, amount: amount, frequency: frequency, category: category));
    _addNotification('Subscription Added', '$name - ₹${amount.toStringAsFixed(0)}/$frequency');
    notifyListeners();
    return 'Success';
  }
  void toggleSubscription(int index) { if (index >= 0 && index < _subscriptions.length) { _subscriptions[index].isActive = !_subscriptions[index].isActive; notifyListeners(); } }
  void removeSubscription(int index) { if (index >= 0 && index < _subscriptions.length) { _subscriptions.removeAt(index); notifyListeners(); } }

  String createBnplOrder(String merchant, double amount, int installments) {
    if (amount <= 0 || installments < 1) return 'Invalid details';
    _bnplOrders.add(BnplOrder(id: DateTime.now().millisecondsSinceEpoch.toString(), merchant: merchant, totalAmount: amount, totalInstallments: installments));
    _balance += amount;
    _addNotification('BNPL Order Created', '₹${amount.toStringAsFixed(0)} at $merchant - $installments installments');
    _transactions.insert(0, Transaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'Credit', fromTo: 'BNPL: $merchant', amount: amount, category: 'BNPL'));
    notifyListeners();
    return 'Success';
  }
  String payBnplInstallment(int index) {
    if (index < 0 || index >= _bnplOrders.length) return 'Not found';
    final order = _bnplOrders[index];
    if (order.isComplete) return 'Already paid';
    final instAmt = order.installmentAmount;
    if (instAmt > _balance) return 'Insufficient balance';
    _balance -= instAmt;
    order.paidInstallments++;
    _transactions.insert(0, Transaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'Debit', fromTo: 'BNPL: ${order.merchant}', amount: instAmt, category: 'BNPL'));
    if (order.isComplete) _addNotification('BNPL Completed', '${order.merchant} - all installments paid');
    notifyListeners();
    return 'Paid ₹${instAmt.toStringAsFixed(0)}';
  }

  String buyInsurance(String type, String provider, double premium, double coverage, String tenure) {
    if (premium <= 0 || coverage <= 0) return 'Invalid details';
    if (premium > _balance) return 'Insufficient balance';
    _balance -= premium;
    _insurancePolicies.add(InsurancePolicy(id: DateTime.now().millisecondsSinceEpoch.toString(), type: type, provider: provider, premium: premium, coverage: coverage, tenure: tenure));
    _addNotification('Insurance Purchased', '$type policy from $provider');
    _transactions.insert(0, Transaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'Debit', fromTo: 'Insurance: $provider', amount: premium, category: 'Insurance'));
    notifyListeners();
    return 'Success';
  }

  double fdMaturity(double principal, double rate, int years, int compoundPerYear) {
    // A = P(1 + r/n)^(nt)
    double amount = principal;
    for (int i = 0; i < years * compoundPerYear; i++) {
      amount *= (1 + rate / 100 / compoundPerYear);
    }
    return amount;
  }

  double rdMaturity(double monthly, double rate, int years) {
    // M = R * ((1+i)^n - 1) / (1 - (1+i)^(-1/3))
    final n = years * 12;
    final i = rate / 100 / 12;
    double sum = 0;
    for (int m = 1; m <= n; m++) {
      sum += monthly * (1 + i);
    }
    // Simplified: M = P * n + P * (n(n+1)/2) * (r/12/100)
    final total = monthly * n + monthly * (n * (n + 1) / 2) * (rate / 12 / 100);
    return total;
  }

  double gstExclusive(double amount, double rate) => amount * rate / 100;
  double gstInclusive(double amount, double rate) => amount - (amount * 100 / (100 + rate));

  // Stock Trading
  void simulateStockMarket() {
    _stockMarketDay++;
    final random = DateTime.now().millisecondsSinceEpoch % 100;
    for (final symbol in _stockPrices.keys.toList()) {
      final change = (random % 11 - 5) / 100;
      _stockPrices[symbol] = (_stockPrices[symbol]! * (1 + change)).roundToDouble();
      if (_stockPrices[symbol]! < 10) _stockPrices[symbol] = 10;
    }
    for (final symbol in _cryptoPrices.keys.toList()) {
      final change = (random % 21 - 10) / 100;
      _cryptoPrices[symbol] = (_cryptoPrices[symbol]! * (1 + change));
      if (_cryptoPrices[symbol]! < 10) _cryptoPrices[symbol] = 10;
    }
    for (final s in _stocks) {
      s.buyPrice = _stockPrices[s.symbol] ?? s.buyPrice;
    }
    for (final c in _cryptoHoldings) {
      c.buyPrice = _cryptoPrices[c.symbol] ?? c.buyPrice;
    }
    notifyListeners();
  }

  String buyStock(String symbol, int quantity) {
    final price = _stockPrices[symbol];
    if (price == null) return 'Stock not found';
    if (quantity <= 0) return 'Invalid quantity';
    final cost = price * quantity;
    if (cost > _balance) return 'Insufficient balance';
    _balance -= cost;
    final existing = _stocks.where((s) => s.symbol == symbol).firstOrNull;
    if (existing != null) {
      existing.quantity += quantity;
    } else {
      _stocks.add(Stock(id: DateTime.now().millisecondsSinceEpoch.toString(), symbol: symbol, name: symbol, buyPrice: price, quantity: quantity));
    }
    _transactions.insert(0, Transaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'Debit', fromTo: 'Stock: $symbol', amount: cost, category: 'Stocks'));
    _addNotification('Stock Bought', '$quantity shares of $symbol at ₹$price');
    notifyListeners();
    return 'Success';
  }

  String sellStock(String symbol, int quantity) {
    final existing = _stocks.where((s) => s.symbol == symbol).firstOrNull;
    if (existing == null) return 'No holdings';
    if (quantity <= 0 || quantity > existing.quantity) return 'Invalid quantity';
    final price = _stockPrices[symbol] ?? existing.buyPrice;
    final value = price * quantity;
    _balance += value;
    existing.quantity -= quantity;
    if (existing.quantity <= 0) _stocks.remove(existing);
    _transactions.insert(0, Transaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'Credit', fromTo: 'Stock: $symbol', amount: value, category: 'Stocks'));
    _addNotification('Stock Sold', '$quantity shares of $symbol at ₹$price');
    notifyListeners();
    return 'Success';
  }

  double stockValue(String symbol) => (_stockPrices[symbol] ?? 0) * (_stocks.where((s) => s.symbol == symbol).fold(0, (sum, s) => sum + s.quantity));
  double get totalStockValue => _stocks.fold(0.0, (s, st) => s + st.currentValue);
  double stockPL(String symbol) {
    final s = _stocks.where((st) => st.symbol == symbol).firstOrNull;
    if (s == null) return 0;
    return (stockPrices[symbol]! - s.buyPrice) * s.quantity;
  }

  // Crypto Trading
  String buyCrypto(String symbol, double quantity) {
    final price = _cryptoPrices[symbol];
    if (price == null) return 'Crypto not found';
    if (quantity <= 0) return 'Invalid quantity';
    final cost = price * quantity;
    if (cost > _balance) return 'Insufficient balance';
    _balance -= cost;
    final existing = _cryptoHoldings.where((c) => c.symbol == symbol).firstOrNull;
    if (existing != null) {
      existing.quantity += quantity;
    } else {
      _cryptoHoldings.add(CryptoHolding(id: DateTime.now().millisecondsSinceEpoch.toString(), symbol: symbol, name: symbol, buyPrice: price, quantity: quantity));
    }
    _transactions.insert(0, Transaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'Debit', fromTo: 'Crypto: $symbol', amount: cost, category: 'Crypto'));
    _addNotification('Crypto Bought', '$quantity $symbol at ₹$price');
    notifyListeners();
    return 'Success';
  }

  String sellCrypto(String symbol, double quantity) {
    final existing = _cryptoHoldings.where((c) => c.symbol == symbol).firstOrNull;
    if (existing == null) return 'No holdings';
    if (quantity <= 0 || quantity > existing.quantity) return 'Invalid quantity';
    final price = _cryptoPrices[symbol] ?? existing.buyPrice;
    final value = price * quantity;
    _balance += value;
    existing.quantity -= quantity;
    if (existing.quantity <= 0) _cryptoHoldings.remove(existing);
    _transactions.insert(0, Transaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'Credit', fromTo: 'Crypto: $symbol', amount: value, category: 'Crypto'));
    _addNotification('Crypto Sold', '$quantity $symbol at ₹$price');
    notifyListeners();
    return 'Success';
  }

  // Income Tax Calculator
  double taxOldRegime(double income) {
    if (income <= 250000) return 0;
    if (income <= 500000) return (income - 250000) * 0.05;
    if (income <= 1000000) return 12500 + (income - 500000) * 0.2;
    return 12500 + 100000 + (income - 1000000) * 0.3;
  }

  double taxNewRegime(double income) {
    if (income <= 400000) return 0;
    if (income <= 800000) return (income - 400000) * 0.05;
    if (income <= 1200000) return 20000 + (income - 800000) * 0.1;
    if (income <= 1600000) return 60000 + (income - 1200000) * 0.15;
    if (income <= 2000000) return 120000 + (income - 1600000) * 0.2;
    if (income <= 2400000) return 200000 + (income - 2000000) * 0.25;
    return 300000 + (income - 2400000) * 0.3;
  }

  double taxWithDeductions(double income, double deductions) {
    final taxable = (income - deductions).clamp(0, income);
    return taxOldRegime(taxable);
  }

  // Retirement Planner
  double retirementCorpus(double currentAge, double retirementAge, double monthlyExpense, double inflation, double returnRate) {
    final yearsToRetirement = retirementAge - currentAge;
    final yearsInRetirement = 85 - retirementAge;
    final monthlyAtRetirement = monthlyExpense * _pow(1 + inflation / 100, yearsToRetirement);
    final annualAtRetirement = monthlyAtRetirement * 12;
    double corpus = 0;
    for (int y = 0; y < yearsInRetirement; y++) {
      corpus += annualAtRetirement * _pow(1 + inflation / 100, y) / _pow(1 + returnRate / 100, y);
    }
    return corpus;
  }

  double monthlySIPforRetirement(double targetCorpus, double years, double returnRate) {
    final months = years * 12;
    final monthlyRate = returnRate / 12 / 100;
    if (monthlyRate <= 0) return targetCorpus / months;
    return targetCorpus * monthlyRate / (_pow(1 + monthlyRate, months) - 1);
  }

  double _pow(double base, int exp) {
    double result = 1;
    for (int i = 0; i < exp; i++) result *= base;
    return result;
  }

  // Net Worth Tracker
  String addAsset(String name, String category, double value) {
    if (name.isEmpty || value <= 0) return 'Invalid details';
    _assets.add(Asset(id: DateTime.now().millisecondsSinceEpoch.toString(), name: name, category: category, value: value));
    _addNotification('Asset Added', '$name worth ₹${value.toStringAsFixed(0)}');
    notifyListeners();
    return 'Success';
  }

  void updateAssetValue(int index, double newValue) {
    if (index >= 0 && index < _assets.length) { _assets[index].value = newValue; notifyListeners(); }
  }

  void removeAsset(int index) { if (index >= 0 && index < _assets.length) { _assets.removeAt(index); notifyListeners(); } }

  String addLiability(String name, String category, double amount) {
    if (name.isEmpty || amount <= 0) return 'Invalid details';
    _liabilities.add(Liability(id: DateTime.now().millisecondsSinceEpoch.toString(), name: name, category: category, amount: amount));
    _addNotification('Liability Added', '$name of ₹${amount.toStringAsFixed(0)}');
    notifyListeners();
    return 'Success';
  }

  void updateLiabilityAmount(int index, double newAmount) {
    if (index >= 0 && index < _liabilities.length) { _liabilities[index].amount = newAmount; notifyListeners(); }
  }

  void removeLiability(int index) { if (index >= 0 && index < _liabilities.length) { _liabilities.removeAt(index); notifyListeners(); } }

  // Mutual Fund Calculator
  double sipMaturity(double monthly, double rate, int years) {
    final months = years * 12;
    final monthlyRate = rate / 12 / 100;
    double total = 0;
    for (int m = 1; m <= months; m++) {
      total += monthly * _pow(1 + monthlyRate, m);
    }
    return total;
  }

  double lumpsumMaturity(double principal, double rate, int years) {
    return principal * _pow(1 + rate / 100, years);
  }

  // Monthly Report
  Map<String, dynamic> monthlyReport(int year, int month) {
    final txn = _transactions.where((t) => t.date.year == year && t.date.month == month).toList();
    double income = 0, expenses = 0;
    for (final t in txn) {
      if (t.type == 'Credit') income += t.amount;
      else expenses += t.amount;
    }
    final catSpend = <String, double>{};
    for (final t in txn.where((t) => t.type == 'Debit')) {
      catSpend[t.category] = (catSpend[t.category] ?? 0) + t.amount;
    }
    return {
      'year': year, 'month': month, 'transactions': txn.length,
      'income': income, 'expenses': expenses, 'net': income - expenses,
      'categories': catSpend, 'txnList': txn,
    };
  }

  // Loan Prepayment Calculator
  Map<String, double> loanPrepayment(double principal, double annualRate, int tenureMonths, double prepayAmount, int afterMonth) {
    final monthlyRate = annualRate / 12 / 100;
    final emi = principal * monthlyRate * _pow(1 + monthlyRate, tenureMonths) / (_pow(1 + monthlyRate, tenureMonths) - 1);
    double balance = principal;
    double totalInterest = 0;
    for (int m = 1; m <= tenureMonths; m++) {
      final interest = balance * monthlyRate;
      final principalPaid = emi - interest;
      totalInterest += interest;
      balance -= principalPaid;
      if (m == afterMonth) balance -= prepayAmount;
      if (balance <= 0) {
        final remainingMonths = tenureMonths - m;
        return {
          'originalEmi': emi, 'totalInterest': totalInterest,
          'monthsSaved': remainingMonths, 'interestSaved': 0,
          'newBalance': 0, 'newTenure': m,
        };
      }
    }
    return {
      'originalEmi': emi, 'totalInterest': totalInterest,
      'newBalance': balance, 'newTenure': tenureMonths,
    };
  }

  // Expense Categories - returns category-wise breakdown for current month
  Map<String, double> get categoryExpenses {
    final now = DateTime.now();
    final map = <String, double>{};
    for (final t in _transactions) {
      if (t.type == 'Debit' && t.date.month == now.month && t.date.year == now.year) {
        map[t.category] = (map[t.category] ?? 0) + t.amount;
      }
    }
    return map;
  }
}
