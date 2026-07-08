import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class PaymentRemindersScreen extends StatefulWidget {
  const PaymentRemindersScreen({super.key});
  @override
  State<PaymentRemindersScreen> createState() => _PaymentRemindersScreenState();
}

class _PaymentRemindersScreenState extends State<PaymentRemindersScreen> {
  final _wallet = WalletService();
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  DateTime _dueDate = DateTime.now().add(const Duration(days: 7));

  @override
  void dispose() { _titleCtrl.dispose(); _amountCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final reminders = _wallet.reminders;
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Reminders'), backgroundColor: Colors.deepOrange),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity, padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.deepOrange, Colors.orange]), borderRadius: BorderRadius.circular(16)),
              child: Column(children: [
                const Icon(Icons.alarm, size: 50, color: Colors.white),
                const SizedBox(height: 8),
                const Text('Never miss a payment', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              ]),
            ),
            const SizedBox(height: 20),
            const Text('Add Reminder', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(controller: _titleCtrl, decoration: InputDecoration(labelText: 'Bill / Payment Title', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.title))),
            const SizedBox(height: 12),
            TextField(controller: _amountCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Amount (₹)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.money))),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today),
              title: Text('Due Date: ${_dueDate.day}/${_dueDate.month}/${_dueDate.year}'),
              trailing: const Icon(Icons.edit_calendar),
              onTap: () async {
                final picked = await showDatePicker(context: context, initialDate: _dueDate, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
                if (picked != null) setState(() => _dueDate = picked);
              },
            ),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton.icon(
              onPressed: () {
                final amt = double.tryParse(_amountCtrl.text) ?? 0;
                final result = _wallet.addReminder(_titleCtrl.text, amt, _dueDate);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result == 'Success' ? 'Reminder set!' : result), backgroundColor: result == 'Success' ? Colors.green : Colors.red));
                if (result == 'Success') { _titleCtrl.clear(); _amountCtrl.clear(); }
                setState(() {});
              },
              icon: const Icon(Icons.add_alarm), label: const Text('Set Reminder', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            )),
            if (reminders.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text('Upcoming Payments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...reminders.reversed.map((r) {
                final overdue = !r.isPaid && r.dueDate.isBefore(DateTime.now());
                final daysLeft = r.dueDate.difference(DateTime.now()).inDays;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: r.isPaid ? Colors.green.shade200 : overdue ? Colors.red.shade200 : Colors.orange.shade200),
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)]),
                  child: Row(children: [
                    Icon(r.isPaid ? Icons.check_circle : Icons.alarm, color: r.isPaid ? Colors.green : overdue ? Colors.red : Colors.orange, size: 36),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(r.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 2),
                      Text(r.isPaid ? 'Paid ✓' : overdue ? 'Overdue!' : '$daysLeft days left', style: TextStyle(color: r.isPaid ? Colors.green : overdue ? Colors.red : Colors.grey.shade600, fontSize: 13)),
                    ])),
                    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Text('₹${r.amount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      if (!r.isPaid)
                        TextButton(onPressed: () { _wallet.markReminderPaid(reminders.indexOf(r)); setState(() {}); }, child: const Text('Mark Paid', style: TextStyle(color: Colors.green, fontSize: 12))),
                    ]),
                  ]),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}
