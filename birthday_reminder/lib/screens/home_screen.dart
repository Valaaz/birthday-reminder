import 'package:birthday_reminder/components/add_birthday_component.dart';
import 'package:birthday_reminder/models/birthday_model.dart';
import 'package:birthday_reminder/services/list_birthday/list_birthday_bloc.dart';
import 'package:birthday_reminder/services/remove_birthday/remove_birthday_bloc.dart';
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
    return BlocListener<RemoveBirthdayBloc, RemoveBirthdayState>(
      listener: (context, state) {
        if (state is RemoveBirthdaySuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Anniversaire supprimé"),
            ),
          );
        }
      },
      child: BlocConsumer<ListBirthdayBloc, ListBirthdayState>(
        listener: ((context, state) {}),
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
                        '${listBirthday[index].firstname} ${listBirthday[index].surname} - ${listBirthday[index].date}';

                    return Dismissible(
                      key: Key(
                          "{index.toString()}-${DateTime.now().microsecondsSinceEpoch}"),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          return await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title:
                                      const Text("Confirmation de suppression"),
                                  content: const Text(
                                      "Êtes-vous sûr de vouloir supprimer cet anniversaire ?"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("Oui"),
                                      onPressed: () => {
                                        Navigator.of(context).pop(true),
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("Non"),
                                      onPressed: () => {
                                        Navigator.pop(context),
                                      },
                                    )
                                  ],
                                );
                              });
                        } else if (direction == DismissDirection.startToEnd) {
                          // TODO : edit
                          return false;
                        }
                        return null;
                      },
                      onDismissed: (direction) =>
                          dismissItem(context, index, direction, listBirthday),
                      background: buildSwipeActionLeft(),
                      secondaryBackground: buildSwipeActionRight(),
                      child: Card(
                        margin: const EdgeInsets.only(
                            left: 15, top: 10, right: 120, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          title: Text(birthday),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  Widget buildSwipeActionLeft() => Container(
        color: Colors.blue[800],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(Icons.edit),
            ],
          ),
        ),
      );

  Widget buildSwipeActionRight() => Container(
        color: Colors.red[800],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(Icons.delete),
            ],
          ),
        ),
      );

  void dismissItem(BuildContext context, int index, DismissDirection direction,
      dynamic listBirthday) {
    switch (direction) {
      case DismissDirection.endToStart:
        context.read<RemoveBirthdayBloc>().add(
              OnRemoveBirthdayEvent(birthdayModel: listBirthday[index]),
            );
        break;
      case DismissDirection.startToEnd:
        break;
      default:
        break;
    }
  }
}
