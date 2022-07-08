part of 'add_birthday_bloc.dart';

abstract class AddBirthdayEvent extends Equatable {
  const AddBirthdayEvent();

  @override
  List<Object> get props => [];
}

class OnAddBirthdayEvent extends AddBirthdayEvent {
  final String name;
  final String date;

  const OnAddBirthdayEvent({
    required this.name,
    required this.date,
  });
}
