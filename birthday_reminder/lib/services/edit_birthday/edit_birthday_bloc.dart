//import 'package:bloc/bloc.dart';
import 'package:birthday_reminder/repositories/birthday_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_birthday_event.dart';
part 'edit_birthday_state.dart';

class EditBirthdayBloc extends Bloc<EditBirthdayEvent, EditBirthdayState> {
  final BirthdayRepository birthdayRepository;

  EditBirthdayBloc(this.birthdayRepository) : super(EditBirthdayInitial()) {
    on<OnEditBirthdayEvent>((event, emit) async {
      await birthdayRepository.editBirthday(event.id, event.index, {
        "firstname": event.firstname,
        "surname": event.surname,
        "date": event.date,
      });

      emit(EditBirthdaySuccessState(
        timeStamp: DateTime.now().millisecondsSinceEpoch,
      ));
    });
  }
}
