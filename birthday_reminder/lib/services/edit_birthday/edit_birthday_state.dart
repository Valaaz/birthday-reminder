part of 'edit_birthday_bloc.dart';

abstract class EditBirthdayState extends Equatable {
  const EditBirthdayState();

  @override
  List<Object> get props => [];
}

class EditBirthdayInitial extends EditBirthdayState {}

class EditBirthdaySuccessState extends EditBirthdayState {
  final int timeStamp;

  const EditBirthdaySuccessState({
    required this.timeStamp,
  });

  @override
  List<Object> get props => [
        timeStamp,
      ];
}
