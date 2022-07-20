import 'dart:async';

import 'package:birthday_reminder/models/birthday_model.dart';
import 'package:sqflite/sqflite.dart';

class BirthdayRepository {
  final Database database;
  final List<Map<String, dynamic>> listBirthdays = [];
  int nbBirthdays;

  BirthdayRepository({
    required this.database,
    this.nbBirthdays = 0,
  });

  final StreamController<List<BirthdayModel>> _birthdayController =
      StreamController<List<BirthdayModel>>();

  Stream<List<BirthdayModel>> get birthdays => _birthdayController.stream;

  Future<void> initialize() async {
    List<Map<String, dynamic>> maps = await database.query('birthdays');
    listBirthdays.addAll(maps);

    List<BirthdayModel> birthdays = listBirthdays
        .map((e) => BirthdayModel(
            id: e['id'],
            firstname: e['firstname'],
            surname: e['surname'],
            date: e['date']))
        .toList();

    _birthdayController.add(birthdays);
  }

  // ADD
  Future<void> addNewBirthday(Map<String, dynamic> data) async {
    List<Map> result =
        await database.rawQuery("SELECT MAX(id) as maxID FROM birthdays");
    var raw = result.first;
    var lastID = raw['maxID'];
    if (lastID == null) {
      lastID = 1;
    } else {
      lastID = raw['maxID'] + 1;
    }

    final BirthdayModel birthday = BirthdayModel(
      id: lastID,
      firstname: data['firstname'],
      surname: data['surname'],
      date: data['date'],
    );

    int id = await database.insert(
      'birthdays',
      birthday.toJSON(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    listBirthdays.add({
      ...data,
      ...{'id': id}
    });

    List<BirthdayModel> birthdays = listBirthdays
        .map((e) => BirthdayModel(
            id: e['id'],
            firstname: e['firstname'],
            surname: e['surname'],
            date: e['date']))
        .toList();

    _birthdayController.add(birthdays);
  }

  // EDIT
  Future<void> editBirthday(
      int id, int index, Map<String, dynamic> data) async {
    final BirthdayModel birthday = BirthdayModel(
      id: id,
      firstname: data['firstname'],
      surname: data['surname'],
      date: data['date'],
    );

    await database.update(
      'birthdays',
      birthday.toJSON(),
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    listBirthdays[index] = {
      ...data,
      ...{'id': id}
    };

    List<BirthdayModel> birthdays = listBirthdays
        .map((e) => BirthdayModel(
            id: e['id'],
            firstname: e['firstname'],
            surname: e['surname'],
            date: e['date']))
        .toList();

    _birthdayController.add(birthdays);
  }

  // REMOVE
  Future<void> removeBirthday(BirthdayModel birthdayModel) async {
    await database.delete(
      'birthdays',
      where: 'id = ?',
      whereArgs: [
        birthdayModel.id,
      ],
    );

    listBirthdays.removeWhere((e) => e['id'] == birthdayModel.id);

    List<BirthdayModel> birthdays = listBirthdays
        .map((e) => BirthdayModel(
            id: e['id'],
            firstname: e['firstname'],
            surname: e['surname'],
            date: e['date']))
        .toList();

    _birthdayController.add(birthdays);
  }
}
