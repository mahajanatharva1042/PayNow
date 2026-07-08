import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:paykaro/services/wallet_service.dart';
import 'package:paykaro/BottomNavigationBar/Home.dart';
import 'package:paykaro/BottomNavigationBar/Search.dart';
import 'package:paykaro/BottomNavigationBar/Pay.dart';
import 'package:paykaro/BottomNavigationBar/Account.dart';
import 'package:paykaro/Drawer/History.dart';
import 'package:paykaro/Drawer/Customization.dart';
import 'package:paykaro/Drawer/Settting.dart';
import 'package:paykaro/logout.dart';
import 'package:paykaro/BottomNavigationBar/accountmenu.dart';
import 'package:paykaro/screens/rewards_screen.dart';
import 'package:paykaro/screens/savings_goals_screen.dart';
import 'package:paykaro/screens/request_money_screen.dart';
import 'package:paykaro/screens/bill_split_screen.dart';
import 'package:paykaro/screens/spending_analytics_screen.dart';
import 'package:paykaro/screens/upi_qr_screen.dart';
import 'package:paykaro/screens/refer_earn_screen.dart';
import 'package:paykaro/screens/emi_calculator_screen.dart';
import 'package:paykaro/screens/currency_converter_screen.dart';
import 'package:paykaro/screens/budget_planner_screen.dart';
import 'package:paykaro/screens/gift_cards_screen.dart';
import 'package:paykaro/screens/achievements_screen.dart';
import 'package:paykaro/screens/support_screen.dart';
import 'package:paykaro/screens/sip_calculator_screen.dart';
import 'package:paykaro/screens/loan_application_screen.dart';
import 'package:paykaro/screens/notifications_screen.dart';
import 'package:paykaro/screens/daily_checkin_screen.dart';
import 'package:paykaro/screens/credit_score_screen.dart';
import 'package:paykaro/screens/investment_portfolio_screen.dart';
import 'package:paykaro/screens/payment_reminders_screen.dart';
import 'package:paykaro/screens/transaction_search_screen.dart';
import 'package:paykaro/screens/fd_calculator_screen.dart';
import 'package:paykaro/screens/rd_calculator_screen.dart';
import 'package:paykaro/screens/gst_calculator_screen.dart';
import 'package:paykaro/screens/tip_calculator_screen.dart';
import 'package:paykaro/screens/subscription_manager_screen.dart';
import 'package:paykaro/screens/calendar_view_screen.dart';
import 'package:paykaro/screens/bnpl_screen.dart';
import 'package:paykaro/screens/insurance_hub_screen.dart';
import 'package:paykaro/screens/stock_trading_screen.dart';
import 'package:paykaro/screens/income_tax_screen.dart';
import 'package:paykaro/screens/retirement_planner_screen.dart';
import 'package:paykaro/screens/net_worth_screen.dart';
import 'package:paykaro/screens/mutual_fund_screen.dart';
import 'package:paykaro/screens/monthly_report_screen.dart';
import 'package:paykaro/screens/loan_prepayment_screen.dart';
import 'package:paykaro/screens/crypto_wallet_screen.dart';

class HomeScreen extends StatefulWidget {
  String? username, password;
  HomeScreen({super.key, this.username, this.password});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _wallet = WalletService();
  final _pageData = const [Home(), Search(), Pay(), Account()];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.username != null && widget.username!.isNotEmpty) {
      _wallet.setUsername(widget.username!);
    }
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(builder: (c) => IconButton(onPressed: () => Scaffold.of(c).openDrawer(), icon: const Icon(Icons.menu_rounded, size: 35))),
        title: const Text("Pay Karo", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.cyanAccent,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const History())),
              child: const Icon(Icons.notifications, color: Colors.black, size: 30),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            margin: const EdgeInsets.only(right: 10), width: 45, height: 45,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 5, blurRadius: 7, offset: const Offset(0, 3))],
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountMenu())),
                child: Image.asset("assets/Images/OIP.jpeg", fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 20), width: 100, height: 100,
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 5, blurRadius: 7, offset: const Offset(0, 3))],
                      gradient: const LinearGradient(colors: [Colors.blue, Colors.pink], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset("assets/Images/OIP.jpeg", fit: BoxFit.cover),
                    ),
                  ),
                  Text(_wallet.username, style: const TextStyle(fontSize: 20, color: Colors.amber, fontWeight: FontWeight.bold)),
                  Text('Balance: ₹${_wallet.balance.toStringAsFixed(0)}', style: const TextStyle(fontSize: 14, color: Colors.white70)),
                  Text('${_wallet.rewardPoints} Reward Points', style: const TextStyle(fontSize: 12, color: Colors.amber)),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.edit, color: Colors.green, size: 30),
                    label: const Text('Edit'),
                    onPressed: () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const Customization())); },
                    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _di(Icons.dashboard, "Home", () { Navigator.of(context).pop(); _onItemTapped(0); }),
                  _di(Icons.account_box, "Account", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountMenu())); }),
                  _di(Icons.history, "History", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const History())); }),
                  _di(Icons.qr_code_scanner, "UPI & QR Code", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const UpiQrScreen())); }),
                  _di(Icons.people, "Refer & Earn", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const ReferEarnScreen())); }),
                  _di(Icons.card_giftcard, "Rewards", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const RewardsScreen())); }),
                  _di(Icons.track_changes, "Savings Goals", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const SavingsGoalsScreen())); }),
                  _di(Icons.analytics, "Spending Analytics", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const SpendingAnalyticsScreen())); }),
                  _di(Icons.handshake, "Request Money", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const RequestMoneyScreen())); }),
                  _di(Icons.people_outline, "Split Bill", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const BillSplitScreen())); }),
                  _di(Icons.calculate, "EMI Calculator", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const EmiCalculatorScreen())); }),
                  _di(Icons.currency_exchange, "Currency Converter", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const CurrencyConverterScreen())); }),
                  _di(Icons.account_balance_wallet, "Budget Planner", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const BudgetPlannerScreen())); }),
                  _di(Icons.card_giftcard, "Gift Cards", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const GiftCardsScreen())); }),
                  _di(Icons.emoji_events, "Achievements", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const AchievementsScreen())); }),
                  _di(Icons.support_agent, "Customer Support", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportScreen())); }),
                  _di(Icons.trending_up, "SIP Calculator", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const SipCalculatorScreen())); }),
                  _di(Icons.account_balance, "Loan Services", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const LoanApplicationScreen())); }),
                  _di(Icons.notifications, "Notifications", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())); }),
                  _di(Icons.login, "Daily Check-in", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const DailyCheckinScreen())); }),
                  _di(Icons.credit_score, "Credit Score", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const CreditScoreScreen())); }),
                  _di(Icons.trending_up, "Investments", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const InvestmentPortfolioScreen())); }),
                  _di(Icons.alarm, "Payment Reminders", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentRemindersScreen())); }),
                  _di(Icons.search, "Search Transactions", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionSearchScreen())); }),
                  _di(Icons.account_balance, "FD Calculator", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const FdCalculatorScreen())); }),
                  _di(Icons.repeat, "RD Calculator", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const RdCalculatorScreen())); }),
                  _di(Icons.receipt_long, "GST Calculator", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const GstCalculatorScreen())); }),
                  _di(Icons.restaurant, "Tip Calculator", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const TipCalculatorScreen())); }),
                  _di(Icons.subscriptions, "Subscriptions", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionManagerScreen())); }),
                  _di(Icons.calendar_month, "Calendar View", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const CalendarViewScreen())); }),
                  _di(Icons.credit_card, "Pay Later (BNPL)", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const BnplScreen())); }),
                  _di(Icons.health_and_safety, "Insurance Hub", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const InsuranceHubScreen())); }),
                  _di(Icons.trending_up, "Stock Trading", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const StockTradingScreen())); }),
                  _di(Icons.account_balance, "Income Tax", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const IncomeTaxScreen())); }),
                  _di(Icons.beach_access, "Retirement", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const RetirementPlannerScreen())); }),
                  _di(Icons.monetization_on, "Net Worth", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const NetWorthScreen())); }),
                  _di(Icons.trending_up, "Mutual Funds", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const MutualFundScreen())); }),
                  _di(Icons.assessment, "Monthly Report", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const MonthlyReportScreen())); }),
                  _di(Icons.payments, "Loan Prepay", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const LoanPrepaymentScreen())); }),
                  _di(Icons.currency_bitcoin, "Crypto Wallet", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const CryptoWalletScreen())); }),
                  _di(Icons.dashboard_customize, "Customization", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const Customization())); }),
                  _di(Icons.settings, "Setting", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const Setting())); }),
                  _di(Icons.logout, "Log Out", () { Navigator.of(context).pop(); Navigator.push(context, MaterialPageRoute(builder: (_) => const LogOut())); }),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _pageData[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.green,
            tabBackgroundColor: Colors.grey.shade800,
            padding: const EdgeInsets.all(15),
            gap: 8,
            tabs: const [
              GButton(icon: Icons.dashboard, text: "Home"),
              GButton(icon: Icons.search_rounded, text: "Search"),
              GButton(icon: Icons.paypal, text: "Pay"),
              GButton(icon: Icons.person, text: "Account"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _di(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      dense: true,
      title: Text(title, style: const TextStyle(fontSize: 15, color: Colors.black87)),
      leading: Icon(icon, size: 22),
      onTap: onTap,
    );
  }
}
