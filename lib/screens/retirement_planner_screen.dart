import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class RetirementPlannerScreen extends StatefulWidget {
  const RetirementPlannerScreen({super.key});
  @override
  State<RetirementPlannerScreen> createState() => _RetirementPlannerScreenState();
}

class _RetirementPlannerScreenState extends State<RetirementPlannerScreen> {
  final _wallet = WalletService();
  final _ageCtrl = TextEditingController(text: '30');
  final _retAgeCtrl = TextEditingController(text: '60');
  final _expenseCtrl = TextEditingController(text: '50000');
  final _inflationCtrl = TextEditingController(text: '6');
  final _returnCtrl = TextEditingController(text: '12');
  double _corpus = 0, _monthlySIP = 0;

  void _calculate() {
    final age = double.tryParse(_ageCtrl.text) ?? 0;
    final retAge = double.tryParse(_retAgeCtrl.text) ?? 0;
    final expense = double.tryParse(_expenseCtrl.text) ?? 0;
    final inflation = double.tryParse(_inflationCtrl.text) ?? 0;
    final ret = double.tryParse(_returnCtrl.text) ?? 0;
    if (age <= 0 || retAge <= age || expense <= 0) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid values'), backgroundColor: Colors.red)); return; }
    _corpus = _wallet.retirementCorpus(age, retAge, expense, inflation, ret);
    final years = retAge - age;
    _monthlySIP = _wallet.monthlySIPforRetirement(_corpus, years, ret);
    setState(() {});
  }

  @override
  void dispose() { _ageCtrl.dispose(); _retAgeCtrl.dispose(); _expenseCtrl.dispose(); _inflationCtrl.dispose(); _returnCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Retirement Planner'), backgroundColor: Colors.teal),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Icon(Icons.beach_access, size: 60, color: Colors.teal),
          const SizedBox(height: 8),
          const Text('Plan Your Retirement', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(controller: _ageCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Current Age', suffixText: 'years', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.person))),
          const SizedBox(height: 16),
          TextField(controller: _retAgeCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Retirement Age', suffixText: 'years', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.flag))),
          const SizedBox(height: 16),
          TextField(controller: _expenseCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Monthly Expense (₹)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.shopping_cart))),
          const SizedBox(height: 16),
          TextField(controller: _inflationCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Inflation Rate (%)', suffixText: '%', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.trending_up))),
          const SizedBox(height: 16),
          TextField(controller: _returnCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Expected Return (%)', suffixText: '%', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.percent))),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: _calculate, style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Calculate', style: TextStyle(fontSize: 18)))),
          if (_corpus > 0) ...[
            const SizedBox(height: 24),
            Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.teal, Colors.green]), borderRadius: BorderRadius.circular(16)),
              child: Column(children: [
                const Text('Required Retirement Corpus', style: TextStyle(color: Colors.white70, fontSize: 14)),
                Text('₹${_corpus.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
              ])),
            const SizedBox(height: 16),
            Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)]),
              child: Column(children: [
                row('Current Age', '${double.tryParse(_ageCtrl.text)?.toStringAsFixed(0) ?? '0'} years', Colors.blue),
                const Divider(), row('Retirement Age', '${double.tryParse(_retAgeCtrl.text)?.toStringAsFixed(0) ?? '0'} years', Colors.teal),
                const Divider(), row('Monthly SIP Needed', '₹${_monthlySIP.toStringAsFixed(0)}', Colors.green),
                const Divider(), row('Total Corpus Needed', '₹${_corpus.toStringAsFixed(0)}', Colors.teal.shade800),
              ])),
          ],
        ]),
      ),
    );
  }

  Widget row(String l, String v, Color c) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)), Text(v, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: c))]));
}
