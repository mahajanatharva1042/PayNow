import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class RdCalculatorScreen extends StatefulWidget {
  const RdCalculatorScreen({super.key});
  @override
  State<RdCalculatorScreen> createState() => _RdCalculatorScreenState();
}

class _RdCalculatorScreenState extends State<RdCalculatorScreen> {
  final _wallet = WalletService();
  final _monthlyCtrl = TextEditingController();
  final _rateCtrl = TextEditingController(text: '7.5');
  final _yearsCtrl = TextEditingController(text: '5');
  double _maturity = 0, _interest = 0, _totalInvested = 0;

  void _calculate() {
    final p = double.tryParse(_monthlyCtrl.text) ?? 0;
    final r = double.tryParse(_rateCtrl.text) ?? 0;
    final y = double.tryParse(_yearsCtrl.text) ?? 0;
    if (p <= 0 || r <= 0 || y <= 0) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid values'), backgroundColor: Colors.red)); return; }
    _totalInvested = p * y * 12;
    _maturity = _wallet.rdMaturity(p, r, y.toInt());
    _interest = _maturity - _totalInvested;
    setState(() {});
  }

  @override
  void dispose() { _monthlyCtrl.dispose(); _rateCtrl.dispose(); _yearsCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RD Calculator'), backgroundColor: Colors.teal.shade700),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Icon(Icons.repeat, size: 60, color: Colors.teal),
          const SizedBox(height: 8),
          const Text('Recurring Deposit Calculator', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(controller: _monthlyCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Monthly Deposit (₹)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.money))),
          const SizedBox(height: 16),
          TextField(controller: _rateCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Interest Rate (%)', suffixText: '%', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.percent))),
          const SizedBox(height: 16),
          TextField(controller: _yearsCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Tenure (Years)', suffixText: 'years', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.calendar_today))),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: _calculate, style: ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade700, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Calculate RD', style: TextStyle(fontSize: 18)))),
          if (_maturity > 0) ...[
            const SizedBox(height: 24),
            Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.teal.shade700, Colors.teal.shade500]), borderRadius: BorderRadius.circular(16)),
              child: Column(children: [const Text('Maturity Amount', style: TextStyle(color: Colors.white70, fontSize: 14)), Text('₹${_maturity.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold))])),
            const SizedBox(height: 16),
            Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)]),
              child: Column(children: [
                _row('Total Invested', '₹${_totalInvested.toStringAsFixed(0)}', Colors.teal),
                const Divider(), _row('Interest Earned', '₹${_interest.toStringAsFixed(0)}', Colors.green),
                const Divider(), _row('Maturity Value', '₹${_maturity.toStringAsFixed(0)}', Colors.teal.shade700),
              ])),
          ],
        ]),
      ),
    );
  }
  Widget _row(String l, String v, Color c) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)), Text(v, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: c))]));
}
