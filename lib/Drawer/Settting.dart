import 'package:flutter/material.dart';
import 'package:paykaro/services/wallet_service.dart';
import 'package:paykaro/screens/set_pin_screen.dart';
import 'package:paykaro/screens/rewards_screen.dart';
import 'package:paykaro/screens/spending_analytics_screen.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _wallet = WalletService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.cyanAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Security', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.lock, color: Colors.blue),
              title: Text(_wallet.hasPin ? 'Change Transaction PIN' : 'Set Transaction PIN'),
              subtitle: Text(_wallet.hasPin ? 'PIN is currently set' : 'No PIN set'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (_) => const SetPinScreen()));
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text('Preferences', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          Card(
            child: SwitchListTile(
              secondary: const Icon(Icons.dark_mode, color: Colors.deepPurple),
              title: const Text('Dark Mode'),
              subtitle: Text(_wallet.isDarkMode ? 'Dark theme enabled' : 'Light theme enabled'),
              value: _wallet.isDarkMode,
              onChanged: (v) {
                _wallet.setDarkMode(v);
                setState(() {});
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.card_giftcard, color: Colors.amber),
              title: const Text('Rewards & Cashback'),
              subtitle: Text('${_wallet.rewardPoints} points available'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RewardsScreen())).then((_) => setState(() {})),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
              title: const Text('Username'),
              subtitle: Text(_wallet.username),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.account_balance_wallet, color: Colors.green),
              title: const Text('Balance'),
              subtitle: Text('₹${_wallet.balance.toStringAsFixed(0)}'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.analytics, color: Colors.deepOrange),
              title: const Text('Spending Analytics'),
              subtitle: const Text('View spending breakdown'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SpendingAnalyticsScreen())),
            ),
          ),
          const SizedBox(height: 20),
          const Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          const Card(
            child: ListTile(
              leading: Icon(Icons.info, color: Colors.blue),
              title: Text('Version'),
              subtitle: Text('2.0.0'),
            ),
          ),
        ],
      ),
    );
  }
}
