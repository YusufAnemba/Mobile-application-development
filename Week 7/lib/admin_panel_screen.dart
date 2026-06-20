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

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      AdminDashboardHome(
        onStorageClick: () => _onItemTapped(1),
        onAttendanceClick: () => _onItemTapped(2),
        onTasksClick: () => _onItemTapped(3),
        onRestClick: () => _onItemTapped(5),
      ),
      const StudentManagementView(),
      const AttendanceSystemView(),
      const CourseTasksView(),
      const SystemReportsView(),
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
      final id = await DatabaseHelper().insertStudent(student);
      
      // Add 5 days of history for each student for "formality"
      final dates = ['2024-05-15', '2024-05-16', '2024-05-17', '2024-05-20', '2024-05-21'];
      final units = ['BIT4202', 'BCS3101'];
      
      for (int i = 0; i < dates.length; i++) {
        await DatabaseHelper().insertAttendance(Attendance(
          studentId: id,
          date: dates[i],
          status: (i + id) % 5 == 0 ? 'Absent' : (i + id) % 7 == 0 ? 'Late' : 'Present',
          unitCode: units[i % 2],
        ));
      }
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

class AttendanceSystemView extends StatefulWidget {
  const AttendanceSystemView({super.key});

  @override
  State<AttendanceSystemView> createState() => _AttendanceSystemViewState();
}

class _AttendanceSystemViewState extends State<AttendanceSystemView> {
  final Color adminColor = const Color(0xFF1A237E);
  List<Student> _students = [];
  Map<int, String> _attendanceStatus = {};
  String _selectedUnit = 'BIT4202';
  final List<String> _units = ['BIT4202', 'BCS3101', 'BCT2205', 'BEE4108', 'MAT1101'];
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = true;
  
  // New State for Reports
  bool _isMarkingMode = true;
  String _reportType = 'Class Overview'; // 'Class Overview' or 'Student Report'
  Student? _selectedReportStudent;
  List<Map<String, dynamic>> _summaryData = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final students = await DatabaseHelper().getStudents();
    setState(() {
      _students = students;
      for (var s in students) {
        _attendanceStatus[s.id!] = 'Present';
      }
      _isLoading = false;
    });
  }

  Future<void> _loadSummary() async {
    setState(() => _isLoading = true);
    final data = await DatabaseHelper().getAttendanceSummary();
    setState(() {
      _summaryData = data;
      _isLoading = false;
    });
  }

  Future<void> _saveAttendance() async {
    final dateStr = "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";

    for (var studentId in _attendanceStatus.keys) {
      final attendance = Attendance(
        studentId: studentId,
        date: dateStr,
        status: _attendanceStatus[studentId]!,
        unitCode: _selectedUnit,
      );
      await DatabaseHelper().insertAttendance(attendance);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attendance saved successfully!')),
      );
    }
  }

  void _showStudentMonthlyReport(Student student) async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> records = await db.query(
      'attendance',
      where: 'studentId = ?',
      whereArgs: [student.id],
      orderBy: 'date DESC',
    );

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text('${student.fullName} - History'),
            content: SizedBox(
              width: double.maxFinite,
              child: _buildAttendanceTable(records, onEdit: () async {
                // Refresh records after edit
                final updatedRecords = await db.query(
                  'attendance',
                  where: 'studentId = ?',
                  whereArgs: [student.id],
                  orderBy: 'date DESC',
                );
                setDialogState(() {
                  records.clear();
                  records.addAll(updatedRecords);
                });
                _loadSummary(); // Refresh background summary too
              }),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
            ],
          );
        },
      ),
    );
  }

  void _editAttendanceRecord(Map<String, dynamic> record, VoidCallback onUpdate) {
    String currentStatus = record['status'];
    final TextEditingController unitController = TextEditingController(text: record['unitCode']);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Edit Attendance Record'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Date: ${record['date']}'),
              const SizedBox(height: 16),
              TextField(
                controller: unitController,
                decoration: const InputDecoration(labelText: 'Unit Code'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: currentStatus,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['Present', 'Absent', 'Late']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => currentStatus = val!),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await DatabaseHelper().deleteAttendance(record['id']);
                Navigator.pop(context);
                onUpdate();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () async {
                final updated = Attendance(
                  id: record['id'],
                  studentId: record['studentId'],
                  date: record['date'],
                  status: currentStatus,
                  unitCode: unitController.text,
                );
                await DatabaseHelper().updateAttendance(updated);
                Navigator.pop(context);
                onUpdate();
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceTable(List<Map<String, dynamic>> records, {VoidCallback? onEdit}) {
    if (records.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No attendance records found.'),
      );
    }
    return Flexible(
      child: SingleChildScrollView(
        child: DataTable(
          columnSpacing: 10,
          horizontalMargin: 10,
          columns: const [
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('')), // Edit action
          ],
          rows: records.map((record) {
            return DataRow(cells: [
              DataCell(Text(record['date'], style: const TextStyle(fontSize: 12))),
              DataCell(
                Text(
                  record['status'],
                  style: TextStyle(
                    fontSize: 12,
                    color: record['status'] == 'Present'
                        ? Colors.green
                        : record['status'] == 'Absent'
                            ? Colors.red
                            : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataCell(
                IconButton(
                  icon: const Icon(Icons.edit, size: 18, color: Colors.blue),
                  onPressed: () => _editAttendanceRecord(record, onEdit ?? () {}),
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Mode Toggle
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => _isMarkingMode = true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isMarkingMode ? adminColor : Colors.grey.shade200,
                      foregroundColor: _isMarkingMode ? Colors.white : Colors.black,
                    ),
                    child: const Text('Mark Attendance'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => _isMarkingMode = false);
                      _loadSummary();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !_isMarkingMode ? adminColor : Colors.grey.shade200,
                      foregroundColor: !_isMarkingMode ? Colors.white : Colors.black,
                    ),
                    child: const Text('View Reports'),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: _isMarkingMode ? _buildMarkingView() : _buildReportsView(),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkingView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Mark Session', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        for (var s in _students) _attendanceStatus[s.id!] = 'Present';
                      });
                    },
                    child: const Text('Mark All Present'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedUnit,
                      decoration: const InputDecoration(labelText: 'Unit'),
                      items: _units.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                      onChanged: (val) => setState(() => _selectedUnit = val!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton.icon(
                    icon: const Icon(Icons.calendar_month, size: 18),
                    label: Text("${_selectedDate.day}/${_selectedDate.month}"),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2025),
                      );
                      if (picked != null) setState(() => _selectedDate = picked);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _students.length,
                  itemBuilder: (context, index) {
                    final student = _students[index];
                    return ListTile(
                      onTap: () => _showStudentMonthlyReport(student),
                      title: Text(student.fullName),
                      subtitle: const Text('Tap for history', style: TextStyle(fontSize: 10)),
                      trailing: DropdownButton<String>(
                        value: _attendanceStatus[student.id],
                        items: ['Present', 'Absent', 'Late']
                            .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                            .toList(),
                        onChanged: (val) {
                          setState(() => _attendanceStatus[student.id!] = val!);
                        },
                      ),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _saveAttendance,
              style: ElevatedButton.styleFrom(
                backgroundColor: adminColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Save Attendance', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReportsView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ChoiceChip(
                label: const Text('Class Overview'),
                selected: _reportType == 'Class Overview',
                onSelected: (val) => setState(() => _reportType = 'Class Overview'),
              ),
              ChoiceChip(
                label: const Text('Student Report'),
                selected: _reportType == 'Student Report',
                onSelected: (val) => setState(() => _reportType = 'Student Report'),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: _reportType == 'Class Overview' ? _buildClassOverview() : _buildIndividualReport(),
        ),
      ],
    );
  }

  Widget _buildClassOverview() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_summaryData.isEmpty) return const Center(child: Text('No attendance data available.'));

    return ListView.builder(
      itemCount: _summaryData.length,
      itemBuilder: (context, index) {
        final item = _summaryData[index];
        final total = item['total_sessions'] as int;
        final present = item['present_count'] as int;
        final percentage = total > 0 ? (present / total * 100).toStringAsFixed(1) : '0';

        return ListTile(
          title: Text(item['fullName']),
          subtitle: Text('Present: $present / Total: $total'),
          trailing: Text(
            '$percentage%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: double.parse(percentage) >= 75 ? Colors.green : Colors.red,
            ),
          ),
        );
      },
    );
  }

  Widget _buildIndividualReport() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButtonFormField<Student>(
            value: _selectedReportStudent,
            hint: const Text('Select Student'),
            items: _students.map((s) => DropdownMenuItem(value: s, child: Text(s.fullName))).toList(),
            onChanged: (val) => setState(() => _selectedReportStudent = val),
          ),
        ),
        if (_selectedReportStudent != null)
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: DatabaseHelper().database.then((db) => db.query(
                'attendance',
                where: 'studentId = ?',
                whereArgs: [_selectedReportStudent!.id],
                orderBy: 'date DESC',
              )),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildAttendanceTable(snapshot.data!, onEdit: () {
                    setState(() {}); // Refresh FutureBuilder
                  }),
                );
              },
            ),
          ),
      ],
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

class SystemReportsView extends StatelessWidget {
  const SystemReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color sectionColor = Color(0xFF1A237E);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Academic Storage Reports',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: sectionColor),
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              '1. Introduction to Data Storage',
              'Mobile applications need to store information to prevent data disappearance when the application closes.\n\nExamples:\n• User profiles\n• Login details\n• Shopping carts\n• Notes & Messages',
              Icons.info_outline,
            ),
            _buildInfoCard(
              '2. Types of Mobile Data Storage',
              'A. Shared Preferences: Small data (Themes, Status)\nB. Internal Storage: App files (Docs, Images)\nC. SQLite Database: Local records (Students, Attendance)\nD. Cloud Storage: Online data (Firebase, AWS)',
              Icons.storage,
            ),
            _buildInfoCard(
              '3. SQLite Database',
              'A lightweight relational database embedded within devices.\n\nAdvantages:\n• Fast & Lightweight\n• Offline capability\n• No separate server required',
              Icons.dns,
            ),
            _buildInfoCard(
              '4. Database Operations (CRUD)',
              'C - Create: Insert records\nR - Read: Retrieve records\nU - Update: Modify records\nD - Delete: Remove records',
              Icons.settings_input_component,
            ),
            _buildInfoCard(
              '5. Firebase Integration',
              'Cloud-based platform from Google.\nFeatures: Real-time DB, Auth, Cloud Storage, Notifications.',
              Icons.cloud_done,
            ),
            _buildInfoCard(
              '6. Real-Life Applications',
              '• Hospital App: Patient details, Prescriptions\n• School App: Student profiles, Attendance\n• E-Commerce: Products, Orders',
              Icons.business_center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Week 7 Class Tasks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: sectionColor),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Task 1: Storage Method Comparison', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Compare Shared Prefs, SQLite, Firebase, and Internal Storage.'),
                  Divider(),
                  Text('Task 2: Student Database Design', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Design a university student management DB structure (ID, Name, Course, Year, Phone).'),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content, IconData icon) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF1A237E), size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              content,
              style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
            ),
          ],
        ),
      ),
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
