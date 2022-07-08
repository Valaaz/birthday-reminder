import 'package:birthday_reminder/models/birthday_model.dart';
//import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_birthday_event.dart';
part 'list_birthday_state.dart';

class ListBirthdayBloc extends Bloc<ListBirthdayEvent, ListBirthdayState> {
  List<Map<String, dynamic>> listBirthdays;

  ListBirthdayBloc(this.listBirthdays)
      : super(ListBirthdayInitialState(
            listBirthday: List<BirthdayModel>.from([]))) {
    on<OninitializeListBirthdayEvent>((event, emit) {
      List<BirthdayModel> listBirthdayModel = listBirthdays
          .map((e) => BirthdayModel(
                name: e["name"],
                date: e["date"],
              ))
          .toList();

      emit(ListBirthdayInitialState(listBirthday: listBirthdayModel));
    });
  }
}
