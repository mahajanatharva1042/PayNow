import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class SubscriptionManagerScreen extends StatefulWidget {
  const SubscriptionManagerScreen({super.key});
  @override
  State<SubscriptionManagerScreen> createState() => _SubscriptionManagerScreenState();
}

class _SubscriptionManagerScreenState extends State<SubscriptionManagerScreen> {
  final _wallet = WalletService();
  final _nameCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  String _frequency = 'Monthly';
  String _category = 'Entertainment';
  final _frequencies = ['Monthly', 'Yearly', 'Quarterly'];
  final _categories = ['Entertainment', 'Food', 'Shopping', 'Tech', 'Health', 'Education', 'Transport', 'Other'];

  @override
  void dispose() { _nameCtrl.dispose(); _amountCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final subs = _wallet.subscriptions;
    return Scaffold(
      appBar: AppBar(title: const Text('Subscription Manager'), backgroundColor: Colors.cyan.shade800),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.cyan.shade800, Colors.cyan.shade600]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              const Icon(Icons.subscriptions, size: 50, color: Colors.white),
              const SizedBox(height: 8),
              const Text('Monthly Spend on Subs', style: TextStyle(color: Colors.white70, fontSize: 14)),
              Text('₹${_wallet.totalSubscriptionMonthly.toStringAsFixed(0)}/mo', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            ])),
          const SizedBox(height: 20),
          const Text('Add Subscription', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(controller: _nameCtrl, decoration: InputDecoration(labelText: 'Service Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.business))),
          const SizedBox(height: 12),
          TextField(controller: _amountCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Amount (₹)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.money))),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: DropdownButtonFormField<String>(value: _frequency, decoration: const InputDecoration(labelText: 'Frequency', contentPadding: EdgeInsets.symmetric(horizontal: 12)), items: _frequencies.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(), onChanged: (v) => _frequency = v!)),
            const SizedBox(width: 12),
            Expanded(child: DropdownButtonFormField<String>(value: _category, decoration: const InputDecoration(labelText: 'Category', contentPadding: EdgeInsets.symmetric(horizontal: 12)), items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (v) => _category = v!)),
          ]),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton.icon(
            onPressed: () {
              final amt = double.tryParse(_amountCtrl.text) ?? 0;
              final result = _wallet.addSubscription(_nameCtrl.text, amt, _frequency, _category);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result == 'Success' ? 'Subscription added!' : result), backgroundColor: result == 'Success' ? Colors.green : Colors.red));
              if (result == 'Success') { _nameCtrl.clear(); _amountCtrl.clear(); }
              setState(() {});
            },
            icon: const Icon(Icons.add), label: const Text('Add Subscription', style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan.shade800, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          )),
          if (subs.isNotEmpty) ...[
            const SizedBox(height: 24), const Text('Your Subscriptions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 12),
            ...subs.reversed.map((s) {
              final monthly = s.frequency == 'Monthly' ? s.amount : s.frequency == 'Yearly' ? s.amount / 12 : s.amount / 3;
              return Container(
                margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)],
                  border: Border.all(color: s.isActive ? Colors.cyan.shade200 : Colors.grey.shade300)),
                child: Row(children: [
                  Container(width: 40, height: 40, decoration: BoxDecoration(color: s.isActive ? Colors.cyan.shade50 : Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.subscriptions, color: s.isActive ? Colors.cyan : Colors.grey)),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(s.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: s.isActive ? Colors.black : Colors.grey)),
                    Text('${s.frequency} • ${s.category} • ₹${monthly.toStringAsFixed(0)}/mo', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  ])),
                  Switch(value: s.isActive, onChanged: (v) { _wallet.toggleSubscription(subs.indexOf(s)); setState(() {}); }, activeColor: Colors.cyan),
                  IconButton(icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red), onPressed: () { _wallet.removeSubscription(subs.indexOf(s)); setState(() {}); }),
                ]),
              );
            }),
          ],
        ]),
      ),
    );
  }
}
