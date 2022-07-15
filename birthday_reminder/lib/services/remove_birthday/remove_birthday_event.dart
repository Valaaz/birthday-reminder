part of 'remove_birthday_bloc.dart';

abstract class RemoveBirthdayEvent extends Equatable {
  const RemoveBirthdayEvent();

  @override
  List<Object> get props => [];
}

class OnRemoveBirthdayEvent extends RemoveBirthdayEvent {
  final BirthdayModel birthdayModel;

  const OnRemoveBirthdayEvent({
    required this.birthdayModel,
  });

  @override
  List<Object> get props => [
        birthdayModel,
      ];
}
