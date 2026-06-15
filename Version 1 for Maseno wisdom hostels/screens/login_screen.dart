import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              color: Colors.white.withAlpha(230),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.home_work, size: 80, color: Color(0xFF006D77)),
                      const SizedBox(height: 16),
                      Text(
                        'MASENO WISDOM HOSTELS',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF006D77),
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      SegmentedButton<bool>(
                        segments: const [
                          ButtonSegment(value: false, label: Text('Student'), icon: Icon(Icons.school)),
                          ButtonSegment(value: true, label: Text('Admin'), icon: Icon(Icons.admin_panel_settings)),
                        ],
                        selected: {_isAdmin},
                        onSelectionChanged: (newSelection) {
                          setState(() {
                            _isAdmin = newSelection.first;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: _isAdmin ? 'Admin Username' : 'Email / Username',
                          prefixIcon: const Icon(Icons.person),
                        ),
                        validator: (value) => value!.isEmpty ? 'Please enter identity' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) => value!.length < 6 ? 'Password too short' : null,
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (_isAdmin) {
                                Navigator.pushReplacementNamed(context, '/admin');
                              } else {
                                Navigator.pushReplacementNamed(context, '/main');
                              }
                            }
                          },
                          child: Text(_isAdmin ? 'ADMIN LOGIN' : 'LOGIN'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(context, '/register'),
                            child: const Text('Register Here', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password?'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
