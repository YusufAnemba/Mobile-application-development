import 'package:flutter/material.dart';
import '../models/tenant.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mocking a logged-in tenant (Alice)
    final tenant = mockTenants[0];

    return Scaffold(
      appBar: AppBar(title: const Text('Wisdom Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${tenant.name}!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Your Maseno home at a glance.'),
            const SizedBox(height: 24),
            
            // --- My Room Section ---
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('MY ASSIGNED ROOM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Chip(label: Text('Room ${tenant.roomNumber}', style: const TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    const Text('Room Facilities:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: tenant.roomFacilities.map((f) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Theme.of(context).colorScheme.primary.withAlpha(50)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.done, size: 14, color: Colors.green),
                            const SizedBox(width: 4),
                            Text(f, style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            Row(
              children: [
                _buildStatCard(context, 'Next Payment', '15 Oct', Icons.calendar_today),
                const SizedBox(width: 16),
                _buildStatCard(context, 'Dues', 'KES 0', Icons.check_circle),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildActionTile(context, 'Report Room Issue', Icons.report_problem_outlined, () {}),
            _buildActionTile(context, 'Request Facilities', Icons.add_home_work_outlined, () {}),
            _buildActionTile(context, 'Chat with Warden', Icons.chat_bubble_outline, () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
