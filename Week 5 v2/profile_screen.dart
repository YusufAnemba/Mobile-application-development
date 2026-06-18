import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF006D77),
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Column(
              children: [
                Text('John Doe', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text('john.doe@maseno.ac.ke', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildProfileItem(Icons.history, 'Booking History', () {}),
          _buildProfileItem(Icons.payment, 'My Payments', () {}),
          _buildProfileItem(Icons.notifications_none, 'Notifications', () {}),
          _buildProfileItem(Icons.help_outline, 'Help & Support', () {}),
          const Divider(),
          _buildProfileItem(Icons.logout, 'Logout', () {
            Navigator.pushReplacementNamed(context, '/');
          }, color: Colors.red),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? const Color(0xFF006D77)),
      title: Text(title, style: TextStyle(color: color)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
