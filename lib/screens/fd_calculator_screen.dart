import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class FdCalculatorScreen extends StatefulWidget {
  const FdCalculatorScreen({super.key});
  @override
  State<FdCalculatorScreen> createState() => _FdCalculatorScreenState();
}

class _FdCalculatorScreenState extends State<FdCalculatorScreen> {
  final _wallet = WalletService();
  final _principalCtrl = TextEditingController();
  final _rateCtrl = TextEditingController(text: '7');
  final _yearsCtrl = TextEditingController(text: '3');
  int _compound = 4;
  double _maturity = 0, _interest = 0;

  void _calculate() {
    final p = double.tryParse(_principalCtrl.text) ?? 0;
    final r = double.tryParse(_rateCtrl.text) ?? 0;
    final y = double.tryParse(_yearsCtrl.text) ?? 0;
    if (p <= 0 || r <= 0 || y <= 0) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid values'), backgroundColor: Colors.red)); return; }
    _maturity = _wallet.fdMaturity(p, r, y.toInt(), _compound);
    _interest = _maturity - p;
    setState(() {});
  }

  @override
  void dispose() { _principalCtrl.dispose(); _rateCtrl.dispose(); _yearsCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FD Calculator'), backgroundColor: Colors.lightBlue),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Icon(Icons.account_balance, size: 60, color: Colors.lightBlue),
          const SizedBox(height: 8),
          const Text('Fixed Deposit Calculator', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(controller: _principalCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Deposit Amount (₹)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.money))),
          const SizedBox(height: 16),
          TextField(controller: _rateCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Interest Rate (%)', suffixText: '%', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.percent))),
          const SizedBox(height: 16),
          TextField(controller: _yearsCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Tenure (Years)', suffixText: 'years', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.calendar_today))),
          const SizedBox(height: 16),
          DropdownButtonFormField<int>(value: _compound, decoration: InputDecoration(labelText: 'Compounding', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            items: const [DropdownMenuItem(value: 1, child: Text('Yearly')), DropdownMenuItem(value: 4, child: Text('Quarterly')), DropdownMenuItem(value: 12, child: Text('Monthly'))],
            onChanged: (v) { _compound = v!; _calculate(); }),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: _calculate, style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Calculate FD', style: TextStyle(fontSize: 18)))),
          if (_maturity > 0) ...[
            const SizedBox(height: 24),
            Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.lightBlue, Colors.blue]), borderRadius: BorderRadius.circular(16)),
              child: Column(children: [const Text('Maturity Amount', style: TextStyle(color: Colors.white70, fontSize: 14)), Text('₹${_maturity.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold))])),
            const SizedBox(height: 16),
            Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)]),
              child: Column(children: [
                _row('Principal', '₹${double.tryParse(_principalCtrl.text)?.toStringAsFixed(0) ?? '0'}', Colors.blue),
                const Divider(), _row('Interest Earned', '₹${_interest.toStringAsFixed(0)}', Colors.green),
                const Divider(), _row('Total Maturity', '₹${_maturity.toStringAsFixed(0)}', Colors.lightBlue),
              ])),
          ],
        ]),
      ),
    );
  }
  Widget _row(String l, String v, Color c) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)), Text(v, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: c))]));
}
