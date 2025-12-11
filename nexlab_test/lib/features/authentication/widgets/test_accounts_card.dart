import 'package:flutter/material.dart';

class TestAccountsCard extends StatelessWidget {
  const TestAccountsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Test Accounts:',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('admin@nexlab.com / admin123'),
          const Text('user@nexlab.com / user123'),
          const Text('demo@nexlab.com / demo123'),
        ],
      ),
    );
  }
}
