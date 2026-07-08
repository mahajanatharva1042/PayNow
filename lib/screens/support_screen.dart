import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _wallet = WalletService();
  final _subjectCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  @override
  void dispose() {
    _subjectCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tickets = _wallet.supportTickets;

    return Scaffold(
      appBar: AppBar(title: const Text('Customer Support'), backgroundColor: Colors.blueGrey),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.blueGrey, Colors.blueGrey.shade700]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(Icons.support_agent, size: 50, color: Colors.white),
                const SizedBox(height: 8),
                const Text('Need help?', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const Text('We typically respond within 24 hours', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Create Ticket', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(
            controller: _subjectCtrl,
            decoration: InputDecoration(labelText: 'Subject', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.title)),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _messageCtrl,
            maxLines: 4,
            decoration: InputDecoration(labelText: 'Describe your issue', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), prefixIcon: const Icon(Icons.message), alignLabelWithHint: true),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity, height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                final result = _wallet.createTicket(_subjectCtrl.text, _messageCtrl.text);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result == 'Success' ? 'Ticket created! We will get back to you soon.' : result), backgroundColor: result == 'Success' ? Colors.green : Colors.red));
                if (result == 'Success') { _subjectCtrl.clear(); _messageCtrl.clear(); }
                setState(() {});
              },
              icon: const Icon(Icons.send),
              label: const Text('Submit Ticket', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            ),
          ),
          if (tickets.isNotEmpty) ...[
            const SizedBox(height: 24),
            const Text('Your Tickets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...tickets.reversed.map((t) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 5)],
                border: Border.all(color: t.status == 'Open' ? Colors.orange.shade200 : Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(t.subject, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: t.status == 'Open' ? Colors.orange.shade50 : Colors.green.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(t.status, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: t.status == 'Open' ? Colors.orange : Colors.green)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(t.message, style: TextStyle(color: Colors.grey.shade700, fontSize: 14)),
                  if (t.response.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.support_agent, size: 18, color: Colors.blueGrey),
                          const SizedBox(width: 8),
                          Expanded(child: Text(t.response, style: TextStyle(color: Colors.blueGrey.shade800, fontSize: 13))),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            )),
          ],
        ],
      ),
    );
  }
}
