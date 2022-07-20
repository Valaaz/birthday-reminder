part of 'edit_birthday_bloc.dart';

abstract class EditBirthdayEvent extends Equatable {
  const EditBirthdayEvent();

  @override
  List<Object> get props => [];
}

class OnEditBirthdayEvent extends EditBirthdayEvent {
  final int id;
  final int index;
  final String firstname;
  final String surname;
  final String date;

  const OnEditBirthdayEvent({
    required this.id,
    required this.index,
    required this.firstname,
    required this.surname,
    required this.date,
  });
}
