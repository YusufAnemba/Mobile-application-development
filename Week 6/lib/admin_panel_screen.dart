import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  int _selectedIndex = 0;
  final Color adminColor = const Color(0xFF2C3E50);

  // This will hold the different views for the bottom navigation
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      AdminDashboardHome(
        onStorageClick: () => _onItemTapped(1),
        onRestClick: () => _onItemTapped(5),
        onAttendanceClick: () => _onItemTapped(2),
        onTasksClick: () => _onItemTapped(3),
      ),
      const StudentManagementView(),
      const Center(child: Text('Attendance System - Coming Soon')),
      const CourseTasksView(),
      const Center(child: Text('Reports - Coming Soon')),
      const HttpRestView(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      appBar: AppBar(
        title: const Text('Academic Administration Dashboard'),
        backgroundColor: Colors.white,
        foregroundColor: adminColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: adminColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person_add), label: 'Register'),
          BottomNavigationBarItem(icon: Icon(Icons.how_to_reg), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.sync), label: 'HTTP REST'),
        ],
      ),
    );
  }
}

class AdminDashboardHome extends StatelessWidget {
  final VoidCallback onStorageClick;
  final VoidCallback onRestClick;
  final VoidCallback onAttendanceClick;
  final VoidCallback onTasksClick;

  const AdminDashboardHome({
    super.key,
    required this.onStorageClick,
    required this.onRestClick,
    required this.onAttendanceClick,
    required this.onTasksClick,
  });

  @override
  Widget build(BuildContext context) {
    const Color textColor = Color(0xFF1A237E);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome Administrator,',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const Text(
            'Connected via HTTP Client-Server Pipeline',
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                GestureDetector(
                  onTap: onStorageClick,
                  child: _buildDashboardCard(
                    'SQLite Storage',
                    'Local Cache Active',
                    Icons.storage,
                    Colors.indigo.shade900,
                  ),
                ),
                GestureDetector(
                  onTap: onRestClick,
                  child: _buildDashboardCard(
                    'REST Operations',
                    'GET, POST, PUT, DELETE',
                    Icons.http,
                    Colors.indigo.shade900,
                  ),
                ),
                GestureDetector(
                  onTap: onAttendanceClick,
                  child: _buildDashboardCard(
                    'Attendance System',
                    'Roll Call Tracking',
                    Icons.person_search,
                    Colors.indigo.shade900,
                  ),
                ),
                GestureDetector(
                  onTap: onTasksClick,
                  child: _buildDashboardCard(
                    'Course Tasks',
                    'Assignment Matrix',
                    Icons.check_circle_outline,
                    Colors.indigo.shade900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class StudentManagementView extends StatefulWidget {
  const StudentManagementView({super.key});

  @override
  State<StudentManagementView> createState() => _StudentManagementViewState();
}

class _StudentManagementViewState extends State<StudentManagementView> {
  List<Student> _students = [];
  bool _isLoading = true;
  final Color adminColor = const Color(0xFF2C3E50);

  @override
  void initState() {
    super.initState();
    _refreshStudentList();
  }

  Future<void> _refreshStudentList() async {
    setState(() => _isLoading = true);
    final data = await DatabaseHelper().getStudents();
    setState(() {
      _students = data;
      _isLoading = false;
    });
  }

  Future<void> _seedSampleData() async {
    final samples = [
      Student(fullName: 'James Omondi', email: 'james@jamhuri.com', phoneNumber: '0711000001', password: 'password123'),
      Student(fullName: 'Sarah Wambui', email: 'sarah@jamhuri.com', phoneNumber: '0722000002', password: 'password123'),
      Student(fullName: 'Michael Mwangi', email: 'michael@jamhuri.com', phoneNumber: '0733000003', password: 'password123'),
      Student(fullName: 'Faith Chepkoech', email: 'faith@jamhuri.com', phoneNumber: '0744000004', password: 'password123'),
      Student(fullName: 'David Mutua', email: 'david@jamhuri.com', phoneNumber: '0755000005', password: 'password123'),
      Student(fullName: 'Mary Atieno', email: 'mary@jamhuri.com', phoneNumber: '0766000006', password: 'password123'),
      Student(fullName: 'Peter Kamau', email: 'peter@jamhuri.com', phoneNumber: '0777000007', password: 'password123'),
      Student(fullName: 'Mercy Njeri', email: 'mercy@jamhuri.com', phoneNumber: '0788000008', password: 'password123'),
      Student(fullName: 'Kelvin Kiprop', email: 'kelvin@jamhuri.com', phoneNumber: '0799000009', password: 'password123'),
      Student(fullName: 'Esther Nyambura', email: 'esther@jamhuri.com', phoneNumber: '0700000010', password: 'password123'),
    ];

    for (var student in samples) {
      await DatabaseHelper().insertStudent(student);
    }
    _refreshStudentList();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('10 Sample students added!')),
      );
    }
  }

  Future<void> _deleteStudent(int id) async {
    await DatabaseHelper().deleteStudent(id);
    _refreshStudentList();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Student deleted successfully')),
      );
    }
  }

  void _showEditDialog(Student student) {
    final nameController = TextEditingController(text: student.fullName);
    final emailController = TextEditingController(text: student.email);
    final phoneController = TextEditingController(text: student.phoneNumber);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Student'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final updatedStudent = Student(
                id: student.id,
                fullName: nameController.text,
                email: emailController.text,
                phoneNumber: phoneController.text,
                password: student.password,
              );
              await DatabaseHelper().updateStudent(updatedStudent);
              if (mounted) Navigator.pop(context);
              _refreshStudentList();
            },
            style: ElevatedButton.styleFrom(backgroundColor: adminColor, foregroundColor: Colors.white),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Registered Students',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.person_add_alt_1),
                    onPressed: _seedSampleData,
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: _refreshStudentList,
                  ),
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _students.isEmpty
                  ? const Center(child: Text('No students registered yet.'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _students.length,
                      itemBuilder: (context, index) {
                        final student = _students[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: adminColor.withOpacity(0.1),
                              child: Text(
                                student.fullName.isNotEmpty ? student.fullName[0].toUpperCase() : '?',
                                style: TextStyle(color: adminColor, fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(student.fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('${student.email}\n${student.phoneNumber}'),
                            isThreeLine: true,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.indigo),
                                  onPressed: () => _showEditDialog(student),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Delete Student'),
                                        content: Text('Are you sure you want to delete ${student.fullName}?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              _deleteStudent(student.id!);
                                            },
                                            child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }
}

class HttpRestView extends StatefulWidget {
  const HttpRestView({super.key});

  @override
  State<HttpRestView> createState() => _HttpRestViewState();
}

class _HttpRestViewState extends State<HttpRestView> {
  List<dynamic> _users = [];
  bool _isLoading = false;
  final String _apiUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<void> _fetchUsers() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _users = json.decode(response.body);
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching data: $e')),
        );
      }
    }
  }

  Future<void> _postUser() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        body: json.encode({
          'name': 'New Admin User',
          'email': 'admin@jamhuri.com',
        }),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('POST Success: ${response.statusCode} - User Created (Simulated)')),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _putUser() async {
    if (_users.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final response = await http.put(
        Uri.parse('$_apiUrl/1'),
        body: json.encode({
          'id': 1,
          'name': 'Updated User Name',
          'email': 'updated@email.com',
        }),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PUT Success: ${response.statusCode} - User Updated (Simulated)')),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'HTTP Client-Server Panel',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRestButton('GET', Icons.download, Colors.indigo.shade100, _fetchUsers),
              _buildRestButton('POST/HOST', Icons.cloud_upload, Colors.indigo.shade100, _postUser),
              _buildRestButton('PUT', Icons.edit_note, Colors.indigo.shade100, _putUser),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _users.isEmpty
                  ? const Center(child: Text('Tap GET to fetch network data'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _users.length,
                      itemBuilder: (context, index) {
                        final user = _users[index];
                        return Card(
                          elevation: 1,
                          margin: const EdgeInsets.only(bottom: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.indigo.shade900,
                              child: const Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text(
                              user['name'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(user['email']),
                            trailing: const Icon(Icons.delete, color: Colors.redAccent, size: 20),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }

  Widget _buildRestButton(String label, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: Colors.indigo.shade900),
      label: Text(label, style: TextStyle(color: Colors.indigo.shade900, fontSize: 12)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}

class CourseTasksView extends StatefulWidget {
  const CourseTasksView({super.key});

  @override
  State<CourseTasksView> createState() => _CourseTasksViewState();
}

class _CourseTasksViewState extends State<CourseTasksView> {
  final List<Map<String, String>> _tasks = [];
  final Color adminColor = const Color(0xFF1A237E);

  void _showAddTaskSheet() {
    final titleController = TextEditingController();
    final unitController = TextEditingController();
    final dateController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Issue New Course Assignment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildTextField(titleController, 'Assignment Title'),
            const SizedBox(height: 12),
            _buildTextField(unitController, 'Unit Code (e.g., BIT4202)'),
            const SizedBox(height: 12),
            _buildTextField(dateController, 'Due Date (YYYY-MM-DD)'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    setState(() {
                      _tasks.add({
                        'title': titleController.text,
                        'unit': unitController.text,
                        'date': dateController.text,
                      });
                    });
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: adminColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text('Publish Task', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Course Assignments',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: _tasks.isEmpty
                ? const Center(
                    child: Text(
                      'No academic tasks created yet.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Text(task['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('Unit: ${task['unit']} | Due: ${task['date']}'),
                          trailing: const Icon(Icons.assignment_outlined, color: Colors.indigo),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskSheet,
        backgroundColor: adminColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
