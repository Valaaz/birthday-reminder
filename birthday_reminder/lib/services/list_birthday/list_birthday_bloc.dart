import 'package:birthday_reminder/models/birthday_model.dart';
import 'package:birthday_reminder/repositories/birthday_repository.dart';
//import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_birthday_event.dart';
part 'list_birthday_state.dart';

class ListBirthdayBloc extends Bloc<ListBirthdayEvent, ListBirthdayState> {
  final BirthdayRepository birthdayRepository;

  ListBirthdayBloc(
    this.birthdayRepository,
  ) : super(ListBirthdayInitialState(
            listBirthday: List<BirthdayModel>.from([]))) {
    birthdayRepository.birthdays.listen((birthdays) {
      add(_OnBirthdayUpdatedListBirthdayEvent(birthdays: birthdays));
    });

    on<_OnBirthdayUpdatedListBirthdayEvent>((event, emit) {
      emit(ListBirthdayInitialState(
        listBirthday: event.birthdays,
      ));
    });
  }
}
