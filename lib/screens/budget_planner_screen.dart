import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class BudgetPlannerScreen extends StatefulWidget {
  const BudgetPlannerScreen({super.key});

  @override
  State<BudgetPlannerScreen> createState() => _BudgetPlannerScreenState();
}

class _BudgetPlannerScreenState extends State<BudgetPlannerScreen> {
  final _wallet = WalletService();
  final _amountCtrl = TextEditingController();
  String _selectedCategory = 'Payment';
  final _categories = ['Payment', 'Savings', 'Gift', 'Entertainment', 'Food', 'Shopping', 'Travel', 'Bills', 'Other'];

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Set Budget'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (v) => _selectedCategory = v!,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Monthly Budget (₹)', prefixText: '₹ ', border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final amt = double.tryParse(_amountCtrl.text) ?? 0;
              if (amt <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid amount'), backgroundColor: Colors.red));
                return;
              }
              _wallet.setBudget(_selectedCategory, amt);
              Navigator.pop(ctx);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Budget set for $_selectedCategory'), backgroundColor: Colors.green));
            },
            child: const Text('Set Budget'),
          ),
        ],
      ),
    );
  }

  double _spentOn(String category) {
    final now = DateTime.now();
    double s = 0;
    for (final t in _wallet.transactions) {
      if (t.type == 'Debit' && t.category == category && t.date.month == now.month && t.date.year == now.year) {
        s += t.amount;
      }
    }
    return s;
  }

  @override
  Widget build(BuildContext context) {
    final budgetCategories = _wallet.budgets;
    final totalSpent = _wallet.spentThisMonth;
    final totalBudget = budgetCategories.values.fold(0.0, (s, v) => s + v);

    return Scaffold(
      appBar: AppBar(title: const Text('Budget Planner'), backgroundColor: Colors.green, actions: [
        IconButton(icon: const Icon(Icons.add), onPressed: _showAddDialog),
      ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.green, Colors.teal]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text('Monthly Budget', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  Text('₹${totalSpent.toStringAsFixed(0)} / ₹${totalBudget.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  if (totalBudget > 0)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: (totalSpent / totalBudget).clamp(0, 1),
                        minHeight: 10,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: AlwaysStoppedAnimation(totalSpent > totalBudget ? Colors.red : Colors.amber),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    totalSpent > totalBudget ? '⚠️ Over budget!' : 'On track',
                    style: TextStyle(color: totalSpent > totalBudget ? Colors.red : Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (budgetCategories.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Icon(Icons.account_balance_wallet, size: 60, color: Colors.grey),
                      SizedBox(height: 12),
                      Text('No budgets set. Tap + to add one.', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                ),
              )
            else
              ...budgetCategories.entries.map((entry) {
                final cat = entry.key;
                final budget = entry.value;
                final spent = _spentOn(cat);
                final pct = budget > 0 ? (spent / budget).clamp(0, 1) : 0;
                final isOver = spent > budget;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 5)],
                    border: isOver ? Border.all(color: Colors.red.shade200) : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(cat, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                                onPressed: () { _wallet.removeBudget(cat); setState(() {}); },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: pct,
                          minHeight: 8,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation(isOver ? Colors.red : Colors.green),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('₹${spent.toStringAsFixed(0)} spent', style: TextStyle(color: isOver ? Colors.red : Colors.green, fontWeight: FontWeight.w500, fontSize: 13)),
                          Text('₹${budget.toStringAsFixed(0)} budget', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
