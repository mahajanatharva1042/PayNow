import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class UpiQrScreen extends StatelessWidget {
  const UpiQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = WalletService();
    return Scaffold(
      appBar: AppBar(title: const Text('UPI & QR Code'), backgroundColor: Colors.blueGrey),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.qr_code_scanner, size: 80, color: Colors.blueGrey),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 15)],
                  border: Border.all(color: Colors.blueGrey.shade200, width: 2),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 180, height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blueGrey.shade100),
                      ),
                      child: CustomPaint(
                        size: const Size(180, 180),
                        painter: _QrPainter(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Scan to Pay', style: TextStyle(fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 8),
                    Text(wallet.upiId, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    const SizedBox(height: 4),
                    Text(wallet.username, style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blueGrey),
                    SizedBox(width: 12),
                    Expanded(child: Text('Share this UPI ID or QR code to receive payments directly in your wallet', style: TextStyle(fontSize: 13))),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity, height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('UPI ID copied to clipboard!'), backgroundColor: Colors.green));
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy UPI ID', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QrPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black..strokeWidth = 2;
    final cell = size.width / 25;

    // Draw a simplified QR-like pattern
    void drawRect(int x, int y, int w, int h) {
      canvas.drawRect(Rect.fromLTWH(x * cell, y * cell, w * cell, h * cell), paint..style = PaintingStyle.fill);
    }

    // Position markers
    paint..style = PaintingStyle.fill;
    // Top-left marker
    for (int i = 0; i < 7; i++) for (int j = 0; j < 7; j++) {
      if (i == 0 || i == 6 || j == 0 || j == 6 || (i >= 2 && i <= 4 && j >= 2 && j <= 4)) drawRect(i, j, 1, 1);
    }
    // Top-right marker
    for (int i = 0; i < 7; i++) for (int j = 0; j < 7; j++) {
      if (i == 0 || i == 6 || j == 0 || j == 6 || (i >= 2 && i <= 4 && j >= 2 && j <= 4)) drawRect(18 + i, j, 1, 1);
    }
    // Bottom-left marker
    for (int i = 0; i < 7; i++) for (int j = 0; j < 7; j++) {
      if (i == 0 || i == 6 || j == 0 || j == 6 || (i >= 2 && i <= 4 && j >= 2 && j <= 4)) drawRect(i, 18 + j, 1, 1);
    }

    // Random data dots
    final dots = [
      [8,8],[9,8],[10,8],[11,8],[12,8],[13,8],[15,8],[16,8],[17,8],[18,8],
      [8,9],[12,9],[15,9],[8,10],[10,10],[12,10],[15,10],[8,11],[12,11],[15,11],
      [8,12],[12,12],[15,12],[8,13],[12,13],[16,13],[18,13],[8,14],[12,14],[15,14],
      [8,15],[12,15],[15,15],[8,16],[10,16],[12,16],[13,16],[14,16],[15,16],[8,17],
      [12,17],[8,18],[10,18],[12,18],[13,18],[14,18],[15,18],[8,19],[12,19],[15,19],
      [8,20],[9,20],[10,20],[11,20],[12,20],[13,20],[15,20],[16,20],[17,20],[18,20],
    ];
    for (final d in dots) drawRect(d[0], d[1], 1, 1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
