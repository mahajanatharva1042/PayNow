import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:paynow/services/wallet_service.dart';
import 'package:paynow/BottomNavigationBar/Home.dart';
import 'package:paynow/BottomNavigationBar/Search.dart';
import 'package:paynow/BottomNavigationBar/Pay.dart';
import 'package:paynow/BottomNavigationBar/Account.dart';
import 'package:paynow/Drawer/History.dart';
import 'package:paynow/Drawer/Customization.dart';
import 'package:paynow/Drawer/Settting.dart';
import 'package:paynow/logout.dart';
import 'package:paynow/BottomNavigationBar/accountmenu.dart';
import 'package:paynow/screens/rewards_screen.dart';
import 'package:paynow/screens/savings_goals_screen.dart';
import 'package:paynow/screens/request_money_screen.dart';
import 'package:paynow/screens/bill_split_screen.dart';
import 'package:paynow/screens/spending_analytics_screen.dart';
import 'package:paynow/screens/upi_qr_screen.dart';
import 'package:paynow/screens/refer_earn_screen.dart';
import 'package:paynow/screens/emi_calculator_screen.dart';
import 'package:paynow/screens/currency_converter_screen.dart';
import 'package:paynow/screens/budget_planner_screen.dart';
import 'package:paynow/screens/gift_cards_screen.dart';
import 'package:paynow/screens/achievements_screen.dart';
import 'package:paynow/screens/support_screen.dart';
import 'package:paynow/screens/sip_calculator_screen.dart';
import 'package:paynow/screens/loan_application_screen.dart';
import 'package:paynow/screens/notifications_screen.dart';
import 'package:paynow/screens/daily_checkin_screen.dart';
import 'package:paynow/screens/credit_score_screen.dart';
import 'package:paynow/screens/investment_portfolio_screen.dart';
import 'package:paynow/screens/payment_reminders_screen.dart';
import 'package:paynow/screens/transaction_search_screen.dart';
import 'package:paynow/screens/fd_calculator_screen.dart';
import 'package:paynow/screens/rd_calculator_screen.dart';
import 'package:paynow/screens/gst_calculator_screen.dart';
import 'package:paynow/screens/tip_calculator_screen.dart';
import 'package:paynow/screens/subscription_manager_screen.dart';
import 'package:paynow/screens/calendar_view_screen.dart';
import 'package:paynow/screens/bnpl_screen.dart';
import 'package:paynow/screens/insurance_hub_screen.dart';
import 'package:paynow/screens/stock_trading_screen.dart';
import 'package:paynow/screens/income_tax_screen.dart';
import 'package:paynow/screens/retirement_planner_screen.dart';
import 'package:paynow/screens/net_worth_screen.dart';
import 'package:paynow/screens/mutual_fund_screen.dart';
import 'package:paynow/screens/monthly_report_screen.dart';
import 'package:paynow/screens/loan_prepayment_screen.dart';
import 'package:paynow/screens/crypto_wallet_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? username, password;
  const HomeScreen({super.key, this.username, this.password});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _wallet = WalletService();
  final _pageData = [Home(), Search(), Pay(), Account()];
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
        leading: Builder(
          builder: (c) => IconButton(
            onPressed: () => Scaffold.of(c).openDrawer(),
            icon: const Icon(Icons.menu_rounded, size: 30),
            color: Colors.white,
          ),
        ),
        title: const Text(
          "PayNow",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF4A90E2),
        centerTitle: true,
        elevation: 2,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const NotificationsScreen())),
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.white, size: 28),
              ),
              if (_wallet.unreadNotificationCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${_wallet.unreadNotificationCount}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const AccountMenu())),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset("assets/Images/OIP.jpeg",
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4A90E2), Color(0xFF7B68EE)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 20),
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: Image.asset("assets/Images/OIP.jpeg",
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _wallet.username,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Balance: ₹${_wallet.balance.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_wallet.rewardPoints} pts',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Customization()));
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit Profile'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _di(Icons.dashboard, "Home",
                      () => {Navigator.of(context).pop(), _onItemTapped(0)}),
                  _di(Icons.account_box, "Account", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AccountMenu()))
                  }),
                  _di(Icons.history, "History", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const History()))
                  }),
                  _sectionDivider("Payments"),
                  _di(Icons.qr_code_scanner, "UPI & QR Code", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const UpiQrScreen()))
                  }),
                  _di(Icons.people, "Refer & Earn", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ReferEarnScreen()))
                  }),
                  _di(Icons.card_giftcard, "Rewards", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RewardsScreen()))
                  }),
                  _sectionDivider("Finance"),
                  _di(Icons.track_changes, "Savings Goals", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SavingsGoalsScreen()))
                  }),
                  _di(Icons.analytics, "Spending Analytics", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const SpendingAnalyticsScreen()))
                  }),
                  _di(Icons.handshake, "Request Money", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RequestMoneyScreen()))
                  }),
                  _di(Icons.people_outline, "Split Bill", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const BillSplitScreen()))
                  }),
                  _sectionDivider("Calculators"),
                  _di(Icons.calculate, "EMI Calculator", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EmiCalculatorScreen()))
                  }),
                  _di(Icons.currency_exchange, "Currency Converter", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CurrencyConverterScreen()))
                  }),
                  _di(Icons.account_balance_wallet, "Budget Planner", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const BudgetPlannerScreen()))
                  }),
                  _di(Icons.card_giftcard, "Gift Cards", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const GiftCardsScreen()))
                  }),
                  _sectionDivider("More"),
                  _di(Icons.emoji_events, "Achievements", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AchievementsScreen()))
                  }),
                  _di(Icons.support_agent, "Customer Support", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SupportScreen()))
                  }),
                  _di(Icons.trending_up, "SIP Calculator", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SipCalculatorScreen()))
                  }),
                  _di(Icons.account_balance, "Loan Services", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LoanApplicationScreen()))
                  }),
                  _di(Icons.login, "Daily Check-in", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DailyCheckinScreen()))
                  }),
                  _di(Icons.credit_score, "Credit Score", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CreditScoreScreen()))
                  }),
                  _di(Icons.trending_up, "Investments", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const InvestmentPortfolioScreen()))
                  }),
                  _di(Icons.alarm, "Payment Reminders", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PaymentRemindersScreen()))
                  }),
                  _di(Icons.search, "Search Transactions", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TransactionSearchScreen()))
                  }),
                  _di(Icons.account_balance, "FD Calculator", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FdCalculatorScreen()))
                  }),
                  _di(Icons.repeat, "RD Calculator", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RdCalculatorScreen()))
                  }),
                  _di(Icons.receipt_long, "GST Calculator", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const GstCalculatorScreen()))
                  }),
                  _di(Icons.restaurant, "Tip Calculator", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TipCalculatorScreen()))
                  }),
                  _di(Icons.subscriptions, "Subscriptions", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SubscriptionManagerScreen()))
                  }),
                  _di(Icons.calendar_month, "Calendar View", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CalendarViewScreen()))
                  }),
                  _di(Icons.credit_card, "Pay Later (BNPL)", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const BnplScreen()))
                  }),
                  _di(Icons.health_and_safety, "Insurance Hub", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const InsuranceHubScreen()))
                  }),
                  _di(Icons.trending_up, "Stock Trading", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const StockTradingScreen()))
                  }),
                  _di(Icons.account_balance, "Income Tax", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const IncomeTaxScreen()))
                  }),
                  _di(Icons.beach_access, "Retirement", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RetirementPlannerScreen()))
                  }),
                  _di(Icons.monetization_on, "Net Worth", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const NetWorthScreen()))
                  }),
                  _di(Icons.trending_up, "Mutual Funds", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MutualFundScreen()))
                  }),
                  _di(Icons.assessment, "Monthly Report", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MonthlyReportScreen()))
                  }),
                  _di(Icons.payments, "Loan Prepay", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LoanPrepaymentScreen()))
                  }),
                  _di(Icons.currency_bitcoin, "Crypto Wallet", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CryptoWalletScreen()))
                  }),
                  _sectionDivider("Settings"),
                  _di(Icons.dashboard_customize, "Customization", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Customization()))
                  }),
                  _di(Icons.settings, "Setting", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const Setting()))
                  }),
                  _di(Icons.logout, "Log Out", () => {
                    Navigator.of(context).pop(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LogOut()))
                  }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _pageData[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
            backgroundColor: Colors.white,
            color: Colors.grey,
            activeColor: const Color(0xFF4A90E2),
            tabBackgroundColor: const Color(0xFF4A90E2).withOpacity(0.1),
            padding: const EdgeInsets.all(12),
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

  Widget _sectionDivider(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12, bottom: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _di(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      dense: true,
      title: Text(title, style: const TextStyle(fontSize: 14)),
      leading: Icon(icon, size: 22, color: const Color(0xFF4A90E2)),
      trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
      onTap: onTap,
    );
  }
}
