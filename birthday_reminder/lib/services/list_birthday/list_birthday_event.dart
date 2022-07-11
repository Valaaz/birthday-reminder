part of 'list_birthday_bloc.dart';

abstract class ListBirthdayEvent extends Equatable {
  const ListBirthdayEvent();

  @override
  List<Object> get props => [];
}

class _OnBirthdayUpdatedListBirthdayEvent extends ListBirthdayEvent {
  final List<BirthdayModel> birthdays;

  const _OnBirthdayUpdatedListBirthdayEvent({
    required this.birthdays,
  });

  @override
  List<Object> get props => [
        birthdays,
      ];
}
