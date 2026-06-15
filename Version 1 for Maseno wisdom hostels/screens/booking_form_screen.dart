import 'package:flutter/material.dart';
import '../models/hostel.dart';

class BookingFormScreen extends StatefulWidget {
  final Hostel hostel;
  const BookingFormScreen({super.key, required this.hostel});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedRoomType = 'Single';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hostel Booking')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking for ${widget.hostel.name}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person_outline)),
                validator: (v) => v!.isEmpty ? 'Field required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Registration Number', prefixIcon: Icon(Icons.school_outlined)),
                validator: (v) => v!.isEmpty ? 'Field required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone_outlined)),
                keyboardType: TextInputType.phone,
                validator: (v) => v!.isEmpty ? 'Field required' : null,
              ),
              const SizedBox(height: 24),
              const Text('Select Room Type', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _selectedRoomType,
                items: ['Single', 'Double', 'Quadruple']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedRoomType = v!),
                decoration: const InputDecoration(),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (c) => AlertDialog(
                          title: const Text('Success'),
                          content: const Text('Your booking application has been submitted!'),
                          actions: [
                            TextButton(onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/main')), child: const Text('OK'))
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('SUBMIT APPLICATION'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
