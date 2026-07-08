import 'package:flutter/material.dart';
import 'package:paykaro/services/wallet_service.dart';

class CreditScoreScreen extends StatelessWidget {
  const CreditScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = WalletService();
    final txnCount = wallet.transactions.length;
    final hasLoans = wallet.loanApplications.any((l) => l.status == 'Approved');
    final hasGoals = wallet.savingsGoals.isNotEmpty;
    final totalSpent = wallet.totalSpent;

    int score = 600;
    if (txnCount > 0) score += 50;
    if (txnCount > 5) score += 50;
    if (txnCount > 20) score += 50;
    if (hasGoals) score += 50;
    if (totalSpent > 10000) score += 50;
    if (wallet.balance > 10000) score += 50;
    if (hasLoans) score += 50;
    if (wallet.referralCount > 0) score += 30;
    if (wallet.checkinStreak > 7) score += 50;
    if (wallet._achievements.where((a) => a.isUnlocked).length > 5) score += 50;
    score = score.clamp(300, 900);

    String grade;
    Color color;
    if (score >= 800) { grade = 'Excellent'; color = Colors.green; }
    else if (score >= 700) { grade = 'Good'; color = Colors.lightGreen; }
    else if (score >= 600) { grade = 'Fair'; color = Colors.orange; }
    else if (score >= 500) { grade = 'Poor'; color = Colors.deepOrange; }
    else { grade = 'Bad'; color = Colors.red; }

    final factors = [
      _factor('Payment History', txnCount > 0, '${txnCount} transactions'),
      _factor('Savings Goals', hasGoals, '${wallet.savingsGoals.length} goals'),
      _factor('Loan History', hasLoans, 'Loan taken'),
      _factor('Referral Activity', wallet.referralCount > 0, '${wallet.referralCount} referrals'),
      _factor('Check-in Streak', wallet.checkinStreak > 7, '${wallet.checkinStreak} days'),
      _factor('Wallet Balance', wallet.balance > 10000, '₹${wallet.balance.toStringAsFixed(0)}'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Credit Score'), backgroundColor: Colors.blue.shade900),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity, padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue.shade900, Colors.blue.shade700]), borderRadius: BorderRadius.circular(16)),
              child: Column(children: [
                const Text('Your Credit Score', style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 8),
                Text('$score', style: TextStyle(color: color, fontSize: 56, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(grade, style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: (score - 300) / 600, minHeight: 10,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation(color),
                  ),
                ),
                const SizedBox(height: 8),
                Text('Score range: 300 - 900', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ]),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity, padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 5)]),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Score Factors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ...factors.map((f) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(children: [
                  Icon(f['icon'] as bool ? Icons.check_circle : Icons.cancel, color: f['icon'] as bool ? Colors.green : Colors.red, size: 20),
                  const SizedBox(width: 10),
                  Expanded(child: Text(f['label'] as String, style: TextStyle(color: Colors.grey.shade700))),
                  Text(f['value'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ]))),
              ]),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16), decoration: BoxDecoration(
                color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade200)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('💡 Improve your score', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _tip('Make regular transactions'),
                _tip('Maintain savings goals'),
                _tip('Keep a healthy wallet balance'),
                _tip('Build a daily check-in streak'),
                _tip('Refer friends to earn rewards'),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _factor(String label, bool positive, String value) => {'label': label, 'icon': positive, 'value': value};
  Widget _tip(String t) => Padding(padding: const EdgeInsets.symmetric(vertical: 3), child: Row(children: [const Icon(Icons.check, size: 16, color: Colors.blue), const SizedBox(width: 8), Expanded(child: Text(t, style: const TextStyle(fontSize: 13)))]));
}
