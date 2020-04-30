import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/feedback.dart';
import '../models/admin.dart';
import '../models/traveler.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database db;
  DbHelper._createInstance();
  Future<Database> get database async {
    if (db == null) {
      db = await initDB();
    }
    return db;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createInstance();
    }
    return _dbHelper;
  }
  Future<Database> initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    final path = join(docDir.path, 'feedbacks.db');
    var feedbacksDB = openDatabase(path, version: 2, onCreate: _createDB);
    return feedbacksDB;
  }

  void _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Feedbacks (
        feedbackID INTEGER PRIMARY KEY AUTOINCREMENT, 
        feedbackN TEXT,
        feedbackE TEXT,
        feedbackD TEXT
        )''');

    await db.execute('''
      CREATE TABLE ReviewedFB (
        feedbackID INTEGER PRIMARY KEY AUTOINCREMENT, 
        feedbackN TEXT,
        feedbackE TEXT,
        feedbackD TEXT
        )''');

    await db.execute('''
      CREATE TABLE Admin (
        Aid INTEGER PRIMARY KEY AUTOINCREMENT, 
        Aemail TEXT,
        Apassword TEXT
        )''');
    await db.execute('''
      CREATE TABLE Traveler (
        Alid INTEGER PRIMARY KEY AUTOINCREMENT, 
        Alemail TEXT,
        Alpassword TEXT,
        Alname TEXT,
        AlLang TEXT
        )''');
  }

  Future<int> addFeedback(FeedbackModel feedback) async {
    Database dbs = await this.database;

    var res = await dbs.insert('Feedbacks', feedback.toMap());
    fetchAllFeedbacks();
    return res;
  }

  Future<int> reviewFeedbacks(int feedbackID) async {
    Database dbs = await this.database;
    insertReviewedFB(feedbackID);
    var res = await dbs
        .rawDelete("Delete from Feedbacks WHERE feedbackID = $feedbackID ");
    fetchAllFeedbacksrev();
    return res;
  }

  Future<int> insertReviewedFB(int feedbackID) async {
    Database dbs = await this.database;
    var res = await dbs.rawInsert(
        "INSERT INTO ReviewedFB Select * from Feedbacks where feedbackID = $feedbackID");
    return res;
  }

  Future<List<Map<String, dynamic>>> fetchAllFeedbacksrev() async {
    Database dbs = await this.database;
    var res = await dbs.rawQuery("SELECT * FROM ReviewedFB");
    return res;
  }

  Future<List<Map<String, dynamic>>> fetchAllFeedbacks() async {
    Database dbs = await this.database;
    var res = await dbs.rawQuery("SELECT * FROM Feedbacks");
    return res;
  }

  Future<int> travelerRegister(Traveler traveler) async {
    Database dbs = await this.database;
    var res = await dbs.insert('Traveler', traveler.toMap());

    return res;
  }

  Future<List<Map<String, dynamic>>> fetchTraveler(
      String email, String password) async {
    Database dbs = await this.database;
    var res = await dbs.rawQuery(
        "SELECT * FROM Traveler WHERE Alemail='$email' AND Alpassword='$password' ");
    return res;
  }

  Future<int> adminRegister(Admin admin) async {
    Database dbs = await this.database;
    var res = await dbs.insert('Admin', admin.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> fetchAdmin(
      String email, String password) async {
    Database dbs = await this.database;
    var res = await dbs.rawQuery(
        "SELECT * FROM Admin WHERE Aemail='$email' AND Apassword='$password' ");

    return res;
  }
}
