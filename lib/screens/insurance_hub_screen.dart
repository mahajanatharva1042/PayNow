import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class InsuranceHubScreen extends StatefulWidget {
  const InsuranceHubScreen({super.key});
  @override
  State<InsuranceHubScreen> createState() => _InsuranceHubScreenState();
}

class _InsuranceHubScreenState extends State<InsuranceHubScreen> {
  final _wallet = WalletService();
  String _selectedType = 'Health';
  String _selectedProvider = 'LIC';
  final _types = ['Health', 'Life', 'Travel', 'Vehicle', 'Property'];
  final _providers = ['LIC', 'HDFC Life', 'ICICI Prudential', 'SBI Life', 'Bajaj Allianz', 'Tata AIA', 'Max Life'];
  final _premiums = {'Health': 5000, 'Life': 8000, 'Travel': 1500, 'Vehicle': 12000, 'Property': 10000};
  final _coverages = {'Health': 500000, 'Life': 1000000, 'Travel': 100000, 'Vehicle': 500000, 'Property': 2000000};
  final _tenures = {'Health': '1 Year', 'Life': '20 Years', 'Travel': '1 Year', 'Vehicle': '3 Years', 'Property': '5 Years'};

  @override
  Widget build(BuildContext context) {
    final policies = _wallet.insurancePolicies;
    return Scaffold(
      appBar: AppBar(title: const Text('Insurance Hub'), backgroundColor: Colors.blue.shade900),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue.shade900, Colors.blue.shade700]), borderRadius: BorderRadius.circular(16)),
            child: Column(children: [
              const Icon(Icons.health_and_safety, size: 50, color: Colors.white),
              const SizedBox(height: 8),
              const Text('Insurance Plans', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              Text('${policies.length} active policies', style: TextStyle(color: Colors.white70, fontSize: 13)),
            ])),
          const SizedBox(height: 20),
          const Text('Buy Insurance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(value: _selectedType, decoration: InputDecoration(labelText: 'Insurance Type', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), items: _types.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(), onChanged: (v) => setState(() => _selectedType = v!)),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(value: _selectedProvider, decoration: InputDecoration(labelText: 'Provider', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), items: _providers.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(), onChanged: (v) => setState(() => _selectedProvider = v!)),
          const SizedBox(height: 12),
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade200)),
            child: Column(children: [
              _planRow('Type', _selectedType),
              _planRow('Premium', '₹${_premiums[_selectedType]}/-'),
              _planRow('Coverage', 'Up to ₹${_coverages[_selectedType]}/-'),
              _planRow('Tenure', _tenures[_selectedType] ?? ''),
            ])),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton.icon(
            onPressed: () {
              final premium = _premiums[_selectedType]!.toDouble();
              final coverage = _coverages[_selectedType]!.toDouble();
              final tenure = _tenures[_selectedType]!;
              final result = _wallet.buyInsurance(_selectedType, _selectedProvider, premium, coverage, tenure);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result == 'Success' ? 'Policy purchased!' : result), backgroundColor: result == 'Success' ? Colors.green : Colors.red));
              setState(() {});
            },
            icon: const Icon(Icons.shield), label: const Text('Buy Policy', style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          )),
          if (policies.isNotEmpty) ...[
            const SizedBox(height: 24), const Text('Your Policies', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 12),
            ...policies.reversed.map((p) => Container(
              margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 5)],
                border: Border.all(color: p.isActive ? Colors.blue.shade200 : Colors.grey.shade300)),
              child: Row(children: [
                Container(width: 45, height: 45, decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
                  child: Icon(Icons.shield, color: Colors.blue.shade700)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('${p.type} Insurance', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text('${p.provider} • ${p.tenure}', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  Text('Coverage: ₹${p.coverage.toStringAsFixed(0)}', style: TextStyle(color: Colors.blue.shade700, fontSize: 12, fontWeight: FontWeight.w500)),
                ])),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: p.isActive ? Colors.green.shade50 : Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                    child: Text(p.isActive ? 'Active' : 'Inactive', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: p.isActive ? Colors.green : Colors.grey))),
                  const SizedBox(height: 4),
                  Text('₹${p.premium.toStringAsFixed(0)}/yr', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                ]),
              ]),
            )),
          ],
        ]),
      ),
    );
  }
  Widget _planRow(String l, String v) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l, style: TextStyle(color: Colors.grey.shade700)), Text(v, style: const TextStyle(fontWeight: FontWeight.bold))]));
}
