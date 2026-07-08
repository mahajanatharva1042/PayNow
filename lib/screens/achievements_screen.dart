import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  final _wallet = WalletService();
  int _unlockedCount = 0;
  int _totalCount = 0;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    final a = _wallet.achievements;
    _unlockedCount = a.where((a) => a.isUnlocked).length;
    _totalCount = a.length;
  }

  @override
  Widget build(BuildContext context) {
    final achievements = _wallet.achievements;
    _refresh();

    return Scaffold(
      appBar: AppBar(title: const Text('Achievements'), backgroundColor: Colors.amber.shade800),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.amber.shade800, Colors.amber.shade600]),
            ),
            child: Column(
              children: [
                const Icon(Icons.emoji_events, size: 50, color: Colors.white),
                const SizedBox(height: 8),
                Text('$_unlockedCount / $_totalCount', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                const Text('Badges Unlocked', style: TextStyle(color: Colors.white70, fontSize: 14)),
                if (_totalCount > 0) ...[
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: _unlockedCount / _totalCount,
                      minHeight: 8,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: achievements.isEmpty
                ? const Center(child: Text('No achievements yet', style: TextStyle(fontSize: 16, color: Colors.grey)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: achievements.length,
                    itemBuilder: (_, i) {
                      final a = achievements[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 5)],
                          border: a.isUnlocked ? Border.all(color: Colors.amber.shade300, width: 2) : null,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50, height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: a.isUnlocked ? Colors.amber.shade100 : Colors.grey.shade200,
                              ),
                              child: Icon(a.icon, color: a.isUnlocked ? Colors.amber.shade800 : Colors.grey, size: 28),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(a.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: a.isUnlocked ? Colors.black : Colors.grey)),
                                  const SizedBox(height: 2),
                                  Text(a.description, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                                ],
                              ),
                            ),
                            Icon(
                              a.isUnlocked ? Icons.check_circle : Icons.lock_outline,
                              color: a.isUnlocked ? Colors.green : Colors.grey,
                              size: 28,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
