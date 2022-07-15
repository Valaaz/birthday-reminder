import 'package:birthday_reminder/models/birthday_model.dart';
import 'package:birthday_reminder/repositories/birthday_repository.dart';
//import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'remove_birthday_event.dart';
part 'remove_birthday_state.dart';

class RemoveBirthdayBloc
    extends Bloc<RemoveBirthdayEvent, RemoveBirthdayState> {
  final BirthdayRepository birthdayRepository;

  RemoveBirthdayBloc(
    this.birthdayRepository,
  ) : super(RemoveBirthdayInitial()) {
    on<OnRemoveBirthdayEvent>((event, emit) async {
      await birthdayRepository.removeBirthday(event.birthdayModel);

      emit(RemoveBirthdaySuccessState(
        timeStamp: DateTime.now().millisecondsSinceEpoch,
      ));
    });
  }
}
