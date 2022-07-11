import 'package:birthday_reminder/models/birthday_model.dart';

class BirthdayRepository {
  final List<Map<String, dynamic>> listBirthdays = [
    {'name': 'John Doe', 'date': '25/04/2002'},
    {'name': 'Valentin Azancoth', 'date': '25/06/2001'},
    {'name': 'Bob Bobby', 'date': '14/12/1988'},
  ];

  Stream<List<BirthdayModel>> get birthdays => Stream.value(listBirthdays
      .map((e) => BirthdayModel(
            name: e['name'],
            date: e['date'],
          ))
      .toList());
}
