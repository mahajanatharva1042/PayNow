import 'package:flutter/material.dart';
import 'package:paynow/services/wallet_service.dart';
import 'package:paynow/subpages.dart';
import 'package:paynow/screens/add_money_screen.dart';
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

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _wallet = WalletService();
  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
          child: Column(
            children: [
              // Balance Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.blue, Colors.purple]),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Balance', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 8),
                    Text('₹${_wallet.balance.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text('${_wallet.rewardPoints} Reward Points', style: const TextStyle(color: Colors.amber, fontSize: 14, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        const Icon(Icons.emoji_events, color: Colors.white, size: 18),
                        const SizedBox(width: 4),
                        Text('${_wallet.achievements.where((a) => a.isUnlocked).length} Badges', style: const TextStyle(color: Colors.white70, fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddMoneyScreen()));
                              if (result == true) _refresh();
                            },
                            icon: const Icon(Icons.add, color: Colors.white),
                            label: const Text('Add Money', style: TextStyle(color: Colors.white)),
                            style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Quick Actions Row 1
              _sectionTitle('Quick Actions'),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardStyle(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _qa(Icons.qr_code_scanner, "UPI", Colors.blueGrey, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UpiQrScreen()))),
                        _qa(Icons.people, "Refer", Colors.deepPurple, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReferEarnScreen())).then((_) => _refresh())),
                        _qa(Icons.card_giftcard, "Rewards", Colors.amber, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RewardsScreen())).then((_) => _refresh())),
                        _qa(Icons.track_changes, "Goals", Colors.teal, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SavingsGoalsScreen())).then((_) => _refresh())),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _qa(Icons.handshake, "Request", Colors.indigo, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RequestMoneyScreen())).then((_) => _refresh())),
                        _qa(Icons.people_outline, "Split", Colors.deepPurple, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BillSplitScreen())).then((_) => _refresh())),
                        _qa(Icons.calculate, "EMI", Colors.red, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EmiCalculatorScreen()))),
                        _qa(Icons.currency_exchange, "Currency", Colors.teal, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CurrencyConverterScreen()))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _qa(Icons.account_balance_wallet, "Budget", Colors.green, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BudgetPlannerScreen())).then((_) => _refresh())),
                        _qa(Icons.card_giftcard, "Gifts", Colors.pink, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GiftCardsScreen())).then((_) => _refresh())),
                        _qa(Icons.emoji_events, "Badges", Colors.amber, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AchievementsScreen()))),
                        _qa(Icons.support_agent, "Support", Colors.blueGrey, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportScreen()))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _qa(Icons.trending_up, "SIP", Colors.indigo, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SipCalculatorScreen()))),
                        _qa(Icons.account_balance, "Loans", Colors.blue, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoanApplicationScreen()))),
                        _qa(Icons.notifications, "Notifs", Colors.blueGrey, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()))),
                        _qa(Icons.login, "Check-in", Colors.orange, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DailyCheckinScreen())).then((_) => _refresh())),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _qa(Icons.credit_score, "Credit", Colors.blue.shade900, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreditScoreScreen()))),
                        _qa(Icons.trending_up, "Invest", Colors.purple, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InvestmentPortfolioScreen()))),
                        _qa(Icons.alarm, "Reminders", Colors.deepOrange, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentRemindersScreen()))),
                        _qa(Icons.search, "Search", Colors.blueGrey, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionSearchScreen()))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _qa(Icons.account_balance, "FD", Colors.lightBlue, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FdCalculatorScreen()))),
                        _qa(Icons.repeat, "RD", Colors.teal, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RdCalculatorScreen()))),
                        _qa(Icons.receipt_long, "GST", Colors.indigo, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GstCalculatorScreen()))),
                        _qa(Icons.restaurant, "Tip", Colors.green, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TipCalculatorScreen()))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _qa(Icons.subscriptions, "Subs", Colors.cyan, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionManagerScreen()))),
                        _qa(Icons.calendar_month, "Calendar", Colors.blue, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CalendarViewScreen()))),
                        _qa(Icons.credit_card, "BNPL", Colors.deepPurple, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BnplScreen()))),
                        _qa(Icons.health_and_safety, "Insurance", Colors.blue, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InsuranceHubScreen()))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _qa(Icons.trending_up, "Stocks", Colors.indigo, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StockTradingScreen()))),
                        _qa(Icons.account_balance, "Tax", Colors.red, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const IncomeTaxScreen()))),
                        _qa(Icons.beach_access, "Retire", Colors.teal, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RetirementPlannerScreen()))),
                        _qa(Icons.monetization_on, "Net Worth", Colors.deepPurple, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NetWorthScreen()))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _qa(Icons.trending_up, "Mutual", Colors.orange, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MutualFundScreen()))),
                        _qa(Icons.assessment, "Report", Colors.blueGrey, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MonthlyReportScreen()))),
                        _qa(Icons.payments, "Prepay", Colors.brown, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoanPrepaymentScreen()))),
                        _qa(Icons.currency_bitcoin, "Crypto", Colors.amber, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CryptoWalletScreen()))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Services
              _sectionTitle('Services'),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardStyle(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _sb(Icons.receipt, "Light Bill", () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LightBill()))),
                        _sb(Icons.add_card, "Add Cart", () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddCart()))),
                        _sb(Icons.phone_android, "Recharge", () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Recharge()))),
                        _sb(Icons.account_balance, "Balance", () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Balance()))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _sb(Icons.business, "Business", () => Navigator.push(context, MaterialPageRoute(builder: (_) => const YourBusiness()))),
                        _sb(Icons.ad_units, "Units", () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Unit()))),
                        _sb(Icons.account_balance_wallet, "Wallet", () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Wallet()))),
                        _sb(Icons.analytics, "Analytics", () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SpendingAnalyticsScreen()))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // People
              _sectionTitle('People'),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardStyle(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _pa("User 1", const User1()),
                        _pa("User 2", const User2()),
                        _pa("User 3", const User3()),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _pa("User 4", const User4()),
                        _pa("User 5", const User5()),
                        _pa("User 6", const User6()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(alignment: Alignment.centerLeft, child: Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    ));
  }

  BoxDecoration _cardStyle() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
  );

  Widget _qa(IconData icon, String label, Color color, VoidCallback onTap) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onTap,
          child: Icon(icon, color: Colors.white, size: 22),
          style: ElevatedButton.styleFrom(
            backgroundColor: color, padding: const EdgeInsets.all(14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 3,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _sb(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onTap,
          child: Icon(icon),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyanAccent, foregroundColor: Colors.black,
            padding: const EdgeInsets.all(16), elevation: 3,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _pa(String name, Widget page) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue.shade100,
            child: Text(name.split(' ').map((e) => e[0]).join(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
