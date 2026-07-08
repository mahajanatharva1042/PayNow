import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class PaymentReceiptScreen extends StatelessWidget {
  final String recipient;
  final double amount;
  final String transactionId;

  const PaymentReceiptScreen({
    super.key,
    required this.recipient,
    required this.amount,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    final wallet = WalletService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Receipt'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 15)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.check, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text('Payment Successful', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
                const SizedBox(height: 20),
                Text('₹${amount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Sent to $recipient', style: const TextStyle(fontSize: 18, color: Colors.grey)),
                const Divider(height: 40),
                _row('Transaction ID', transactionId),
                _row('Date', DateTime.now().toString().substring(0, 19)),
                _row('Remaining Balance', '₹${wallet.balance.toStringAsFixed(0)}'),
                _row('Cashback Earned', '${(amount * 0.01).floor()} pts'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        ],
      ),
    );
  }
}
