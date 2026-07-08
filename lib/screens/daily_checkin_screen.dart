import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class DailyCheckinScreen extends StatefulWidget {
  const DailyCheckinScreen({super.key});
  @override
  State<DailyCheckinScreen> createState() => _DailyCheckinScreenState();
}

class _DailyCheckinScreenState extends State<DailyCheckinScreen> {
  final _wallet = WalletService();

  @override
  Widget build(BuildContext context) {
    final streak = _wallet.checkinStreak;
    final now = DateTime.now();
    final last = _wallet.lastCheckin;
    final checkedInToday = now.year == last.year && now.month == last.month && now.day == last.day;

    return Scaffold(
      appBar: AppBar(title: const Text('Daily Check-in'), backgroundColor: Colors.orange),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity, padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.orange, Colors.deepOrange]), borderRadius: BorderRadius.circular(16)),
              child: Column(children: [
                const Icon(Icons.login, size: 60, color: Colors.white),
                const SizedBox(height: 8),
                const Text('Daily Check-in Bonus', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const Text('Check in daily to earn reward points!', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ]),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity, padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10)]),
              child: Column(children: [
                Text('🔥 $streak', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Day Streak', style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity, height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      final result = _wallet.dailyCheckin();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result), backgroundColor: result.contains('Already') ? Colors.orange : Colors.green));
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: checkedInToday ? Colors.grey : Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(checkedInToday ? 'Checked In ✓' : 'Check In Now!', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 5)]),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Rewards', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _rewardRow('Base points', '10 points'),
                _rewardRow('Streak bonus', '${streak * 2} points (${streak}x streak)'),
                _rewardRow('Total today', '${10 + (streak * 2)} points'),
                const Divider(),
                _rewardRow('Your points', '${_wallet.rewardPoints} points'),
              ]),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orange.shade200)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('💡 Tips', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _tip('Check in daily to build your streak'),
                _tip('Streak bonus increases by 2 points each day'),
                _tip('Reach 7-day streak for a special badge'),
                _tip('Set a reminder to never miss a check-in'),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rewardRow(String l, String v) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: TextStyle(color: Colors.grey.shade700)), Text(v, style: const TextStyle(fontWeight: FontWeight.bold))]));
  Widget _tip(String t) => Padding(padding: const EdgeInsets.symmetric(vertical: 3), child: Row(children: [const Icon(Icons.check, size: 16, color: Colors.orange), const SizedBox(width: 8), Expanded(child: Text(t, style: const TextStyle(fontSize: 13)))],));
}
