class BirthdayModel {
  final int id;
  final String firstname;
  final String surname;
  final String date;

  const BirthdayModel({
    required this.id,
    required this.firstname,
    required this.surname,
    required this.date,
  });

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'firstname': firstname,
      'surname': surname,
      'date': date,
    };
  }
}
