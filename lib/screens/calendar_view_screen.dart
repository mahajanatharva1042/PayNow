import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class CalendarViewScreen extends StatefulWidget {
  const CalendarViewScreen({super.key});
  @override
  State<CalendarViewScreen> createState() => _CalendarViewScreenState();
}

class _CalendarViewScreenState extends State<CalendarViewScreen> {
  final _wallet = WalletService();
  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime.now();
  Map<DateTime, List<Transaction>> _txnMap = {};

  @override
  void initState() {
    super.initState();
    _buildMap();
  }

  void _buildMap() {
    _txnMap = {};
    for (final t in _wallet.transactions) {
      final key = DateTime(t.date.year, t.date.month, t.date.day);
      _txnMap.putIfAbsent(key, () => []).add(t);
    }
  }

  List<Transaction> get _selectedTxns => _txnMap[DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day)] ?? [];

  @override
  Widget build(BuildContext context) {
    final first = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final last = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final startWeekday = first.weekday % 7;
    final daysInMonth = last.day;

    return Scaffold(
      appBar: AppBar(title: const Text('Calendar'), backgroundColor: Colors.blue.shade700),
      body: Column(children: [
        Container(padding: const EdgeInsets.all(16), color: Colors.blue.shade700,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(icon: const Icon(Icons.chevron_left, color: Colors.white), onPressed: () { setState(() { _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1); _buildMap(); }); }),
            Text('${_monthName(_currentMonth.month)} ${_currentMonth.year}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(icon: const Icon(Icons.chevron_right, color: Colors.white), onPressed: () { setState(() { _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1); _buildMap(); }); }),
          ])),
        Container(padding: const EdgeInsets.symmetric(vertical: 8), color: Colors.blue.shade100,
          child: Row(children: ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'].map((d) => Expanded(child: Center(child: Text(d, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))))).toList())),
        Expanded(child: Column(children: [
          ...List.generate((startWeekday + daysInMonth + 6) ~/ 7, (week) {
            return Row(children: List.generate(7, (day) {
              final dayNum = week * 7 + day - startWeekday + 1;
              if (dayNum < 1 || dayNum > daysInMonth) return Expanded(child: Container());
              final date = DateTime(_currentMonth.year, _currentMonth.month, dayNum);
              final hasTxn = _txnMap.containsKey(date);
              final isSelected = date.day == _selectedDate.day && date.month == _selectedDate.month && date.year == _selectedDate.year;
              final isToday = date.day == DateTime.now().day && date.month == DateTime.now().month && date.year == DateTime.now().year;
              return Expanded(child: GestureDetector(
                onTap: () => setState(() => _selectedDate = date),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : isToday ? Colors.blue.shade50 : null,
                    borderRadius: BorderRadius.circular(8),
                    border: hasTxn ? Border.all(color: isSelected ? Colors.white : Colors.blue.shade300, width: 1.5) : null,
                  ),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('$dayNum', style: TextStyle(fontSize: 14, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? Colors.white : Colors.black)),
                    if (hasTxn) Container(width: 6, height: 6, decoration: BoxDecoration(color: isSelected ? Colors.white : Colors.blue, shape: BoxShape.circle)),
                    if (hasTxn) Text('₹${(_txnMap[date]!.fold(0.0, (s, t) => s + t.amount)).toStringAsFixed(0)}', style: TextStyle(fontSize: 8, color: isSelected ? Colors.white70 : Colors.grey)),
                  ]),
                ),
              ));
            }));
          }),
          const Divider(),
          Expanded(child: _selectedTxns.isEmpty
            ? const Center(child: Text('No transactions on this day', style: TextStyle(color: Colors.grey)))
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _selectedTxns.length,
                itemBuilder: (_, i) {
                  final t = _selectedTxns[i];
                  final isCredit = t.type == 'Credit';
                  return Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 3)]),
                    child: Row(children: [
                      Container(width: 36, height: 36, decoration: BoxDecoration(color: (isCredit ? Colors.green : Colors.red).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: Icon(isCredit ? Icons.arrow_downward : Icons.arrow_upward, color: isCredit ? Colors.green : Colors.red, size: 18)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(t.fromTo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text('${t.category} • ${t.date.hour}:${t.date.minute.toString().padLeft(2, '0')}', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                      ])),
                      Text('${isCredit ? '+' : '-'}₹${t.amount.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.bold, color: isCredit ? Colors.green : Colors.red)),
                    ]),
                  );
                },
              )),
        ])),
      ]),
    );
  }

  String _monthName(int m) => ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][m - 1];
}
