class Hostel {
  final String id;
  final String name;
  final String location;
  final double price;
  final String imageUrl;
  final List<String> amenities;
  final String description;

  Hostel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.amenities,
    required this.description,
  });
}

final List<Hostel> mockHostels = [
  Hostel(
    id: '1',
    name: 'Wisdom Executive Plaza',
    location: 'Maseno Near Main Gate',
    price: 15000,
    imageUrl: 'https://images.unsplash.com/photo-1555854817-5b2247a8175f?q=80&w=2070&auto=format&fit=crop',
    amenities: ['Free WiFi', 'Hot Shower', '24/7 Security', 'Study Area'],
    description: 'A premium hostel offering the best comfort for serious students. Located just 5 minutes from the main gate.',
  ),
  Hostel(
    id: '2',
    name: 'Green View Annex',
    location: 'Siriba Campus Side',
    price: 12000,
    imageUrl: 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?q=80&w=2071&auto=format&fit=crop',
    amenities: ['Borehole Water', 'Spacious Rooms', 'Garden'],
    description: 'Quiet environment with a beautiful view. Ideal for postgraduate students.',
  ),
  Hostel(
    id: '3',
    name: 'Students Haven',
    location: 'Equator Market',
    price: 8500,
    imageUrl: 'https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?q=80&w=2070&auto=format&fit=crop',
    amenities: ['CCTV', 'Common Kitchen', 'Near Market'],
    description: 'Affordable and convenient. Everything you need within reach.',
  ),
];
