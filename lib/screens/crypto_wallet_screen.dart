import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class CryptoWalletScreen extends StatefulWidget {
  const CryptoWalletScreen({super.key});
  @override
  State<CryptoWalletScreen> createState() => _CryptoWalletScreenState();
}

class _CryptoWalletScreenState extends State<CryptoWalletScreen> {
  final _wallet = WalletService();
  int _tab = 0;

  void _refresh() => setState(() {});
  @override
  void initState() { super.initState(); _wallet.addListener(_refresh); }
  @override
  void dispose() { _wallet.removeListener(_refresh); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Wallet'), backgroundColor: Colors.amber.shade900),
      body: Column(children: [
        Container(width: double.infinity, padding: const EdgeInsets.all(12), color: Colors.amber.shade50,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text('Crypto: ₹${_wallet.cryptoHoldings.fold(0.0, (s, c) => s + c.currentValue).toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Cash: ₹${_wallet.balance.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
          ]),
        ),
        Row(children: [
          Expanded(child: _tabBtn('Market', 0)), Expanded(child: _tabBtn('Wallet', 1)), Expanded(child: _tabBtn('Trade', 2)),
        ]),
        Expanded(child: _tab == 0 ? _marketView() : _tab == 1 ? _walletView() : _tradeView()),
      ]),
    );
  }

  Widget _tabBtn(String l, int i) => GestureDetector(
    onTap: () => setState(() => _tab = i),
    child: Container(padding: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _tab == i ? Colors.amber.shade900 : Colors.transparent, width: 3))),
      child: Text(l, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: _tab == i ? Colors.amber.shade900 : Colors.grey))),
  );

  String _formatCrypto(double val) {
    if (val >= 1) return val.toStringAsFixed(4);
    if (val >= 0.001) return val.toStringAsFixed(6);
    return val.toStringAsFixed(8);
  }

  Widget _marketView() {
    return ListView(children: _wallet.cryptoPrices.entries.map((e) {
      final sym = e.key;
      final holding = _wallet.cryptoHoldings.where((c) => c.symbol == sym).fold(0.0, (s, c) => s + c.quantity);
      return Card(margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.amber.shade100, child: Text(sym[0], style: const TextStyle(fontWeight: FontWeight.bold))),
        title: Text('$sym (${_name(sym)})', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('₹${e.value.toStringAsFixed(0)}  |  Hold: $_formatCrypto($holding)'),
        trailing: holding > 0
          ? Text('₹${(holding * e.value).toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green))
          : null,
      ));
    }).toList()..add(const Card(child: SizedBox(height: 80))));
  }

  Widget _walletView() {
    if (_wallet.cryptoHoldings.isEmpty) return const Center(child: Text('No crypto bought yet', style: TextStyle(fontSize: 16, color: Colors.grey)));
    return ListView(children: _wallet.cryptoHoldings.where((c) => c.quantity > 0).map((c) {
      final price = _wallet.cryptoPrices[c.symbol] ?? c.buyPrice;
      final pl = (price - c.buyPrice) * c.quantity;
      return Card(margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.amber.shade100, child: Text(c.symbol[0], style: const TextStyle(fontWeight: FontWeight.bold))),
        title: Text(c.symbol, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$_formatCrypto(${c.quantity}) × ₹$price'),
        trailing: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text('₹${c.currentValue.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('P&L: ₹${pl.toStringAsFixed(0)}', style: TextStyle(fontSize: 12, color: pl >= 0 ? Colors.green : Colors.red)),
        ]),
      ));
    }).toList()..add(const Card(child: SizedBox(height: 80))));
  }

  Widget _tradeView() {
    String? selected;
    final qtyCtrl = TextEditingController(text: '0.001');
    return StatefulBuilder(builder: (context, setST) => ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Buy / Sell Crypto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      DropdownButtonFormField<String>(decoration: InputDecoration(labelText: 'Select Crypto', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        items: _wallet.cryptoPrices.keys.map((s) => DropdownMenuItem(value: s, child: Text('$s (${_name(s)}) - ₹${_wallet.cryptoPrices[s]!.toStringAsFixed(0)}'))).toList(),
        onChanged: (v) { selected = v; setST(() {}); }),
      const SizedBox(height: 16),
      TextField(controller: qtyCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Quantity', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.numbers))),
      const SizedBox(height: 20),
      Row(children: [
        Expanded(child: ElevatedButton(onPressed: () {
          if (selected == null) return;
          final q = double.tryParse(qtyCtrl.text) ?? 0;
          if (q <= 0) return;
          final r = _wallet.buyCrypto(selected!, q);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(r), backgroundColor: r == 'Success' ? Colors.green : Colors.red));
        }, style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white), child: const Text('Buy'))),
        const SizedBox(width: 12),
        Expanded(child: ElevatedButton(onPressed: () {
          if (selected == null) return;
          final q = double.tryParse(qtyCtrl.text) ?? 0;
          if (q <= 0) return;
          final r = _wallet.sellCrypto(selected!, q);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(r), backgroundColor: r == 'Success' ? Colors.green : Colors.red));
        }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white), child: const Text('Sell'))),
      ]),
    ]));
  }

  String _name(String sym) {
    const names = {'BTC': 'Bitcoin', 'ETH': 'Ethereum', 'BNB': 'Binance Coin', 'SOL': 'Solana', 'XRP': 'Ripple'};
    return names[sym] ?? sym;
  }
}
