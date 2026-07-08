import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class TransactionSearchScreen extends StatefulWidget {
  const TransactionSearchScreen({super.key});
  @override
  State<TransactionSearchScreen> createState() => _TransactionSearchScreenState();
}

class _TransactionSearchScreenState extends State<TransactionSearchScreen> {
  final _wallet = WalletService();
  final _searchCtrl = TextEditingController();
  List<Transaction> _results = [];
  String _filterCategory = 'All';
  String _filterType = 'All';
  final _categories = ['All', 'Payment', 'Savings', 'Deposit', 'Rewards', 'Gift', 'Request', 'Loan', 'Investment'];

  @override
  void initState() {
    super.initState();
    _results = _wallet.transactions;
    _searchCtrl.addListener(_filter);
  }

  void _filter() {
    final query = _searchCtrl.text;
    var filtered = _wallet.transactions;
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      filtered = filtered.where((t) =>
        t.fromTo.toLowerCase().contains(q) || t.category.toLowerCase().contains(q) || t.type.toLowerCase().contains(q) || t.amount.toString().contains(q) || t.note.toLowerCase().contains(q)
      ).toList();
    }
    if (_filterCategory != 'All') filtered = filtered.where((t) => t.category == _filterCategory).toList();
    if (_filterType != 'All') filtered = filtered.where((t) => t.type == _filterType).toList();
    setState(() => _results = filtered);
  }

  @override
  void dispose() { _searchCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Transactions'), backgroundColor: Colors.blueGrey),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)]),
            child: Column(children: [
              TextField(
                controller: _searchCtrl,
                decoration: InputDecoration(
                  hintText: 'Search by name, amount, category...',
                  prefixIcon: const Icon(Icons.search), suffixIcon: _searchCtrl.text.isNotEmpty ? IconButton(icon: const Icon(Icons.clear), onPressed: () { _searchCtrl.clear(); }) : null,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: DropdownButtonFormField<String>(value: _filterCategory, decoration: const InputDecoration(labelText: 'Category', contentPadding: EdgeInsets.symmetric(horizontal: 12)), items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 13)))).toList(), onChanged: (v) { _filterCategory = v!; _filter(); })),
                const SizedBox(width: 8),
                Expanded(child: DropdownButtonFormField<String>(value: _filterType, decoration: const InputDecoration(labelText: 'Type', contentPadding: EdgeInsets.symmetric(horizontal: 12)), items: ['All', 'Credit', 'Debit'].map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 13)))).toList(), onChanged: (v) { _filterType = v!; _filter(); })),
              ]),
            ]),
          ),
          Expanded(
            child: _results.isEmpty
                ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.search_off, size: 60, color: Colors.grey), SizedBox(height: 12), Text('No transactions found', style: TextStyle(fontSize: 16, color: Colors.grey))]))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _results.length,
                    itemBuilder: (_, i) {
                      final t = _results[i];
                      final isCredit = t.type == 'Credit';
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 3)]),
                        child: Row(children: [
                          Container(width: 40, height: 40, decoration: BoxDecoration(color: (isCredit ? Colors.green : Colors.red).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                            child: Icon(isCredit ? Icons.arrow_downward : Icons.arrow_upward, color: isCredit ? Colors.green : Colors.red, size: 20)),
                          const SizedBox(width: 12),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(t.fromTo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            SizedBox(height: 2),
                            Row(children: [
                              Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
                                child: Text(t.category, style: TextStyle(fontSize: 11, color: Colors.grey.shade700))),
                              const SizedBox(width: 6),
                              Text('${t.date.day}/${t.date.month}/${t.date.year}', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                            ]),
                            if (t.note.isNotEmpty) Text(t.note, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                          ])),
                          Text('${isCredit ? '+' : '-'}₹${t.amount.toStringAsFixed(0)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isCredit ? Colors.green : Colors.red)),
                        ]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
