import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class NetWorthScreen extends StatefulWidget {
  const NetWorthScreen({super.key});
  @override
  State<NetWorthScreen> createState() => _NetWorthScreenState();
}

class _NetWorthScreenState extends State<NetWorthScreen> {
  final _wallet = WalletService();
  int _tab = 0;

  void _refresh() => setState(() {});
  @override
  void initState() { super.initState(); _wallet.addListener(_refresh); }
  @override
  void dispose() { _wallet.removeListener(_refresh); super.dispose(); }

  void _addAsset() {
    final nameCtrl = TextEditingController();
    final valCtrl = TextEditingController();
    String cat = 'Property';
    showDialog(context: context, builder: (ctx) => StatefulBuilder(builder: (ctx, st) => AlertDialog(
      title: const Text('Add Asset'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Asset Name', border: OutlineInputBorder())),
        const SizedBox(height: 12),
        TextField(controller: valCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Value (₹)', border: OutlineInputBorder())),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(value: cat, items: 'Property,Vehicle,Investments,Cash,Gold,Other'.split(',').map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (v) => st(() => cat = v!)),
      ]),
      actions: [TextButton(onPressed: () { final r = _wallet.addAsset(nameCtrl.text, cat, double.tryParse(valCtrl.text) ?? 0); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(r))); Navigator.pop(ctx); }, child: const Text('Add'))],
    )));
  }

  void _addLiability() {
    final nameCtrl = TextEditingController();
    final amtCtrl = TextEditingController();
    String cat = 'Loan';
    showDialog(context: context, builder: (ctx) => StatefulBuilder(builder: (ctx, st) => AlertDialog(
      title: const Text('Add Liability'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Liability Name', border: OutlineInputBorder())),
        const SizedBox(height: 12),
        TextField(controller: amtCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Amount (₹)', border: OutlineInputBorder())),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(value: cat, items: 'Loan,Credit Card,Mortgage,Other'.split(',').map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (v) => st(() => cat = v!)),
      ]),
      actions: [TextButton(onPressed: () { final r = _wallet.addLiability(nameCtrl.text, cat, double.tryParse(amtCtrl.text) ?? 0); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(r))); Navigator.pop(ctx); }, child: const Text('Add'))],
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Net Worth Tracker'), backgroundColor: Colors.deepPurple, actions: [
        IconButton(icon: const Icon(Icons.add), tooltip: 'Add Asset', onPressed: _addAsset),
        PopupMenuButton(itemBuilder: (_) => [const PopupMenuItem(value: 1, child: Text('Add Liability'))], onSelected: (_) => _addLiability()),
      ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.deepPurple, Colors.purple]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              const Text('Net Worth', style: TextStyle(color: Colors.white70, fontSize: 14)),
              Text('₹${_wallet.netWorth.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text('Assets: ₹${_wallet.totalAssets.toStringAsFixed(0)}', style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                Text('Liabilities: ₹${_wallet.totalLiabilities.toStringAsFixed(0)}', style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(child: _tabBtn('Assets', 0)), Expanded(child: _tabBtn('Liabilities', 1)),
          ]),
          const SizedBox(height: 12),
          if (_tab == 0) ...[
            if (_wallet.assets.isEmpty) const Center(child: Padding(padding: EdgeInsets.all(20), child: Text('No assets added', style: TextStyle(color: Colors.grey)))),
            ..._wallet.assets.asMap().entries.map((e) => Card(margin: const EdgeInsets.symmetric(vertical: 4), child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.green.shade100, child: const Icon(Icons.account_balance, color: Colors.green)),
              title: Text(e.value.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${e.value.category}'),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                Text('₹${e.value.value.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {
                  final ctrl = TextEditingController(text: e.value.value.toStringAsFixed(0));
                  showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text('Update Value'), content: TextField(controller: ctrl, keyboardType: TextInputType.number), actions: [TextButton(onPressed: () { _wallet.updateAssetValue(e.key, double.tryParse(ctrl.text) ?? e.value.value); Navigator.pop(ctx); }, child: const Text('Update'))]));
                }),
                IconButton(icon: const Icon(Icons.delete, size: 18, color: Colors.red), onPressed: () { _wallet.removeAsset(e.key); }),
              ]),
            ))),
          ],
          if (_tab == 1) ...[
            if (_wallet.liabilities.isEmpty) const Center(child: Padding(padding: EdgeInsets.all(20), child: Text('No liabilities added', style: TextStyle(color: Colors.grey)))),
            ..._wallet.liabilities.asMap().entries.map((e) => Card(margin: const EdgeInsets.symmetric(vertical: 4), child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.red.shade100, child: const Icon(Icons.warning, color: Colors.red)),
              title: Text(e.value.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${e.value.category}'),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                Text('₹${e.value.amount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red)),
                IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {
                  final ctrl = TextEditingController(text: e.value.amount.toStringAsFixed(0));
                  showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text('Update Amount'), content: TextField(controller: ctrl, keyboardType: TextInputType.number), actions: [TextButton(onPressed: () { _wallet.updateLiabilityAmount(e.key, double.tryParse(ctrl.text) ?? e.value.amount); Navigator.pop(ctx); }, child: const Text('Update'))]));
                }),
                IconButton(icon: const Icon(Icons.delete, size: 18, color: Colors.red), onPressed: () { _wallet.removeLiability(e.key); }),
              ]),
            ))),
          ],
        ]),
      ),
    );
  }

  Widget _tabBtn(String l, int i) => GestureDetector(
    onTap: () => setState(() => _tab = i),
    child: Container(padding: const EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _tab == i ? Colors.deepPurple : Colors.transparent, width: 3))),
      child: Text(l, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: _tab == i ? Colors.deepPurple : Colors.grey))),
  );
}
