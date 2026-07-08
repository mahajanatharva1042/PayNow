import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class MutualFundScreen extends StatefulWidget {
  const MutualFundScreen({super.key});
  @override
  State<MutualFundScreen> createState() => _MutualFundScreenState();
}

class _MutualFundScreenState extends State<MutualFundScreen> {
  final _wallet = WalletService();
  int _mode = 0;
  final _amountCtrl = TextEditingController(text: '5000');
  final _rateCtrl = TextEditingController(text: '12');
  final _yearsCtrl = TextEditingController(text: '10');
  double _result = 0, _invested = 0;

  void _calculate() {
    final amt = double.tryParse(_amountCtrl.text) ?? 0;
    final rate = double.tryParse(_rateCtrl.text) ?? 0;
    final years = double.tryParse(_yearsCtrl.text) ?? 0;
    if (amt <= 0 || rate <= 0 || years <= 0) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid values'), backgroundColor: Colors.red)); return; }
    if (_mode == 0) {
      _result = _wallet.sipMaturity(amt, rate, years.toInt());
      _invested = amt * 12 * years;
    } else {
      _result = _wallet.lumpsumMaturity(amt, rate, years.toInt());
      _invested = amt;
    }
    setState(() {});
  }

  @override
  void dispose() { _amountCtrl.dispose(); _rateCtrl.dispose(); _yearsCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mutual Fund Calculator'), backgroundColor: Colors.orange.shade800),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Icon(Icons.trending_up, size: 60, color: Colors.orange),
          const SizedBox(height: 8),
          const Text('Mutual Fund Returns', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(child: ChoiceChip(label: const Text('SIP'), selected: _mode == 0, onSelected: (_) => setState(() => _mode = 0))),
            const SizedBox(width: 12),
            Expanded(child: ChoiceChip(label: const Text('Lumpsum'), selected: _mode == 1, onSelected: (_) => setState(() => _mode = 1))),
          ]),
          const SizedBox(height: 16),
          TextField(controller: _amountCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: _mode == 0 ? 'Monthly SIP (₹)' : 'Investment Amount (₹)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.money))),
          const SizedBox(height: 16),
          TextField(controller: _rateCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Expected Return (%)', suffixText: '%', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.percent))),
          const SizedBox(height: 16),
          TextField(controller: _yearsCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Time Period', suffixText: 'years', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.calendar_today))),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: _calculate, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade800, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Calculate', style: TextStyle(fontSize: 18)))),
          if (_result > 0) ...[
            const SizedBox(height: 24),
            Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.orange.shade800, Colors.deepOrange]), borderRadius: BorderRadius.circular(16)),
              child: Column(children: [
                Text(_mode == 0 ? 'Maturity Amount' : 'Future Value', style: const TextStyle(color: Colors.white70, fontSize: 14)),
                Text('₹${_result.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
              ])),
            const SizedBox(height: 16),
            Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)]),
              child: Column(children: [
                row('Invested Amount', '₹${_invested.toStringAsFixed(0)}', Colors.blue),
                const Divider(), row('Est. Returns', '₹${(_result - _invested).toStringAsFixed(0)}', Colors.green),
                const Divider(), row('Total Value', '₹${_result.toStringAsFixed(0)}', Colors.orange.shade800),
              ])),
          ],
        ]),
      ),
    );
  }

  Widget row(String l, String v, Color c) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)), Text(v, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: c))]));
}
