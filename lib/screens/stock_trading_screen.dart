import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class StockTradingScreen extends StatefulWidget {
  const StockTradingScreen({super.key});
  @override
  State<StockTradingScreen> createState() => _StockTradingScreenState();
}

class _StockTradingScreenState extends State<StockTradingScreen> {
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
      appBar: AppBar(title: const Text('Stock Trading'), backgroundColor: Colors.indigo, actions: [
        IconButton(icon: const Icon(Icons.trending_up), tooltip: 'Simulate Market Day', onPressed: () { _wallet.simulateStockMarket(); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Market simulated - Day ${_wallet.stockMarketDay}'))); }),
        IconButton(icon: const Icon(Icons.account_balance_wallet), tooltip: 'Balance', onPressed: () => showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Balance'), content: Text('₹${_wallet.balance.toStringAsFixed(0)}')))),
      ]),
      body: Column(children: [
        Container(width: double.infinity, padding: const EdgeInsets.all(12), color: Colors.indigo.shade50,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text('Portfolio: ₹${_wallet.totalStockValue.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Cash: ₹${_wallet.balance.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
          ]),
        ),
        Row(children: [
          Expanded(child: _tabBtn('Market', 0)), Expanded(child: _tabBtn('My Stocks', 1)), Expanded(child: _tabBtn('Trade', 2)),
        ]),
        Expanded(child: _tab == 0 ? _marketView() : _tab == 1 ? _portfolioView() : _tradeView()),
      ]),
    );
  }

  Widget _tabBtn(String l, int i) => GestureDetector(
    onTap: () => setState(() => _tab = i),
    child: Container(padding: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _tab == i ? Colors.indigo : Colors.transparent, width: 3))),
      child: Text(l, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: _tab == i ? Colors.indigo : Colors.grey))),
  );

  Widget _marketView() {
    return ListView(children: _wallet.stockPrices.entries.map((e) => Card(margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: ListTile(
      leading: CircleAvatar(backgroundColor: Colors.indigo.shade100, child: Text(e.key[0], style: const TextStyle(fontWeight: FontWeight.bold))),
      title: Text(e.key, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('₹${e.value.toStringAsFixed(0)}'),
      trailing: _wallet.stockPL(e.key) >= 0
        ? Text('+₹${_wallet.stockPL(e.key).toStringAsFixed(0)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
        : Text('-₹${_wallet.stockPL(e.key).abs().toStringAsFixed(0)}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    ))).toList()..add(const SizedBox(height: 80)));
  }

  Widget _portfolioView() {
    if (_wallet.stocks.isEmpty) return const Center(child: Text('No stocks bought yet', style: TextStyle(fontSize: 16, color: Colors.grey)));
    return ListView(children: _wallet.stocks.where((s) => s.quantity > 0).map((s) => Card(margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: ListTile(
      leading: CircleAvatar(backgroundColor: Colors.green.shade100, child: Text(s.symbol[0], style: const TextStyle(fontWeight: FontWeight.bold))),
      title: Text(s.symbol, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('${s.quantity} shares × ₹${(_wallet.stockPrices[s.symbol] ?? 0).toStringAsFixed(0)}'),
      trailing: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text('₹${(s.quantity * (_wallet.stockPrices[s.symbol] ?? 0)).toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('P&L: ${_wallet.stockPL(s.symbol).toStringAsFixed(0)}', style: TextStyle(fontSize: 12, color: _wallet.stockPL(s.symbol) >= 0 ? Colors.green : Colors.red)),
      ]),
    ))).toList()..add(const SizedBox(height: 80)));
  }

  Widget _tradeView() {
    final symCtrl = TextEditingController();
    final qtyCtrl = TextEditingController(text: '1');
    String? selected;
    return StatefulBuilder(builder: (context, setST) => ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Buy / Sell Stocks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      DropdownButtonFormField<String>(decoration: InputDecoration(labelText: 'Select Stock', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        items: _wallet.stockPrices.keys.map((s) => DropdownMenuItem(value: s, child: Text('$s - ₹${_wallet.stockPrices[s]!.toStringAsFixed(0)}'))).toList(),
        onChanged: (v) { selected = v; setST(() {}); }),
      const SizedBox(height: 16),
      TextField(controller: qtyCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Quantity', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.numbers))),
      const SizedBox(height: 20),
      Row(children: [
        Expanded(child: ElevatedButton(onPressed: () {
          if (selected == null) return;
          final q = int.tryParse(qtyCtrl.text) ?? 0;
          if (q <= 0) return;
          final r = _wallet.buyStock(selected!, q);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(r), backgroundColor: r == 'Success' ? Colors.green : Colors.red));
        }, style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white), child: const Text('Buy'))),
        const SizedBox(width: 12),
        Expanded(child: ElevatedButton(onPressed: () {
          if (selected == null) return;
          final q = int.tryParse(qtyCtrl.text) ?? 0;
          if (q <= 0) return;
          final r = _wallet.sellStock(selected!, q);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(r), backgroundColor: r == 'Success' ? Colors.green : Colors.red));
        }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white), child: const Text('Sell'))),
      ]),
    ]));
  }
}
