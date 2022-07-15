part of 'edit_birthday_bloc.dart';

abstract class EditBirthdayEvent extends Equatable {
  const EditBirthdayEvent();

  @override
  List<Object> get props => [];
}

class OnEditBirthdayEvent extends EditBirthdayEvent {
  final String firstname;
  final String surname;
  final String date;

  const OnEditBirthdayEvent({
    required this.firstname,
    required this.surname,
    required this.date,
  });
}
