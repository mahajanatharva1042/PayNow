import 'package:flutter/material.dart';
import 'package:paykaro/services/wallet_service.dart';
import 'package:paykaro/logout.dart';
import 'package:paykaro/screens/add_money_screen.dart';
import 'package:paykaro/screens/rewards_screen.dart';
import 'package:paykaro/screens/savings_goals_screen.dart';
import 'package:paykaro/screens/upi_qr_screen.dart';
import 'package:paykaro/screens/refer_earn_screen.dart';
import 'package:paykaro/screens/emi_calculator_screen.dart';
import 'package:paykaro/screens/currency_converter_screen.dart';
import 'package:paykaro/screens/budget_planner_screen.dart';
import 'package:paykaro/screens/gift_cards_screen.dart';
import 'package:paykaro/screens/achievements_screen.dart';
import 'package:paykaro/screens/support_screen.dart';
import 'package:paykaro/screens/spending_analytics_screen.dart';
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

class Account extends StatefulWidget {
  const Account({super.key});
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final _wallet = WalletService();
  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 90, height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 3, blurRadius: 7)],
              ),
              child: ClipRRect(borderRadius: BorderRadius.circular(45), child: Image.asset("assets/Images/OIP.jpeg", fit: BoxFit.cover)),
            ),
            const SizedBox(height: 10),
            Text(_wallet.username, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.blue, Colors.purple]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text('Wallet Balance', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  Text('₹${_wallet.balance.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text('${_wallet.rewardPoints} Points', style: const TextStyle(color: Colors.amber, fontSize: 13)),
                      const SizedBox(width: 16),
                      const Icon(Icons.emoji_events, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text('${_wallet.achievements.where((a) => a.isUnlocked).length} Badges', style: const TextStyle(color: Colors.amber, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Quick actions grid
            _sectionTitle('Finance Tools'),
            _toolRow([
              _tool(Icons.add_circle_outline, "Add Money", Colors.blue, () async { final r = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddMoneyScreen())); if (r == true) _refresh(); }),
              _tool(Icons.card_giftcard, "Rewards", Colors.amber, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RewardsScreen())).then((_) => _refresh())),
              _tool(Icons.track_changes, "Goals", Colors.teal, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SavingsGoalsScreen())).then((_) => _refresh())),
            ]),
            const SizedBox(height: 6),
            _toolRow([
              _tool(Icons.qr_code_scanner, "UPI", Colors.blueGrey, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UpiQrScreen()))),
              _tool(Icons.people, "Refer", Colors.deepPurple, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReferEarnScreen())).then((_) => _refresh())),
              _tool(Icons.emoji_events, "Badges", Colors.amber.shade800, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AchievementsScreen()))),
            ]),
            const SizedBox(height: 6),
            _toolRow([
              _tool(Icons.calculate, "EMI", Colors.red, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EmiCalculatorScreen()))),
              _tool(Icons.currency_exchange, "Currency", Colors.teal, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CurrencyConverterScreen()))),
              _tool(Icons.account_balance_wallet, "Budget", Colors.green, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BudgetPlannerScreen())).then((_) => _refresh())),
            ]),
            const SizedBox(height: 6),
            _toolRow([
              _tool(Icons.card_giftcard, "Gifts", Colors.pink, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GiftCardsScreen())).then((_) => _refresh())),
              _tool(Icons.analytics, "Analytics", Colors.deepOrange, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SpendingAnalyticsScreen()))),
              _tool(Icons.support_agent, "Support", Colors.blueGrey, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportScreen()))),
            ]),
            const SizedBox(height: 6),
            _toolRow([
              _tool(Icons.trending_up, "SIP", Colors.indigo, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SipCalculatorScreen()))),
              _tool(Icons.account_balance, "Loans", Colors.blue, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoanApplicationScreen()))),
              _tool(Icons.notifications, "Notifs", Colors.blueGrey, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()))),
            ]),
            const SizedBox(height: 6),
            _toolRow([
              _tool(Icons.login, "Check-in", Colors.orange, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DailyCheckinScreen())).then((_) => _refresh())),
              _tool(Icons.credit_score, "Credit", Colors.blue.shade900, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreditScoreScreen()))),
              _tool(Icons.trending_up, "Invest", Colors.purple, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InvestmentPortfolioScreen()))),
            ]),
            const SizedBox(height: 6),
            _toolRow([
              _tool(Icons.alarm, "Reminders", Colors.deepOrange, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentRemindersScreen()))),
              _tool(Icons.search, "Search", Colors.blueGrey, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionSearchScreen()))),
              _tool(Icons.analytics, "Analytics", Colors.deepOrange, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SpendingAnalyticsScreen()))),
            ]),
            const SizedBox(height: 6),
            _toolRow([
              _tool(Icons.account_balance, "FD", Colors.lightBlue, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FdCalculatorScreen()))),
              _tool(Icons.repeat, "RD", Colors.teal, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RdCalculatorScreen()))),
              _tool(Icons.receipt_long, "GST", Colors.indigo, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GstCalculatorScreen()))),
            ]),
            const SizedBox(height: 6),
            _toolRow([
              _tool(Icons.restaurant, "Tip", Colors.green, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TipCalculatorScreen()))),
              _tool(Icons.subscriptions, "Subs", Colors.cyan, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionManagerScreen()))),
              _tool(Icons.calendar_month, "Calendar", Colors.blue, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CalendarViewScreen()))),
            ]),
            const SizedBox(height: 6),
            _toolRow([
              _tool(Icons.credit_card, "BNPL", Colors.deepPurple, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BnplScreen()))),
              _tool(Icons.health_and_safety, "Insurance", Colors.blue, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InsuranceHubScreen()))),
              const SizedBox.shrink(),
            ]),
            const SizedBox(height: 6),
            _toolRow([
              _tool(Icons.trending_up, "Stocks", Colors.indigo, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StockTradingScreen()))),
              _tool(Icons.account_balance, "Tax", Colors.red, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const IncomeTaxScreen()))),
              _tool(Icons.beach_access, "Retire", Colors.teal, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RetirementPlannerScreen()))),
            ]),
            const SizedBox(height: 6),
            _toolRow([
              _tool(Icons.monetization_on, "Net Worth", Colors.deepPurple, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NetWorthScreen()))),
              _tool(Icons.trending_up, "Mutual", Colors.orange, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MutualFundScreen()))),
              _tool(Icons.assessment, "Report", Colors.blueGrey, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MonthlyReportScreen()))),
            ]),
            const SizedBox(height: 6),
            _toolRow([
              _tool(Icons.payments, "Prepay", Colors.brown, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoanPrepaymentScreen()))),
              _tool(Icons.currency_bitcoin, "Crypto", Colors.amber, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CryptoWalletScreen()))),
              const SizedBox.shrink(),
            ]),

            const SizedBox(height: 20),

            // Stats
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)]),
              child: Column(
                children: [
                  const Text('Account Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _stat('Total Transactions', '${_wallet.transactions.length}'),
                  _stat('Reward Points', '${_wallet.rewardPoints}'),
                  _stat('Cashback Value', '₹${_wallet.cashbackValue.toStringAsFixed(0)}'),
                  _stat('Referrals', '${_wallet.referralCount}'),
                  _stat('Savings Goals', '${_wallet.savingsGoals.length}'),
                  _stat('Badges Unlocked', '${_wallet.achievements.where((a) => a.isUnlocked).length}'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LogOut())),
                icon: const Icon(Icons.logout),
                label: const Text('Log Out', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(alignment: Alignment.centerLeft, child: Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
    ));
  }

  Widget _tool(IconData icon, String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 6),
              Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toolRow(List<Widget> children) {
    return Row(children: children);
  }

  Widget _stat(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)), Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))],
      ),
    );
  }
}
