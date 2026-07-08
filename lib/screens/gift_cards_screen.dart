import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class GiftCardsScreen extends StatefulWidget {
  const GiftCardsScreen({super.key});

  @override
  State<GiftCardsScreen> createState() => _GiftCardsScreenState();
}

class _GiftCardsScreenState extends State<GiftCardsScreen> {
  final _wallet = WalletService();
  final _amountCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  String _selectedUser = 'User 1';
  final _users = ['User 1', 'User 2', 'User 3', 'User 4', 'User 5', 'User 6'];

  @override
  void dispose() {
    _amountCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cards = _wallet.giftCards;
    return Scaffold(
      appBar: AppBar(title: const Text('Gift Cards'), backgroundColor: Colors.pink),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.pink, Colors.orange]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(Icons.card_giftcard, size: 60, color: Colors.white),
                  const SizedBox(height: 8),
                  const Text('Send a Gift Card', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const Text('Surprise your friends!', style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Send Gift Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedUser,
              decoration: InputDecoration(labelText: 'To', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.person)),
              items: _users.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
              onChanged: (v) => setState(() => _selectedUser = v!),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount (₹)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.money)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _messageCtrl,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Message (optional)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.message)),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  final amt = double.tryParse(_amountCtrl.text) ?? 0;
                  if (amt <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid amount'), backgroundColor: Colors.red));
                    return;
                  }
                  if (!_wallet.hasPin) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Set a PIN first'), backgroundColor: Colors.orange));
                    return;
                  }
                  final result = _wallet.sendGiftCard(_selectedUser, amt, _messageCtrl.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result == 'Success' ? 'Gift card sent to $_selectedUser!' : result), backgroundColor: result == 'Success' ? Colors.green : Colors.red));
                  if (result == 'Success') { _amountCtrl.clear(); _messageCtrl.clear(); }
                  setState(() {});
                },
                icon: const Icon(Icons.send),
                label: const Text('Send Gift Card', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              ),
            ),
            if (cards.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text('Sent Gift Cards', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...cards.reversed.map((c) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.pink.shade50, Colors.orange.shade50]),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.pink.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.card_giftcard, color: Colors.pink.shade400, size: 40),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('To: ${c.to}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          if (c.message.isNotEmpty) Text(c.message, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                        ],
                      ),
                    ),
                    Text('₹${c.amount.toStringAsFixed(0)}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink.shade700)),
                  ],
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }
}
