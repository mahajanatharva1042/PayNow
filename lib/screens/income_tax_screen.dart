import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class IncomeTaxScreen extends StatefulWidget {
  const IncomeTaxScreen({super.key});
  @override
  State<IncomeTaxScreen> createState() => _IncomeTaxScreenState();
}

class _IncomeTaxScreenState extends State<IncomeTaxScreen> {
  final _wallet = WalletService();
  final _incomeCtrl = TextEditingController();
  final _deductionsCtrl = TextEditingController();
  int _regime = 0;
  double _tax = 0, _cess = 0;

  void _calculate() {
    final income = double.tryParse(_incomeCtrl.text) ?? 0;
    final deductions = double.tryParse(_deductionsCtrl.text) ?? 0;
    if (income <= 0) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid income'), backgroundColor: Colors.red)); return; }
    double tax;
    if (_regime == 0) {
      tax = _wallet.taxWithDeductions(income, deductions);
    } else {
      tax = _wallet.taxNewRegime(income);
    }
    _tax = tax;
    _cess = tax * 0.04;
    setState(() {});
  }

  @override
  void dispose() { _incomeCtrl.dispose(); _deductionsCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Income Tax Calculator'), backgroundColor: Colors.red.shade700),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Icon(Icons.account_balance, size: 60, color: Colors.red),
          const SizedBox(height: 8),
          const Text('Tax Calculator (FY 2025-26)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(controller: _incomeCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Annual Income (₹)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.money))),
          const SizedBox(height: 16),
          if (_regime == 0) TextField(controller: _deductionsCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Deductions (80C, 80D, etc.)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.card_giftcard))),
          if (_regime == 0) const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ChoiceChip(label: const Text('Old Regime'), selected: _regime == 0, onSelected: (_) => setState(() => _regime = 0))),
            const SizedBox(width: 12),
            Expanded(child: ChoiceChip(label: const Text('New Regime'), selected: _regime == 1, onSelected: (_) => setState(() => _regime = 1))),
          ]),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: _calculate, style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade700, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Calculate Tax', style: TextStyle(fontSize: 18)))),
          if (_tax > 0) ...[
            const SizedBox(height: 24),
            Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.red.shade700, Colors.red.shade900]), borderRadius: BorderRadius.circular(16)),
              child: Column(children: [
                const Text('Tax Payable', style: TextStyle(color: Colors.white70, fontSize: 14)),
                Text('₹${_tax.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
              ])),
            const SizedBox(height: 16),
            Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)]),
              child: Column(children: [
                row('Income', '₹${double.tryParse(_incomeCtrl.text)?.toStringAsFixed(0) ?? '0'}', Colors.black),
                if (_regime == 0) ...[const Divider(), row('Deductions', '₹${double.tryParse(_deductionsCtrl.text)?.toStringAsFixed(0) ?? '0'}', Colors.green)],
                const Divider(), row('Regime', _regime == 0 ? 'Old' : 'New', Colors.blue),
                const Divider(), row('Income Tax', '₹${_tax.toStringAsFixed(0)}', Colors.red),
                const Divider(), row('Health & Edu Cess (4%)', '₹${_cess.toStringAsFixed(0)}', Colors.orange),
                const Divider(), row('Total Tax', '₹${(_tax + _cess).toStringAsFixed(0)}', Colors.red.shade900),
              ])),
          ],
        ]),
      ),
    );
  }

  Widget row(String l, String v, Color c) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)), Text(v, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: c))]));
}
