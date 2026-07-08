import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _wallet = WalletService();

  IconData _iconForTitle(String t) {
    if (t.contains('Payment Sent') || t.contains('Payment Received')) return Icons.swap_horiz;
    if (t.contains('Daily Check-in') || t.contains('Checked in')) return Icons.login;
    if (t.contains('Loan')) return Icons.account_balance;
    if (t.contains('Investment')) return Icons.trending_up;
    if (t.contains('Referral')) return Icons.people;
    if (t.contains('Reminder')) return Icons.alarm;
    return Icons.notifications;
  }

  Color _colorForTitle(String t) {
    if (t.contains('Sent') || t.contains('Debit')) return Colors.red;
    if (t.contains('Received') || t.contains('Credit')) return Colors.green;
    if (t.contains('Loan')) return Colors.blue;
    if (t.contains('Investment')) return Colors.purple;
    if (t.contains('Referral') || t.contains('Check-in')) return Colors.amber;
    return Colors.blueGrey;
  }

  @override
  Widget build(BuildContext context) {
    final notifs = _wallet.notifications;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.blueGrey,
        actions: [TextButton(onPressed: () { _wallet.markAllRead(); setState(() {}); }, child: const Text('Mark all read', style: TextStyle(color: Colors.white)))],
      ),
      body: notifs.isEmpty
          ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.notifications_off, size: 80, color: Colors.grey), SizedBox(height: 16), Text('No notifications', style: TextStyle(fontSize: 18, color: Colors.grey))]))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifs.length,
              itemBuilder: (_, i) {
                final n = notifs[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: n.isRead ? Colors.white : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: n.isRead ? null : Border.all(color: Colors.blue.shade200),
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 40, height: 40, decoration: BoxDecoration(color: _colorForTitle(n.title).withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                        child: Icon(_iconForTitle(n.title), color: _colorForTitle(n.title), size: 22)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(n.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: n.isRead ? Colors.grey.shade700 : Colors.black)),
                        const SizedBox(height: 4),
                        Text(n.body, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                      ])),
                      GestureDetector(
                        onTap: () { _wallet.markNotificationRead(i); setState(() {}); },
                        child: Icon(n.isRead ? Icons.check_circle : Icons.circle, size: 18, color: n.isRead ? Colors.green : Colors.blue.shade300),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
