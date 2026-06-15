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
      version: 1,
      onCreate: _onCreate,
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
}
