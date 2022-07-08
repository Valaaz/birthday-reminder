//import 'package:bloc/bloc.dart';
import 'package:birthday_reminder/models/birthday_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_birthday_event.dart';
part 'add_birthday_state.dart';

class AddBirthdayBloc extends Bloc<AddBirthdayEvent, AddBirthdayState> {
  AddBirthdayBloc() : super(AddBirthdayInitial()) {
    on<OnAddBirthdayEvent>((event, emit) {
      final BirthdayModel birthday =
          BirthdayModel(name: event.name, date: event.date);

      print(birthday);
      emit(AddBirthdaySuccess());
    });
  }
}
