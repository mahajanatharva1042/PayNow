import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class LoanPrepaymentScreen extends StatefulWidget {
  const LoanPrepaymentScreen({super.key});
  @override
  State<LoanPrepaymentScreen> createState() => _LoanPrepaymentScreenState();
}

class _LoanPrepaymentScreenState extends State<LoanPrepaymentScreen> {
  final _wallet = WalletService();
  final _principalCtrl = TextEditingController(text: '500000');
  final _rateCtrl = TextEditingController(text: '9');
  final _tenureCtrl = TextEditingController(text: '60');
  final _prepayCtrl = TextEditingController(text: '100000');
  final _afterCtrl = TextEditingController(text: '12');
  Map<String, double>? _result;

  void _calculate() {
    final p = double.tryParse(_principalCtrl.text) ?? 0;
    final r = double.tryParse(_rateCtrl.text) ?? 0;
    final t = int.tryParse(_tenureCtrl.text) ?? 0;
    final prepay = double.tryParse(_prepayCtrl.text) ?? 0;
    final after = int.tryParse(_afterCtrl.text) ?? 0;
    if (p <= 0 || r <= 0 || t <= 0 || prepay <= 0 || after <= 0) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid values'), backgroundColor: Colors.red)); return; }
    _result = _wallet.loanPrepayment(p, r, t, prepay, after);
    setState(() {});
  }

  @override
  void dispose() { _principalCtrl.dispose(); _rateCtrl.dispose(); _tenureCtrl.dispose(); _prepayCtrl.dispose(); _afterCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loan Prepayment'), backgroundColor: Colors.brown),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Icon(Icons.payments, size: 60, color: Colors.brown),
          const SizedBox(height: 8),
          const Text('Prepayment Calculator', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(controller: _principalCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Loan Amount (₹)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.account_balance))),
          const SizedBox(height: 16),
          TextField(controller: _rateCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Interest Rate (%)', suffixText: '%', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.percent))),
          const SizedBox(height: 16),
          TextField(controller: _tenureCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Tenure (Months)', suffixText: 'months', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.calendar_today))),
          const SizedBox(height: 16),
          TextField(controller: _prepayCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Prepayment Amount (₹)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.money_off))),
          const SizedBox(height: 16),
          TextField(controller: _afterCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Prepay After (Months)', suffixText: 'months', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.timer))),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: _calculate, style: ElevatedButton.styleFrom(backgroundColor: Colors.brown, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Calculate', style: TextStyle(fontSize: 18)))),
          if (_result != null) ...[
            const SizedBox(height: 24),
            Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)]),
              child: Column(children: [
                row('Original EMI', '₹${(_result!['originalEmi'] ?? 0).toStringAsFixed(0)}', Colors.blue),
                const Divider(), row('Total Interest', '₹${(_result!['totalInterest'] ?? 0).toStringAsFixed(0)}', Colors.red),
                if (_result!.containsKey('monthsSaved')) ...[
                  const Divider(), row('Months Saved', '${_result!['monthsSaved']?.toStringAsFixed(0) ?? '0'}', Colors.green),
                  const Divider(), row('Interest Saved', 'Varies based on prepayment', Colors.green),
                ],
                if (_result!.containsKey('newBalance') && _result!['newBalance']! > 0) ...[
                  const Divider(), row('Remaining Balance', '₹${(_result!['newBalance'] ?? 0).toStringAsFixed(0)}', Colors.orange),
                  const Divider(), row('New Tenure', '${(_result!['newTenure'] ?? 0).toStringAsFixed(0)} months', Colors.teal),
                ],
              ])),
          ],
        ]),
      ),
    );
  }

  Widget row(String l, String v, Color c) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)), Text(v, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: c))]));
}
