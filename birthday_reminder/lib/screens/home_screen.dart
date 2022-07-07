import 'package:birthday_reminder/components/add_birthday_component.dart';
import 'package:birthday_reminder/models/birthday_model.dart';
import 'package:birthday_reminder/services/list_birthday/list_birthday_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Birthday Reminder"),
      ),
      body: const ListViewTiles(),
      backgroundColor: const Color.fromARGB(255, 135, 84, 144),
      floatingActionButton: const AddBirthdayComponent(),
    );
  }
}

class ListViewTiles extends StatelessWidget {
  const ListViewTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBirthdayBloc, ListBirthdayState>(
      builder: (context, state) {
        List<BirthdayModel> listBirthday = [];

        if (state is ListBirthdayInitialState) {
          listBirthday = state.listBirthday;
        }

        return listBirthday.isEmpty
            ? const Center(child: Text("La liste d'anniversaire est vide"))
            : ListView.separated(
                itemCount: listBirthday.length,
                separatorBuilder: (context, index) => const Divider(
                  color: Color.fromARGB(255, 56, 4, 65),
                  thickness: 3,
                  indent: 10,
                  endIndent: 110,
                ),
                itemBuilder: (context, index) {
                  String birthday =
                      '${listBirthday[index].name} - ${listBirthday[index].date}';

                  return Card(
                    margin: const EdgeInsets.only(
                        left: 15, top: 10, right: 120, bottom: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      title: Text(birthday),
                    ),
                  );
                },
              );
      },
    );
  }
}
