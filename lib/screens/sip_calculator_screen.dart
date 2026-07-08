import 'package:flutter/material.dart';

class SipCalculatorScreen extends StatefulWidget {
  const SipCalculatorScreen({super.key});
  @override
  State<SipCalculatorScreen> createState() => _SipCalculatorScreenState();
}

class _SipCalculatorScreenState extends State<SipCalculatorScreen> {
  final _monthlyCtrl = TextEditingController();
  final _rateCtrl = TextEditingController(text: '12');
  final _yearsCtrl = TextEditingController(text: '10');
  double _totalInvestment = 0, _totalReturns = 0, _maturityValue = 0;

  void _calculate() {
    final p = double.tryParse(_monthlyCtrl.text) ?? 0;
    final r = double.tryParse(_rateCtrl.text) ?? 0;
    final y = double.tryParse(_yearsCtrl.text) ?? 0;
    if (p <= 0 || r <= 0 || y <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid values'), backgroundColor: Colors.red));
      return;
    }
    final n = y * 12;
    final monthlyRate = r / 12 / 100;
    final totalInvested = p * n;
    final maturity = p * ((1 + monthlyRate) * ((1 + monthlyRate) * (1 + monthlyRate) - 1) / monthlyRate);
    // Simple SIP formula: M = P × ((1+i)^n - 1) / i × (1+i)
    final powVal = (1 + monthlyRate);
    double powResult = 1;
    for (int i = 0; i < n.toInt(); i++) powResult *= powVal;
    final m = p * ((powResult - 1) / monthlyRate) * (1 + monthlyRate);
    final returns = m - totalInvested;
    setState(() { _totalInvestment = totalInvested; _totalReturns = returns; _maturityValue = m; });
  }

  @override
  void dispose() { _monthlyCtrl.dispose(); _rateCtrl.dispose(); _yearsCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SIP Calculator'), backgroundColor: Colors.indigo),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.trending_up, size: 60, color: Colors.indigo),
            const SizedBox(height: 8),
            const Text('Systematic Investment Plan Calculator', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(controller: _monthlyCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Monthly Investment (₹)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.money))),
            const SizedBox(height: 16),
            TextField(controller: _rateCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Expected Return Rate (%)', suffixText: '%', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.percent))),
            const SizedBox(height: 16),
            TextField(controller: _yearsCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Time Period (Years)', suffixText: 'years', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.calendar_today))),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: _calculate, style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Calculate SIP', style: TextStyle(fontSize: 18)))),
            if (_maturityValue > 0) ...[
              const SizedBox(height: 24),
              Container(
                width: double.infinity, padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.indigo, Colors.purple]), borderRadius: BorderRadius.circular(16)),
                child: Column(children: [
                  const Text('Maturity Value', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  Text('₹${_maturityValue.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                ]),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)]),
                child: Column(children: [
                  _row('Total Investment', '₹${_totalInvestment.toStringAsFixed(0)}', Colors.indigo),
                  const Divider(),
                  _row('Total Returns', '₹${_totalReturns.toStringAsFixed(0)}', Colors.green),
                  const Divider(),
                  _row('Maturity Value', '₹${_maturityValue.toStringAsFixed(0)}', Colors.deepPurple),
                ]),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _row(String l, String v, Color c) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)), Text(v, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: c))]));
}
