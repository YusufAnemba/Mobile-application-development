import 'package:flutter/material.dart';
import '../models/hostel.dart';

class HostelDetailsScreen extends StatelessWidget {
  final Hostel hostel;
  const HostelDetailsScreen({super.key, required this.hostel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                hostel.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(color: Colors.grey),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          hostel.name,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'KES ${hostel.price} / Semester',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(hostel.description, style: const TextStyle(height: 1.5, color: Colors.black87)),
                  const SizedBox(height: 24),
                  const Text('Amenities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 4,
                    children: hostel.amenities.map((a) => Row(
                      children: [
                        const Icon(Icons.check_circle, size: 20, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(a),
                      ],
                    )).toList(),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(12), blurRadius: 10, spreadRadius: 5)],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/booking', arguments: hostel),
                child: const Text('BOOK NOW'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
