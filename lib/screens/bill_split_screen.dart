import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class BillSplitScreen extends StatefulWidget {
  const BillSplitScreen({super.key});

  @override
  State<BillSplitScreen> createState() => _BillSplitScreenState();
}

class _BillSplitScreenState extends State<BillSplitScreen> {
  final _wallet = WalletService();
  final _totalCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _selectedUsers = <String>{};
  final _users = ['User 1', 'User 2', 'User 3', 'User 4', 'User 5', 'User 6'];

  @override
  void dispose() {
    _totalCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = double.tryParse(_totalCtrl.text) ?? 0;
    final splitAmount = _selectedUsers.isNotEmpty ? total / _selectedUsers.length : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Split Bill'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.people, size: 60, color: Colors.deepPurple),
            const SizedBox(height: 12),
            const Text('Split expenses with friends', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: _descCtrl,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.description),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _totalCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Total Amount (₹)',
                prefixText: '₹ ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.money),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            const Text('Select people to split with:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ..._users.map((u) => CheckboxListTile(
              title: Text(u),
              value: _selectedUsers.contains(u),
              onChanged: (v) {
                setState(() {
                  if (v == true) { _selectedUsers.add(u); } else { _selectedUsers.remove(u); }
                });
              },
              activeColor: Colors.deepPurple,
            )),
            if (_selectedUsers.isNotEmpty && total > 0) ...[
              const Divider(height: 30),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text('Each pays: ₹${splitAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                    const SizedBox(height: 4),
                    Text('Split among ${_selectedUsers.length} people', style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_totalCtrl.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter total amount'), backgroundColor: Colors.red));
                      return;
                    }
                    final myShare = splitAmount;
                    if (myShare > _wallet.balance) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Insufficient balance for your share'), backgroundColor: Colors.red));
                      return;
                    }
                    _wallet.sendMoney('${_selectedUsers.length} people (Bill Split)', myShare.toDouble());
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('₹${myShare.toStringAsFixed(0)} paid (your share)'),
                      backgroundColor: Colors.green,
                    ));
                    setState(() {});
                  },
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Pay Your Share', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
