import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class RequestMoneyScreen extends StatefulWidget {
  const RequestMoneyScreen({super.key});

  @override
  State<RequestMoneyScreen> createState() => _RequestMoneyScreenState();
}

class _RequestMoneyScreenState extends State<RequestMoneyScreen> {
  final _wallet = WalletService();
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  String _selectedUser = 'User 1';
  final _users = ['User 1', 'User 2', 'User 3', 'User 4', 'User 5', 'User 6'];

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Money'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.handshake, size: 80, color: Colors.indigo),
            const SizedBox(height: 20),
            const Text('Request money from someone', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: _selectedUser,
              decoration: InputDecoration(
                labelText: 'From',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.person),
              ),
              items: _users.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
              onChanged: (v) => setState(() => _selectedUser = v!),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount (₹)',
                prefixText: '₹ ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.money),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _noteCtrl,
              decoration: InputDecoration(
                labelText: 'Note (optional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.notes),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  final amt = double.tryParse(_amountCtrl.text);
                  if (amt == null || amt <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid amount'), backgroundColor: Colors.red));
                    return;
                  }
                  final result = _wallet.createRequest(_selectedUser, amt, _noteCtrl.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result == 'Success' ? 'Request sent to $_selectedUser' : result), backgroundColor: result == 'Success' ? Colors.green : Colors.red));
                  if (result == 'Success') {
                    _amountCtrl.clear();
                    _noteCtrl.clear();
                  }
                },
                icon: const Icon(Icons.send),
                label: const Text('Send Request', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildRequestsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestsList() {
    final requests = _wallet.paymentRequests.where((r) => !r.isPaid).toList();
    if (requests.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pending Requests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...requests.map((r) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.indigo.shade100,
                child: Text(r.from[0], style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('To: ${r.to}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    if (r.note.isNotEmpty) Text(r.note, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                  ],
                ),
              ),
              Text('₹${r.amount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
            ],
          ),
        )),
      ],
    );
  }
}
