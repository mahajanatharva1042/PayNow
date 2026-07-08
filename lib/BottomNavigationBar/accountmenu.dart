import 'package:flutter/material.dart';
import 'package:paykaro/services/wallet_service.dart';
import 'package:paykaro/logout.dart';
import 'package:paykaro/screens/add_money_screen.dart';
import 'package:paykaro/screens/rewards_screen.dart';
import 'package:paykaro/screens/savings_goals_screen.dart';

class AccountMenu extends StatefulWidget {
  final String? username;
  final String? password;

  const AccountMenu({super.key, this.username, this.password});

  @override
  State<AccountMenu> createState() => _AccountMenuState();
}

class _AccountMenuState extends State<AccountMenu> {
  final _wallet = WalletService();

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 3, blurRadius: 7)],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset("assets/Images/OIP.jpeg", fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 12),
            Text(_wallet.username, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

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
                  Text('₹${_wallet.balance.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text('${_wallet.rewardPoints} Reward Points', style: const TextStyle(color: Colors.amber, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _actionButton(Icons.add_circle_outline, 'Add Money', Colors.blue, () async {
              final r = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddMoneyScreen()));
              if (r == true) _refresh();
            }),
            const SizedBox(height: 12),
            _actionButton(Icons.card_giftcard, 'Rewards & Cashback', Colors.amber, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RewardsScreen())).then((_) => _refresh())),
            const SizedBox(height: 12),
            _actionButton(Icons.track_changes, 'Savings Goals', Colors.teal, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SavingsGoalsScreen())).then((_) => _refresh())),
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
              ),
              child: Column(
                children: [
                  const Text('Quick Stats', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _statRow('Total Transactions', '${_wallet.transactions.length}'),
                  _statRow('Savings Goals', '${_wallet.savingsGoals.length}'),
                  _statRow('Cashback Value', '₹${_wallet.cashbackValue.toStringAsFixed(0)}'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LogOut())),
                icon: const Icon(Icons.logout),
                label: const Text('Log Out', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label, style: const TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _statRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 15)), Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))],
      ),
    );
  }
}
