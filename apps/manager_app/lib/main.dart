import 'package:flutter/material.dart';

void main() {
  runApp(const ManagerAppPlaceholder());
}

class ManagerAppPlaceholder extends StatelessWidget {
  const ManagerAppPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FleetFuel360 Companies',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A73E8)),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.business, size: 64, color: Color(0xFF1A73E8)),
              SizedBox(height: 16),
              Text(
                'FleetFuel360 Companies',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Manager App — Phase 2',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                'Coming soon after Driver App launch.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
