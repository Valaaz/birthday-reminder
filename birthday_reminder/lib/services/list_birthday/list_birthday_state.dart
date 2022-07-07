part of 'list_birthday_bloc.dart';

abstract class ListBirthdayState extends Equatable {
  const ListBirthdayState();

  @override
  List<Object> get props => [];
}

class ListBirthdayInitialState extends ListBirthdayState {
  final List<BirthdayModel> listBirthday;

  const ListBirthdayInitialState({required this.listBirthday});

  @override
  List<Object> get props => [
        listBirthday,
      ];
}
