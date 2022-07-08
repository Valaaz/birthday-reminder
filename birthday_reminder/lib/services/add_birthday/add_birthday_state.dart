part of 'add_birthday_bloc.dart';

abstract class AddBirthdayState extends Equatable {
  const AddBirthdayState();

  @override
  List<Object> get props => [];
}

class AddBirthdayInitial extends AddBirthdayState {}

class AddBirthdaySuccess extends AddBirthdayState {}
