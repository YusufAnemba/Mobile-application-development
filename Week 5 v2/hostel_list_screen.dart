import 'package:flutter/material.dart';
import '../models/hostel.dart';
import '../services/sync_service.dart';

class HostelListScreen extends StatefulWidget {
  const HostelListScreen({super.key});

  @override
  State<HostelListScreen> createState() => _HostelListScreenState();
}

class _HostelListScreenState extends State<HostelListScreen> {
  List<Hostel> _displayHostels = [];

  @override
  void initState() {
    super.initState();
    _displayHostels = syncService.hostels;
  }

  Future<void> _handleRefresh() async {
    await syncService.syncHostels();
    if (mounted) {
      setState(() {
        _displayHostels = syncService.hostels;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Hostels'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _displayHostels = syncService.hostels
                        .where((h) => h.name.toLowerCase().contains(value.toLowerCase()) || 
                                     h.location.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search by location or name...',
                  prefixIcon: const Icon(Icons.search),
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            Expanded(
              child: _displayHostels.isEmpty 
                ? const Center(child: Text('No hostels found.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _displayHostels.length,
                    itemBuilder: (context, index) {
                      final hostel = _displayHostels[index];
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/details', arguments: hostel),
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                hostel.imageUrl,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Container(height: 180, color: Colors.grey, child: const Icon(Icons.image)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          hostel.name,
                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'KES ${hostel.price}',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                        const SizedBox(width: 4),
                                        Text(hostel.location, style: const TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Wrap(
                                      spacing: 8,
                                      children: hostel.amenities.take(3).map((a) => Chip(
                                        label: Text(a, style: const TextStyle(fontSize: 10)),
                                        padding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                      )).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
