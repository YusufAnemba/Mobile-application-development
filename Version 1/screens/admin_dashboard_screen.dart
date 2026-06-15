import 'package:flutter/material.dart';
import '../models/tenant.dart';
import '../models/hostel.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Console'),
        actions: [
          IconButton(onPressed: () => Navigator.pushReplacementNamed(context, '/'), icon: const Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Overview', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStatCard(context, 'Total Tenants', mockTenants.length.toString(), Icons.people),
                const SizedBox(width: 16),
                _buildStatCard(context, 'Hostels', mockHostels.length.toString(), Icons.apartment),
              ],
            ),
            const SizedBox(height: 32),
            const Text('All Tenants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mockTenants.length,
              itemBuilder: (context, index) {
                final tenant = mockTenants[index];
                final hostel = mockHostels.firstWhere((h) => h.id == tenant.hostelId);
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(tenant.name),
                    subtitle: Text('${hostel.name} - Room ${tenant.roomNumber}'),
                    trailing: const Icon(Icons.info_outline),
                    onTap: () {
                      _showTenantDetails(context, tenant, hostel);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text(title, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  void _showTenantDetails(BuildContext context, Tenant tenant, Hostel hostel) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tenant.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Reg: ${tenant.regNo}'),
            Text('Email: ${tenant.email}'),
            const Divider(),
            Text('Hostel: ${hostel.name}'),
            Text('Room: ${tenant.roomNumber}'),
            const SizedBox(height: 16),
            const Text('Room Facilities:', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: tenant.roomFacilities.map((f) => Chip(label: Text(f))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
