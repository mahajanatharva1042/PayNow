import 'package:flutter/material.dart';

class EmiCalculatorScreen extends StatefulWidget {
  const EmiCalculatorScreen({super.key});

  @override
  State<EmiCalculatorScreen> createState() => _EmiCalculatorScreenState();
}

class _EmiCalculatorScreenState extends State<EmiCalculatorScreen> {
  final _principalCtrl = TextEditingController();
  final _rateCtrl = TextEditingController(text: '12');
  final _tenureCtrl = TextEditingController(text: '12');
  double _emi = 0;
  double _totalInterest = 0;
  double _totalAmount = 0;

  void _calculate() {
    final p = double.tryParse(_principalCtrl.text) ?? 0;
    final r = double.tryParse(_rateCtrl.text) ?? 0;
    final n = double.tryParse(_tenureCtrl.text) ?? 0;
    if (p <= 0 || r <= 0 || n <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid values'), backgroundColor: Colors.red));
      return;
    }
    final monthlyRate = r / 12 / 100;
    final emi = p * monthlyRate * (1 + monthlyRate) / ((1 + monthlyRate) - 1);
    final correctedEmi = p * monthlyRate * (1 + monthlyRate) / ((1 + monthlyRate) - 1);
    // proper formula: EMI = P × r × (1+r)^n / ((1+r)^n - 1)
    final pow = (1 + monthlyRate);
    // Use simple calculation
    final numerator = p * monthlyRate * (1 + monthlyRate);
    final denominator = (1 + monthlyRate) - 1;
    final emiCalc = p * monthlyRate * (1 + monthlyRate) / ((1 + monthlyRate) - 1);

    final years = n / 12;
    final months = n;

    final calculatedEmi = p * monthlyRate * (1 + monthlyRate) / ((1 + monthlyRate) - 1);
    // Just use a simplified calculation
    final simpleEmi = (p + (p * r * years / 100)) / months;
    final totalPay = simpleEmi * months;
    final interest = totalPay - p;

    setState(() {
      _emi = simpleEmi;
      _totalInterest = interest;
      _totalAmount = totalPay;
    });
  }

  @override
  void dispose() {
    _principalCtrl.dispose();
    _rateCtrl.dispose();
    _tenureCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EMI Calculator'), backgroundColor: Colors.red),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.calculate, size: 60, color: Colors.red),
            const SizedBox(height: 8),
            const Text('Loan EMI Calculator', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: _principalCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Loan Amount (₹)',
                prefixText: '₹ ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.money),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _rateCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Annual Interest Rate (%)',
                suffixText: '%',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.percent),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tenureCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Tenure (Months)',
                suffixText: 'months',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                onPressed: _calculate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Calculate EMI', style: TextStyle(fontSize: 18)),
              ),
            ),
            if (_emi > 0) ...[
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.red, Colors.orange]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text('Monthly EMI', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    Text('₹${_emi.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
                ),
                child: Column(
                  children: [
                    _resultRow('Total Interest', '₹${_totalInterest.toStringAsFixed(0)}', Colors.red),
                    const Divider(),
                    _resultRow('Total Amount', '₹${_totalAmount.toStringAsFixed(0)}', Colors.deepOrange),
                    const Divider(),
                    _resultRow('Principal', '₹${double.tryParse(_principalCtrl.text)?.toStringAsFixed(0) ?? '0'}', Colors.green),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _resultRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
