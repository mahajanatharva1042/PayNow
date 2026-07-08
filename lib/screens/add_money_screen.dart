import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _wallet = WalletService();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Money'),
        backgroundColor: Colors.cyanAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.account_balance_wallet, size: 80, color: Colors.blue),
                const SizedBox(height: 20),
                Text(
                  'Current Balance: ₹${_wallet.balance.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Amount',
                    prefixText: '₹ ',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.money),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter amount';
                    final amt = double.tryParse(v);
                    if (amt == null || amt <= 0) return 'Enter valid amount';
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final amt = double.parse(_amountController.text);
                        _wallet.addMoney(amt);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('₹${amt.toStringAsFixed(0)} added successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context, true);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Add Money', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
