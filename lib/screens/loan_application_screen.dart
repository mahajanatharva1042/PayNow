import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class LoanApplicationScreen extends StatefulWidget {
  const LoanApplicationScreen({super.key});
  @override
  State<LoanApplicationScreen> createState() => _LoanApplicationScreenState();
}

class _LoanApplicationScreenState extends State<LoanApplicationScreen> {
  final _wallet = WalletService();
  final _amountCtrl = TextEditingController();
  final _tenureCtrl = TextEditingController(text: '12');
  final _purposeCtrl = TextEditingController();
  final _purposes = ['Personal', 'Home', 'Education', 'Medical', 'Business', 'Vehicle', 'Other'];

  @override
  void dispose() { _amountCtrl.dispose(); _tenureCtrl.dispose(); _purposeCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final loans = _wallet.loanApplications;
    return Scaffold(
      appBar: AppBar(title: const Text('Loan Services'), backgroundColor: Colors.blue.shade800),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity, padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue.shade800, Colors.blue.shade600]), borderRadius: BorderRadius.circular(16)),
              child: Column(children: [
                const Icon(Icons.account_balance, size: 60, color: Colors.white),
                const SizedBox(height: 8),
                const Text('Instant Personal Loans', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const Text('Up to ₹5 Lakhs, 0% processing fee', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ]),
            ),
            const SizedBox(height: 20),
            const Text('Apply for Loan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(controller: _amountCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Loan Amount (₹)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.money))),
            const SizedBox(height: 12),
            TextField(controller: _tenureCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Tenure (Months)', suffixText: 'months', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.calendar_today))),
            const SizedBox(height: 12),
            TextField(controller: _purposeCtrl, decoration: InputDecoration(labelText: 'Purpose', hintText: 'e.g. Home renovation', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.description))),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton.icon(
              onPressed: () {
                final amt = double.tryParse(_amountCtrl.text) ?? 0;
                final ten = int.tryParse(_tenureCtrl.text) ?? 0;
                final result = _wallet.applyForLoan(amt, ten, _purposeCtrl.text);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result == 'Success' ? 'Loan application submitted!' : result), backgroundColor: result == 'Success' ? Colors.green : Colors.red));
                if (result == 'Success') { _amountCtrl.clear(); _purposeCtrl.clear(); }
                setState(() {});
              },
              icon: const Icon(Icons.send), label: const Text('Apply Now', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade800, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            )),
            if (loans.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text('Your Applications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...loans.reversed.map((l) => Container(
                margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 5)],
                  border: Border.all(color: l.status == 'Approved' ? Colors.green.shade200 : l.status == 'Rejected' ? Colors.red.shade200 : Colors.orange.shade200)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('₹${l.amount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: l.status == 'Approved' ? Colors.green.shade50 : l.status == 'Rejected' ? Colors.red.shade50 : Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
                        child: Text(l.status, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: l.status == 'Approved' ? Colors.green : l.status == 'Rejected' ? Colors.red : Colors.orange))),
                    ]),
                    const SizedBox(height: 4),
                    Text('${l.purpose} • ${l.tenureMonths} months', style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                    if (l.status == 'Pending') ...[
                      const SizedBox(height: 12),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        TextButton(onPressed: () { _wallet.approveLoan(loans.indexOf(l)); setState(() {}); }, child: const Text('Approve', style: TextStyle(color: Colors.green))),
                        TextButton(onPressed: () { _wallet.rejectLoan(loans.indexOf(l)); setState(() {}); }, child: const Text('Reject', style: TextStyle(color: Colors.red))),
                      ]),
                    ],
                  ],
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }
}
