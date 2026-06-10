import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Heritage Apparel',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFFBF7), // Light cream background
        fontFamily: 'Serif', // Use your preferred font family
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Top Brown Background Accent
          Container(
            height: 180,
            color: const Color(0xFF5D3E21),
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back 👋🏼',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_none, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),

          // Main Scrollable Content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildPromoBanner(),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Categories'),
                  const SizedBox(height: 12),
                  _buildCategoryList(),
                  const SizedBox(height: 24),
                  _buildSectionHeader('✨ Featured'),
                  const SizedBox(height: 12),
                  _buildFeaturedGrid(),
                  const SizedBox(height: 80), // Space to avoid bottom nav overlap
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // 1. Promotional Banner Widget
  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1539109136881-3be0616acf4b?q=80&w=600'), // Replace with your model image asset
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.black.withOpacity(0.5),
              Colors.transparent,
            ],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, py: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFCE9E49),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'NEW COLLECTION 2025',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Heritage &\nModern Elegance',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCE9E49),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Shop Collection ',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 2. Generic Section Header
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C1A04),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              children: const [
                Text('See all', style: TextStyle(color: Color(0xFFCE9E49))),
                Icon(Icons.chevron_right, color: Color(0xFFCE9E49), size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 3. Category Horizontal Row
  Widget _buildCategoryList() {
    final categories = ['All', "Men's Wear", "Women's Wear", 'Fabrics'];
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          bool isSelected = index == 0; // 'All' is active by default
          return Container(
            margin: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(
                categories[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF7D7063),
                  fontWeight: FontWeight.w600,
                ),
              ),
              selected: isSelected,
              selectedColor: const Color(0xFF633A11), // Dark brown tint
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(
                  color: isSelected ? Colors.transparent : const Color(0xFFE8E2DA),
                ),
              ),
              showCheckmark: false,
              onSelected: (bool selected) {},
            ),
          );
        },
      ),
    );
  }

  // 4. Product Item Grid
  Widget _buildFeaturedGrid() {
    final products = [
      {
        'tag': 'Sale',
        'tagColor': const Color(0xFF801A24),
        'imageUrl': 'https://images.unsplash.com/photo-1507679799987-c73779587ccf?q=80&w=400',
      },
      {
        'tag': 'Bestseller',
        'tagColor': const Color(0xFFCE9E49),
        'imageUrl': 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80&w=400',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(product['imageUrl'] as String),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Top Tag (Sale / Bestseller)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: product['tagColor'] as Color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      product['tag'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Favorite Icon
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.9),
                    radius: 16,
                    child: const Icon(
                      Icons.favorite_border,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 5. Custom Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF633A11),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: [
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.home_filled, 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.grid_view_rounded, 1),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.shopping_bag_outlined, 2),
            label: 'Bag',
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.person_outline, 3),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    if (index == 0 && isSelected) {
      // Highlights the home icon with a soft background tint like the mockup
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF5EBE1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.home, color: Color(0xFF633A11)),
      );
    }
    return Icon(icon);
  }
}