import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class BnplScreen extends StatefulWidget {
  const BnplScreen({super.key});
  @override
  State<BnplScreen> createState() => _BnplScreenState();
}

class _BnplScreenState extends State<BnplScreen> {
  final _wallet = WalletService();
  final _merchantCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _installmentsCtrl = TextEditingController(text: '3');

  @override
  void dispose() { _merchantCtrl.dispose(); _amountCtrl.dispose(); _installmentsCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final orders = _wallet.bnplOrders;
    return Scaffold(
      appBar: AppBar(title: const Text('Pay Later (BNPL)'), backgroundColor: Colors.deepPurple.shade900),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.deepPurple.shade900, Colors.deepPurple.shade700]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              const Icon(Icons.credit_card, size: 50, color: Colors.white),
              const SizedBox(height: 8),
              const Text('Buy Now, Pay Later', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              Text('${orders.where((o) => !o.isComplete).length} active orders', style: TextStyle(color: Colors.white70, fontSize: 13)),
            ])),
          const SizedBox(height: 20),
          const Text('New Purchase', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(controller: _merchantCtrl, decoration: InputDecoration(labelText: 'Merchant / Store', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.store))),
          const SizedBox(height: 12),
          TextField(controller: _amountCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Purchase Amount (₹)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.money))),
          const SizedBox(height: 12),
          TextField(controller: _installmentsCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Installments', suffixText: 'months', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.calendar_today))),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton.icon(
            onPressed: () {
              final amt = double.tryParse(_amountCtrl.text) ?? 0;
              final inst = int.tryParse(_installmentsCtrl.text) ?? 0;
              final result = _wallet.createBnplOrder(_merchantCtrl.text, amt, inst);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result == 'Success' ? 'BNPL order created! Amount credited to wallet' : result), backgroundColor: result == 'Success' ? Colors.green : Colors.red));
              if (result == 'Success') { _merchantCtrl.clear(); _amountCtrl.clear(); }
              setState(() {});
            },
            icon: const Icon(Icons.shopping_cart), label: const Text('Buy Now, Pay Later', style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple.shade900, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          )),
          if (orders.isNotEmpty) ...[
            const SizedBox(height: 24), const Text('Your Orders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 12),
            ...orders.reversed.map((o) {
              final progress = o.totalInstallments > 0 ? o.paidInstallments / o.totalInstallments : 0;
              return Container(
                margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 5)],
                  border: Border.all(color: o.isComplete ? Colors.green.shade200 : Colors.deepPurple.shade200)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(o.merchant, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: o.isComplete ? Colors.green.shade50 : Colors.deepPurple.shade50, borderRadius: BorderRadius.circular(12)),
                      child: Text(o.isComplete ? 'Paid' : '${o.paidInstallments}/${o.totalInstallments}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: o.isComplete ? Colors.green : Colors.deepPurple))),
                  ]),
                  const SizedBox(height: 8),
                  ClipRRect(borderRadius: BorderRadius.circular(6), child: LinearProgressIndicator(value: progress, minHeight: 6, backgroundColor: Colors.grey.shade200, valueColor: AlwaysStoppedAnimation(o.isComplete ? Colors.green : Colors.deepPurple))),
                  const SizedBox(height: 6),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('₹${o.paidAmount.toStringAsFixed(0)} paid', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                    Text('₹${o.remainingAmount.toStringAsFixed(0)} left', style: TextStyle(color: Colors.deepPurple, fontSize: 13, fontWeight: FontWeight.bold)),
                  ]),
                  if (!o.isComplete) ...[
                    const SizedBox(height: 12),
                    SizedBox(width: double.infinity, child: ElevatedButton(
                      onPressed: () {
                        final result = _wallet.payBnplInstallment(orders.indexOf(o));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result), backgroundColor: result.contains('Paid') ? Colors.green : Colors.red));
                        setState(() {});
                      },
                      child: Text('Pay Installment (₹${o.installmentAmount.toStringAsFixed(0)})'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
                    )),
                  ],
                ]),
              );
            }),
          ],
        ]),
      ),
    );
  }
}
