import 'package:flutter/material.dart';
import 'models/hostel.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/admin_dashboard_screen.dart';
import 'screens/main_navigation.dart';
import 'screens/hostel_details_screen.dart';
import 'screens/booking_form_screen.dart';

void main() {
  runApp(const MasenoWisdomHostels());
}

class MasenoWisdomHostels extends StatelessWidget {
  const MasenoWisdomHostels({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maseno Wisdom Hostels',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006D77),
          primary: const Color(0xFF006D77),
          secondary: const Color(0xFF83C5BE),
          surface: const Color(0xFFEDF6F9),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xFF006D77),
          foregroundColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF006D77),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        segmentedButtonTheme: SegmentedButtonThemeData(
          style: SegmentedButton.styleFrom(
            selectedBackgroundColor: const Color(0xFF006D77),
            selectedForegroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF006D77), width: 2),
          ),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final hostel = settings.arguments as Hostel;
          return MaterialPageRoute(
            builder: (context) => HostelDetailsScreen(hostel: hostel),
          );
        }
        if (settings.name == '/booking') {
          final hostel = settings.arguments as Hostel;
          return MaterialPageRoute(
            builder: (context) => BookingFormScreen(hostel: hostel),
          );
        }
        return null;
      },
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/main': (context) => const MainNavigationWrapper(),
        '/admin': (context) => const AdminDashboardScreen(),
      },
    );
  }
}
