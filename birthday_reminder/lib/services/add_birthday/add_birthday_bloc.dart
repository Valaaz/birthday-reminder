//import 'package:bloc/bloc.dart';
import 'package:birthday_reminder/repositories/birthday_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_birthday_event.dart';
part 'add_birthday_state.dart';

class AddBirthdayBloc extends Bloc<AddBirthdayEvent, AddBirthdayState> {
  final BirthdayRepository birthdayRepository;

  AddBirthdayBloc(this.birthdayRepository) : super(AddBirthdayInitial()) {
    on<OnAddBirthdayEvent>((event, emit) async {
      await birthdayRepository.addNewBirthday({
        "firstname": event.firstname,
        "surname": event.surname,
        "date": event.date,
      });

      emit(AddBirthdaySuccessState(
        timeStamp: DateTime.now().millisecondsSinceEpoch,
      ));
    });
  }
}
