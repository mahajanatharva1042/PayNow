import 'package:flutter/material.dart';
import 'package:paykaro/services/wallet_service.dart';

class LightBill extends StatelessWidget {
  const LightBill({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Light Bill", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.cyanAccent,
      ),
      body: const Center(
        child: Text("Light bill payment - Coming soon", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class AddCart extends StatelessWidget {
  const AddCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Cart", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.cyanAccent,
      ),
      body: const Center(
        child: Text("Shopping cart - Coming soon", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class Recharge extends StatelessWidget {
  const Recharge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recharge", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.cyanAccent,
      ),
      body: const Center(
        child: Text("Mobile recharge - Coming soon", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class YourBusiness extends StatelessWidget {
  const YourBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Business", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.cyanAccent,
      ),
      body: const Center(
        child: Text("Business services - Coming soon", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class Balance extends StatelessWidget {
  const Balance({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = WalletService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Balance", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.cyanAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_balance_wallet, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text("Available Balance", style: TextStyle(fontSize: 20, color: Colors.grey)),
            const SizedBox(height: 10),
            Text(
              "₹${wallet.balance.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chart", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.cyanAccent,
      ),
      body: const Center(
        child: Text("Analytics chart - Coming soon", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class Unit extends StatelessWidget {
  const Unit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Units", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.cyanAccent,
      ),
      body: const Center(
        child: Text("Unit tracking - Coming soon", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = WalletService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Wallet", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.cyanAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_balance_wallet, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text("Wallet Balance", style: TextStyle(fontSize: 20, color: Colors.grey)),
            const SizedBox(height: 10),
            Text(
              "₹${wallet.balance.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  final String name;
  final String userId;

  const UserProfile({super.key, required this.name, required this.userId});

  @override
  Widget build(BuildContext context) {
    final wallet = WalletService();
    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.cyanAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                name.split(' ').map((e) => e[0]).take(2).join(),
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            Text(name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('User ID: $userId', style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text('Your Balance', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(
                    '₹${wallet.balance.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class User1 extends StatelessWidget {
  const User1({super.key});

  @override
  Widget build(BuildContext context) => const UserProfile(name: 'User 1', userId: 'USR001');
}

class User2 extends StatelessWidget {
  const User2({super.key});

  @override
  Widget build(BuildContext context) => const UserProfile(name: 'User 2', userId: 'USR002');
}

class User3 extends StatelessWidget {
  const User3({super.key});

  @override
  Widget build(BuildContext context) => const UserProfile(name: 'User 3', userId: 'USR003');
}

class User4 extends StatelessWidget {
  const User4({super.key});

  @override
  Widget build(BuildContext context) => const UserProfile(name: 'User 4', userId: 'USR004');
}

class User5 extends StatelessWidget {
  const User5({super.key});

  @override
  Widget build(BuildContext context) => const UserProfile(name: 'User 5', userId: 'USR005');
}

class User6 extends StatelessWidget {
  const User6({super.key});

  @override
  Widget build(BuildContext context) => const UserProfile(name: 'User 6', userId: 'USR006');
}
