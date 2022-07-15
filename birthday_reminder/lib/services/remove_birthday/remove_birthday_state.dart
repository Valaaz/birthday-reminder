part of 'remove_birthday_bloc.dart';

abstract class RemoveBirthdayState extends Equatable {
  const RemoveBirthdayState();

  @override
  List<Object> get props => [];
}

class RemoveBirthdayInitial extends RemoveBirthdayState {}

class RemoveBirthdaySuccessState extends RemoveBirthdayState {
  final int timeStamp;

  const RemoveBirthdaySuccessState({
    required this.timeStamp,
  });

  @override
  List<Object> get props => [
        timeStamp,
      ];
}
