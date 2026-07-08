import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class MonthlyReportScreen extends StatefulWidget {
  const MonthlyReportScreen({super.key});
  @override
  State<MonthlyReportScreen> createState() => _MonthlyReportScreenState();
}

class _MonthlyReportScreenState extends State<MonthlyReportScreen> {
  final _wallet = WalletService();
  int _year = DateTime.now().year;
  int _month = DateTime.now().month;
  Map<String, dynamic>? _report;

  void _generate() {
    _report = _wallet.monthlyReport(_year, _month);
    setState(() {});
  }

  @override
  void initState() { super.initState(); _generate(); }

  @override
  Widget build(BuildContext context) {
    final months = 'Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec'.split(',');
    return Scaffold(
      appBar: AppBar(title: const Text('Monthly Report'), backgroundColor: Colors.blueGrey),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Icon(Icons.assessment, size: 60, color: Colors.blueGrey),
          const SizedBox(height: 8),
          const Text('Spending Report', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(child: DropdownButtonFormField<int>(value: _month, decoration: InputDecoration(labelText: 'Month', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              items: List.generate(12, (i) => DropdownMenuItem(value: i + 1, child: Text(months[i]))),
              onChanged: (v) { _month = v!; _generate(); }),
            ),
            const SizedBox(width: 12),
            Expanded(child: DropdownButtonFormField<int>(value: _year, decoration: InputDecoration(labelText: 'Year', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              items: List.generate(5, (i) => DropdownMenuItem(value: _year - 2 + i, child: Text('${_year - 2 + i}'))),
              onChanged: (v) { _year = v!; _generate(); }),
            ),
          ]),
          const SizedBox(height: 20),
          if (_report != null) ...[
            Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.blueGrey, Colors.grey]), borderRadius: BorderRadius.circular(16)),
              child: Column(children: [
                Text('${months[_month - 1]} $_year', style: const TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 8),
                Text('Net: ₹${(_report!['net'] as double).toStringAsFixed(0)}', style: TextStyle(color: (_report!['net'] as double) >= 0 ? Colors.greenAccent : Colors.redAccent, fontSize: 24, fontWeight: FontWeight.bold)),
              ])),
            const SizedBox(height: 16),
            Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)]),
              child: Column(children: [
                row('Income', '₹${(_report!['income'] as double).toStringAsFixed(0)}', Colors.green),
                const Divider(), row('Expenses', '₹${(_report!['expenses'] as double).toStringAsFixed(0)}', Colors.red),
                const Divider(), row('Transactions', '${_report!['transactions']}', Colors.blue),
              ])),
            if ((_report!['categories'] as Map<String, double>).isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)]),
                child: Column(children: [
                  const Text('Category Breakdown', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...(_report!['categories'] as Map<String, double>).entries.map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(children: [
                        Container(width: 12, height: 12, decoration: BoxDecoration(color: _colorFor(e.key), shape: BoxShape.circle)),
                        const SizedBox(width: 8), Text(e.key, style: TextStyle(color: Colors.grey.shade700)),
                      ]),
                      Text('₹${e.value.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ]),
                  )),
                ])),
            ],
            if ((_report!['txnList'] as List).isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)]),
                child: Column(children: [
                  const Text('Transactions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...(_report!['txnList'] as List<Transaction>).map((t) => ListTile(
                    dense: true,
                    leading: Icon(t.type == 'Credit' ? Icons.arrow_downward : Icons.arrow_upward, color: t.type == 'Credit' ? Colors.green : Colors.red, size: 20),
                    title: Text(t.fromTo, style: const TextStyle(fontSize: 13)),
                    subtitle: Text('${t.category} • ${t.date.day}/${t.date.month}', style: const TextStyle(fontSize: 11)),
                    trailing: Text('₹${t.amount.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.bold, color: t.type == 'Credit' ? Colors.green : Colors.red)),
                  )),
                ])),
            ],
          ],
        ]),
      ),
    );
  }

  Color _colorFor(String cat) {
    final colors = [Colors.blue, Colors.red, Colors.green, Colors.orange, Colors.purple, Colors.teal, Colors.cyan, Colors.pink, Colors.indigo, Colors.amber];
    return colors[cat.hashCode.abs() % colors.length];
  }

  Widget row(String l, String v, Color c) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)), Text(v, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: c))]));
}
