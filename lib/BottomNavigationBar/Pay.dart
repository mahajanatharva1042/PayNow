import 'package:flutter/material.dart';
import '../services/wallet_service.dart';
import '../screens/enter_pin_screen.dart';
import '../screens/payment_receipt_screen.dart';
import '../screens/request_money_screen.dart';
import '../screens/bill_split_screen.dart';

class Pay extends StatefulWidget {
  const Pay({super.key});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  final _wallet = WalletService();

  final List<Map<String, String>> _users = [
    {'name': 'User 1', 'id': '1'},
    {'name': 'User 2', 'id': '2'},
    {'name': 'User 3', 'id': '3'},
    {'name': 'User 4', 'id': '4'},
    {'name': 'User 5', 'id': '5'},
    {'name': 'User 6', 'id': '6'},
  ];

  List<Map<String, String>> get _sortedUsers {
    final favs = <Map<String, String>>[];
    final others = <Map<String, String>>[];
    for (final u in _users) {
      if (_wallet.isFavorite(u['name']!)) {
        favs.add(u);
      } else {
        others.add(u);
      }
    }
    return [...favs, ...others];
  }

  void _payUser(String name) {
    final amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Pay $name'),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Enter amount', prefixText: '₹ ', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final amt = double.tryParse(amountController.text);
              if (amt == null || amt <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid amount'), backgroundColor: Colors.red));
                return;
              }
              Navigator.pop(ctx);
              if (!_wallet.hasPin) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please set a PIN first in Settings'), backgroundColor: Colors.orange));
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EnterPinScreen(
                    amount: amt,
                    recipient: name,
                    onSuccess: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PaymentReceiptScreen(
                            recipient: name,
                            amount: amt,
                            transactionId: DateTime.now().millisecondsSinceEpoch.toString(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            child: const Text('Proceed'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.blue, Colors.purple]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.account_balance_wallet, size: 40, color: Colors.white),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Available Balance', style: TextStyle(color: Colors.white70, fontSize: 14)),
                        Text('₹${_wallet.balance.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  Text('${_wallet.rewardPoints}', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Quick actions row
            Row(
              children: [
                Expanded(
                  child: _actionCard(Icons.handshake, 'Request', Colors.indigo, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RequestMoneyScreen())).then((_) => setState(() {}))),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _actionCard(Icons.people, 'Split Bill', Colors.deepPurple, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BillSplitScreen())).then((_) => setState(() {}))),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text('All Contacts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            ...List.generate(_sortedUsers.length, (i) {
              final user = _sortedUsers[i];
              final isFav = _wallet.isFavorite(user['name']!);
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5, offset: const Offset(0, 2))],
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.primaries[i % Colors.primaries.length],
                    child: Text(user['name']!.split(' ').last, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  title: Row(
                    children: [
                      Text(user['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      if (isFav) ...[
                        const SizedBox(width: 6),
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                      ],
                    ],
                  ),
                  subtitle: const Text('Tap to send money'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(isFav ? Icons.star : Icons.star_border, color: isFav ? Colors.amber : Colors.grey),
                        onPressed: () {
                          _wallet.toggleFavorite(user['name']!);
                          setState(() {});
                        },
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _payUser(user['name']!),
                        icon: const Icon(Icons.send, size: 16),
                        label: const Text('Pay'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _actionCard(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
