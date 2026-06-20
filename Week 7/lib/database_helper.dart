import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Student {
  final int? id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String password;

  Student({
    this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      password: map['password'],
    );
  }
}

class Attendance {
  final int? id;
  final int studentId;
  final String date;
  final String status;
  final String unitCode;

  Attendance({
    this.id,
    required this.studentId,
    required this.date,
    required this.status,
    required this.unitCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentId': studentId,
      'date': date,
      'status': status,
      'unitCode': unitCode,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'],
      studentId: map['studentId'],
      date: map['date'],
      status: map['status'],
      unitCode: map['unitCode'],
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'jamhuri_school.db');
    return await openDatabase(
      path,
      version: 2, // Incremented version
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT,
        phoneNumber TEXT,
        email TEXT,
        password TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE attendance(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        studentId INTEGER,
        date TEXT,
        status TEXT,
        unitCode TEXT,
        FOREIGN KEY (studentId) REFERENCES students (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE attendance(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          studentId INTEGER,
          date TEXT,
          status TEXT,
          unitCode TEXT,
          FOREIGN KEY (studentId) REFERENCES students (id) ON DELETE CASCADE
        )
      ''');
    }
  }

  // Insert a student
  Future<int> insertStudent(Student student) async {
    Database db = await database;
    return await db.insert('students', student.toMap());
  }

  // Get all students
  Future<List<Student>> getStudents() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('students');
    return List.generate(maps.length, (i) {
      return Student.fromMap(maps[i]);
    });
  }

  // Get a student by email (for login)
  Future<Student?> getStudentByEmail(String email) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'students',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return Student.fromMap(maps[0]);
    }
    return null;
  }

  // Update a student
  Future<int> updateStudent(Student student) async {
    Database db = await database;
    return await db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  // Delete a student
  Future<int> deleteStudent(int id) async {
    Database db = await database;
    return await db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Attendance Methods
  Future<int> insertAttendance(Attendance attendance) async {
    Database db = await database;
    return await db.insert('attendance', attendance.toMap());
  }

  Future<List<Map<String, dynamic>>> getAttendanceByDate(String date, String unitCode) async {
    Database db = await database;
    return await db.rawQuery('''
      SELECT students.fullName, attendance.status, attendance.id
      FROM students
      JOIN attendance ON students.id = attendance.studentId
      WHERE attendance.date = ? AND attendance.unitCode = ?
    ''', [date, unitCode]);
  }

  Future<List<Map<String, dynamic>>> getAttendanceSummary() async {
    Database db = await database;
    return await db.rawQuery('''
      SELECT students.fullName, 
             COUNT(CASE WHEN attendance.status = 'Present' THEN 1 END) as present_count,
             COUNT(attendance.id) as total_sessions
      FROM students
      LEFT JOIN attendance ON students.id = attendance.studentId
      GROUP BY students.id
    ''');
  }

  Future<int> updateAttendance(Attendance attendance) async {
    Database db = await database;
    return await db.update(
      'attendance',
      attendance.toMap(),
      where: 'id = ?',
      whereArgs: [attendance.id],
    );
  }

  Future<int> deleteAttendance(int id) async {
    Database db = await database;
    return await db.delete(
      'attendance',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
