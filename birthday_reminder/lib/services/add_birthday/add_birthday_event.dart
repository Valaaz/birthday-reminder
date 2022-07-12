part of 'add_birthday_bloc.dart';

abstract class AddBirthdayEvent extends Equatable {
  const AddBirthdayEvent();

  @override
  List<Object> get props => [];
}

class OnAddBirthdayEvent extends AddBirthdayEvent {
  final String firstname;
  final String surname;
  final String date;

  const OnAddBirthdayEvent({
    required this.firstname,
    required this.surname,
    required this.date,
  });
}
