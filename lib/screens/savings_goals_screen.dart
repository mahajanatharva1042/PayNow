import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class SavingsGoalsScreen extends StatefulWidget {
  const SavingsGoalsScreen({super.key});

  @override
  State<SavingsGoalsScreen> createState() => _SavingsGoalsScreenState();
}

class _SavingsGoalsScreenState extends State<SavingsGoalsScreen> {
  final _wallet = WalletService();

  void _showCreateDialog() {
    final titleCtrl = TextEditingController();
    final targetCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New Savings Goal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Goal Title', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: targetCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Target Amount (₹)', border: OutlineInputBorder(), prefixText: '₹ ')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final result = _wallet.addSavingGoal(titleCtrl.text, double.tryParse(targetCtrl.text) ?? 0);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result), backgroundColor: result == 'Success' ? Colors.green : Colors.red));
              setState(() {});
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showContributeDialog(String goalId, String title) {
    final amtCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Add to "$title"'),
        content: TextField(controller: amtCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Amount (₹)', border: OutlineInputBorder(), prefixText: '₹ ')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final result = _wallet.contributeToGoal(goalId, double.tryParse(amtCtrl.text) ?? 0);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result), backgroundColor: result == 'Success' ? Colors.green : Colors.red));
              setState(() {});
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final goals = _wallet.savingsGoals;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savings Goals'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _showCreateDialog),
        ],
      ),
      body: goals.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.track_changes, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('No savings goals yet', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _showCreateDialog,
                    icon: const Icon(Icons.add),
                    label: const Text('Create Goal'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: goals.length,
              itemBuilder: (_, i) {
                final g = goals[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.flag, color: Colors.teal),
                          const SizedBox(width: 8),
                          Expanded(child: Text(g.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: g.progress,
                          minHeight: 10,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: const AlwaysStoppedAnimation(Colors.teal),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('₹${g.savedAmount.toStringAsFixed(0)} saved', style: const TextStyle(fontSize: 14, color: Colors.teal)),
                          Text('₹${g.targetAmount.toStringAsFixed(0)} target', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => _showContributeDialog(g.id, g.title),
                          child: const Text('Add Money'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
