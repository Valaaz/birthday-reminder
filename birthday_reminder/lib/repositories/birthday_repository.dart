import 'dart:async';

import 'package:birthday_reminder/models/birthday_model.dart';

class BirthdayRepository {
  final List<Map<String, dynamic>> listBirthdays;

  BirthdayRepository({
    required this.listBirthdays,
  }) {
    List<BirthdayModel> birthdays = listBirthdays
        .map((e) => BirthdayModel(
            firstname: e['firstname'], surname: e['surname'], date: e['date']))
        .toList();

    _birthdayController.add(birthdays);
  }

  final StreamController<List<BirthdayModel>> _birthdayController =
      StreamController<List<BirthdayModel>>();

  Stream<List<BirthdayModel>> get birthdays => _birthdayController.stream;

  Future<void> addNewBirthday(Map<String, dynamic> data) async {
    listBirthdays.add(data);

    List<BirthdayModel> birthdays = listBirthdays
        .map((e) => BirthdayModel(
            firstname: e['firstname'], surname: e['surname'], date: e['date']))
        .toList();

    _birthdayController.add(birthdays);
  }

  Future<void> editBirthday(Map<String, dynamic> data) async {
    listBirthdays.add(data);

    List<BirthdayModel> birthdays = listBirthdays
        .map((e) => BirthdayModel(
            firstname: e['firstname'], surname: e['surname'], date: e['date']))
        .toList();

    _birthdayController.add(birthdays);
  }

  Future<void> removeBirthday(BirthdayModel birthdayModel) async {
    listBirthdays.removeWhere((e) =>
        e['firstname'] == birthdayModel.firstname &&
        e['surname'] == birthdayModel.surname &&
        e['date'] == birthdayModel.date);

    List<BirthdayModel> birthdays = listBirthdays
        .map((e) => BirthdayModel(
            firstname: e['firstname'], surname: e['surname'], date: e['date']))
        .toList();

    _birthdayController.add(birthdays);
  }
}
