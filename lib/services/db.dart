import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'triangle.dart';

class DatabaseService extends GetxService {
  late Database db;

  Future<DatabaseService> init() async {
    await initDB();
    return this;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'plan_db.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      print('==============================================');
      await createTable(db);
      await createDefaultData(db);
    });
  }

  createTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS plan (id INTEGER PRIMARY KEY, title TEXT, targetAmount REAL, image TEXT, record TEXT)');
  }

  createDefaultData(Database db) async {
    for (var i = 0; i < 10; i++) {
      List<Record> record = [];
      for (var i = 0; i < 3; i++) {
        record.add(Record(
            time: faker.date.time(),
            amount: faker.randomGenerator.integer(20, min: 10).toString()));
      }
      db.insert(
        'plan',
        {
          'id': faker.randomGenerator.integer(20, min: 1),
          'title': faker.person.name(),
          'targetAmount':
              faker.randomGenerator.integer(500, min: 100).toDouble(),
          'image': 'assets/images/common_${i}.png',
          'record': jsonEncode(record),
        },
      );
    }
  }

  insert(Plan plan) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'plan_db.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    await db.insert('plan', {
      'id': plan.id,
      'title': plan.title,
      'targetAmount': plan.targetAmount,
      'image': plan.image,
      'record': jsonEncode(plan.record),
    });
  }

  update(Plan plan) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'plan_db.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    await db.update(
        'plan',
        {
          'id': plan.id,
          'title': plan.title,
          'targetAmount': plan.targetAmount,
          'image': plan.image,
          'record': jsonEncode(plan.record),
        },
        where: 'id = ?',
        whereArgs: [
          plan.id,
        ]);
  }

  delete(int id) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'plan_db.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});

    db.delete('plan', where: 'id = ?', whereArgs: [id]);
  }

  clean() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'plan_db.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    await db.delete('plan');
  }

  Future<List<Plan>> getAll() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'plan_db.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    var result = await db.query('plan');
    return result.map((e) => Plan.fromJson(e)).toList();
  }
}
