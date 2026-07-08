import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class InvestmentPortfolioScreen extends StatefulWidget {
  const InvestmentPortfolioScreen({super.key});
  @override
  State<InvestmentPortfolioScreen> createState() => _InvestmentPortfolioScreenState();
}

class _InvestmentPortfolioScreenState extends State<InvestmentPortfolioScreen> {
  final _wallet = WalletService();
  final _nameCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  String _type = 'Mutual Fund';
  final _types = ['Mutual Fund', 'Stock', 'Fixed Deposit', 'Gold', 'Bonds', 'Crypto'];

  @override
  void dispose() { _nameCtrl.dispose(); _amountCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final invs = _wallet.investments;
    return Scaffold(
      appBar: AppBar(title: const Text('Investment Portfolio'), backgroundColor: Colors.purple),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity, padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.purple, Colors.deepPurple]), borderRadius: BorderRadius.circular(16)),
              child: Column(children: [
                const Text('Portfolio Value', style: TextStyle(color: Colors.white70, fontSize: 14)),
                Text('₹${_wallet.totalInvestmentValue.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(_wallet.investmentReturns >= 0 ? Icons.trending_up : Icons.trending_down, color: _wallet.investmentReturns >= 0 ? Colors.green : Colors.red, size: 20),
                  const SizedBox(width: 4),
                  Text('${_wallet.investmentReturns >= 0 ? '+' : ''}₹${_wallet.investmentReturns.toStringAsFixed(0)} (${_wallet.totalInvested > 0 ? (_wallet.investmentReturns / _wallet.totalInvested * 100).toStringAsFixed(1) : '0'}%)', style: TextStyle(color: _wallet.investmentReturns >= 0 ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
                ]),
                const SizedBox(height: 8),
                Text('Invested: ₹${_wallet.totalInvested.toStringAsFixed(0)}', style: TextStyle(color: Colors.white70, fontSize: 14)),
              ]),
            ),
            const SizedBox(height: 20),
            const Text('New Investment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(value: _type, decoration: InputDecoration(labelText: 'Type', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), items: _types.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(), onChanged: (v) => _type = v!),
            const SizedBox(height: 12),
            TextField(controller: _nameCtrl, decoration: InputDecoration(labelText: 'Investment Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.business))),
            const SizedBox(height: 12),
            TextField(controller: _amountCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Amount (₹)', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.money))),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton.icon(
              onPressed: () {
                final amt = double.tryParse(_amountCtrl.text) ?? 0;
                if (_nameCtrl.text.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter investment name'), backgroundColor: Colors.red)); return; }
                final result = _wallet.addInvestment(_nameCtrl.text, _type, amt);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result == 'Success' ? 'Investment added!' : result), backgroundColor: result == 'Success' ? Colors.green : Colors.red));
                if (result == 'Success') { _nameCtrl.clear(); _amountCtrl.clear(); }
                setState(() {});
              },
              icon: const Icon(Icons.add_circle), label: const Text('Invest Now', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            )),
            if (invs.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text('Your Investments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...invs.reversed.map((inv) => Container(
                margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 5)]),
                child: Row(children: [
                  Container(width: 45, height: 45, decoration: BoxDecoration(color: inv.returns >= 0 ? Colors.green.shade50 : Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
                    child: Icon(Icons.trending_up, color: inv.returns >= 0 ? Colors.green : Colors.red)),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(inv.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(inv.type, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                  ])),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('₹${inv.currentValue.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('${inv.returns >= 0 ? '+' : ''}${inv.returnsPercent.toStringAsFixed(1)}%', style: TextStyle(color: inv.returns >= 0 ? Colors.green : Colors.red, fontSize: 13, fontWeight: FontWeight.bold)),
                  ]),
                ]),
              )),
            ],
          ],
        ),
      ),
    );
  }
}
