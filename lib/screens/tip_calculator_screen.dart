import 'package:flutter/material.dart';

class TipCalculatorScreen extends StatefulWidget {
  const TipCalculatorScreen({super.key});
  @override
  State<TipCalculatorScreen> createState() => _TipCalculatorScreenState();
}

class _TipCalculatorScreenState extends State<TipCalculatorScreen> {
  final _billCtrl = TextEditingController();
  final _peopleCtrl = TextEditingController(text: '1');
  double _tipPercent = 10;
  double _tipAmount = 0, _total = 0, _perPerson = 0;

  void _calculate() {
    final bill = double.tryParse(_billCtrl.text) ?? 0;
    final people = int.tryParse(_peopleCtrl.text) ?? 1;
    if (bill <= 0 || people < 1) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid values'), backgroundColor: Colors.red)); return; }
    _tipAmount = bill * _tipPercent / 100;
    _total = bill + _tipAmount;
    _perPerson = _total / people;
    setState(() {});
  }

  @override
  void dispose() { _billCtrl.dispose(); _peopleCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tip Calculator'), backgroundColor: Colors.green.shade700),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Icon(Icons.restaurant, size: 60, color: Colors.green),
          const SizedBox(height: 8),
          const Text('Split & Tip Calculator', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(controller: _billCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Bill Amount (₹)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.receipt))),
          const SizedBox(height: 16),
          TextField(controller: _peopleCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Number of People', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.people))),
          const SizedBox(height: 16),
          const Text('Tip Percentage', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, children: [5, 10, 15, 20, 25].map((p) => ChoiceChip(label: Text('$p%'), selected: _tipPercent == p, onSelected: (v) { _tipPercent = p.toDouble(); _calculate(); })).toList()),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: _calculate, style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Calculate', style: TextStyle(fontSize: 18)))),
          if (_total > 0) ...[
            const SizedBox(height: 24),
            Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green.shade700, Colors.green.shade500]), borderRadius: BorderRadius.circular(16)),
              child: Column(children: [const Text('Total with Tip', style: TextStyle(color: Colors.white70, fontSize: 14)), Text('₹${_total.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold))])),
            const SizedBox(height: 16),
            Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)]),
              child: Column(children: [
                _row('Bill Amount', '₹${double.tryParse(_billCtrl.text)?.toStringAsFixed(0) ?? '0'}', Colors.grey.shade700),
                _row('Tip ($_tipPercent%)', '₹${_tipAmount.toStringAsFixed(0)}', Colors.green),
                const Divider(),
                _row('Total', '₹${_total.toStringAsFixed(0)}', Colors.green.shade700),
                _row('Per Person', '₹${_perPerson.toStringAsFixed(2)}', Colors.blue),
                if ((int.tryParse(_peopleCtrl.text) ?? 1) > 1) ...[
                  const Divider(),
                  _row('People', _peopleCtrl.text, Colors.grey.shade600),
                ],
              ])),
          ],
        ]),
      ),
    );
  }
  Widget _row(String l, String v, Color c) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: TextStyle(fontSize: 15, color: Colors.grey.shade700)), Text(v, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: c))]));
}
