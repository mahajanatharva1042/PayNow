import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final _wallet = WalletService();
  final _amountCtrl = TextEditingController();
  String _fromCurrency = 'INR';
  String _toCurrency = 'USD';
  double _result = 0;
  bool _isINRSource = true;

  final _currencies = ['INR', 'USD', 'EUR', 'GBP', 'JPY', 'AED'];
  final _flags = {'INR': '🇮🇳', 'USD': '🇺🇸', 'EUR': '🇪🇺', 'GBP': '🇬🇧', 'JPY': '🇯🇵', 'AED': '🇦🇪'};

  void _convert() {
    final amount = double.tryParse(_amountCtrl.text) ?? 0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid amount'), backgroundColor: Colors.red));
      return;
    }
    double inr;
    if (_fromCurrency == 'INR') {
      inr = amount;
    } else {
      inr = _wallet.convertToINR(amount, _fromCurrency);
    }

    if (_toCurrency == 'INR') {
      _result = inr;
    } else {
      _result = _wallet.convertFromINR(inr, _toCurrency);
    }
    setState(() {});
  }

  void _swap() {
    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
      if (_amountCtrl.text.isNotEmpty) _convert();
    });
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currency Converter'), backgroundColor: Colors.teal),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: Column(
                children: [
                  const Icon(Icons.currency_exchange, size: 50, color: Colors.teal),
                  const SizedBox(height: 8),
                  const Text('Real-time exchange rates', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 12),
                  _rateRow('USD', '\$${_wallet.usdRate.toStringAsFixed(4)}'),
                  _rateRow('EUR', '€${_wallet.eurRate.toStringAsFixed(4)}'),
                  _rateRow('GBP', '£${_wallet.gbpRate.toStringAsFixed(4)}'),
                  _rateRow('JPY', '¥${_wallet.jpyRate.toStringAsFixed(2)}'),
                  _rateRow('AED', 'د.إ${_wallet.aedRate.toStringAsFixed(4)}'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _amountCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                prefixText: '${_flags[_fromCurrency]} ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (_) => _convert(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _fromCurrency,
                    decoration: InputDecoration(
                      labelText: 'From',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: _currencies.map((c) => DropdownMenuItem(value: c, child: Text('${_flags[c]} $c'))).toList(),
                    onChanged: (v) { _fromCurrency = v!; _convert(); },
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: _swap,
                  icon: const Icon(Icons.swap_horiz, size: 36, color: Colors.teal),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _toCurrency,
                    decoration: InputDecoration(
                      labelText: 'To',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: _currencies.map((c) => DropdownMenuItem(value: c, child: Text('${_flags[c]} $c'))).toList(),
                    onChanged: (v) { _toCurrency = v!; _convert(); },
                  ),
                ),
              ],
            ),
            if (_result > 0) ...[
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.teal, Colors.green]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text('${_flags[_fromCurrency]} ${_amountCtrl.text} ${_fromCurrency}', style: const TextStyle(color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 8),
                    Text('${_flags[_toCurrency]} ${_result.toStringAsFixed(2)} ${_toCurrency}', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _rateRow(String code, String rate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${_flags[code]} $code', style: const TextStyle(fontWeight: FontWeight.w500)),
          Text('1 INR = $rate', style: TextStyle(color: Colors.teal.shade700)),
        ],
      ),
    );
  }
}
