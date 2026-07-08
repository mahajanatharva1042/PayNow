import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class GstCalculatorScreen extends StatefulWidget {
  const GstCalculatorScreen({super.key});
  @override
  State<GstCalculatorScreen> createState() => _GstCalculatorScreenState();
}

class _GstCalculatorScreenState extends State<GstCalculatorScreen> {
  final _wallet = WalletService();
  final _amountCtrl = TextEditingController();
  double _rate = 18;
  double _gstAmount = 0, _total = 0, _baseAmount = 0;
  bool _isExclusive = true;

  void _calculate() {
    final amt = double.tryParse(_amountCtrl.text) ?? 0;
    if (amt <= 0) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid amount'), backgroundColor: Colors.red)); return; }
    if (_isExclusive) {
      _gstAmount = _wallet.gstExclusive(amt, _rate);
      _baseAmount = amt;
      _total = amt + _gstAmount;
    } else {
      _baseAmount = amt - _wallet.gstInclusive(amt, _rate);
      _gstAmount = _wallet.gstInclusive(amt, _rate);
      _total = amt;
    }
    setState(() {});
  }

  @override
  void dispose() { _amountCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final rates = [5, 12, 18, 28];
    return Scaffold(
      appBar: AppBar(title: const Text('GST Calculator'), backgroundColor: Colors.indigo.shade700),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Icon(Icons.receipt_long, size: 60, color: Colors.indigo),
          const SizedBox(height: 8),
          const Text('GST Calculator', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(controller: _amountCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Amount (₹)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.money))),
          const SizedBox(height: 16),
          Row(children: [
            ...rates.map((r) => Padding(padding: const EdgeInsets.only(right: 8), child: ChoiceChip(label: Text('$r%'), selected: _rate == r, onSelected: (v) { _rate = r.toDouble(); _calculate(); }))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ChoiceChip(label: const Text('Exclusive'), selected: _isExclusive, onSelected: (v) { _isExclusive = true; _calculate(); })),
            const SizedBox(width: 12),
            Expanded(child: ChoiceChip(label: const Text('Inclusive'), selected: !_isExclusive, onSelected: (v) { _isExclusive = false; _calculate(); })),
          ]),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: _calculate, style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo.shade700, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Calculate GST', style: TextStyle(fontSize: 18)))),
          if (_total > 0) ...[
            const SizedBox(height: 24),
            Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.indigo.shade700, Colors.indigo.shade500]), borderRadius: BorderRadius.circular(16)),
              child: Column(children: [
                Text(_isExclusive ? 'Total (incl. GST)' : 'Breakdown', style: const TextStyle(color: Colors.white70, fontSize: 14)),
                Text('₹${_total.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
              ])),
            const SizedBox(height: 16),
            Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)]),
              child: Column(children: [
                _row('Base Amount', '₹${_baseAmount.toStringAsFixed(0)}', Colors.indigo),
                const Divider(), _row('GST ($_rate%)', '₹${_gstAmount.toStringAsFixed(0)}', Colors.orange),
                const Divider(), _row('Total', '₹${_total.toStringAsFixed(0)}', Colors.green),
              ])),
          ],
        ]),
      ),
    );
  }
  Widget _row(String l, String v, Color c) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)), Text(v, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: c))]));
}
