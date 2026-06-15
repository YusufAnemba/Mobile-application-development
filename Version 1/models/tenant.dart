import 'hostel.dart';

class Tenant {
  final String id;
  final String name;
  final String email;
  final String regNo;
  final String hostelId;
  final String roomNumber;
  final List<String> roomFacilities;

  Tenant({
    required this.id,
    required this.name,
    required this.email,
    required this.regNo,
    required this.hostelId,
    required this.roomNumber,
    required this.roomFacilities,
  });
}

final List<Tenant> mockTenants = [
  Tenant(
    id: '101',
    name: 'Alice Wambui',
    email: 'alice@maseno.ac.ke',
    regNo: 'ED/001/2023',
    hostelId: '1',
    roomNumber: 'A12',
    roomFacilities: ['Bed', 'Study Desk', 'Wall Cabinet', 'Curtains'],
  ),
  Tenant(
    id: '102',
    name: 'Brian Omondi',
    email: 'brian@maseno.ac.ke',
    regNo: 'CS/045/2022',
    hostelId: '1',
    roomNumber: 'B05',
    roomFacilities: ['Bed', 'Study Desk', 'Private Balcony'],
  ),
  Tenant(
    id: '103',
    name: 'Catherine Njeri',
    email: 'catherine@maseno.ac.ke',
    regNo: 'BA/099/2023',
    hostelId: '2',
    roomNumber: 'Z10',
    roomFacilities: ['Bed', 'Study Desk', 'Bookshelf'],
  ),
];
