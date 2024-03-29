import 'package:birthday_reminder/components/add_birthday_component.dart';
import 'package:birthday_reminder/models/birthday_model.dart';
import 'package:birthday_reminder/repositories/birthday_repository.dart';
import 'package:birthday_reminder/screens/birthday_screen.dart';
import 'package:birthday_reminder/services/edit_birthday/edit_birthday_bloc.dart';
import 'package:birthday_reminder/services/list_birthday/list_birthday_bloc.dart';
import 'package:birthday_reminder/services/notification/notification_service.dart';
import 'package:birthday_reminder/services/remove_birthday/remove_birthday_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.birthdayRepository})
      : super(key: key);

  final BirthdayRepository birthdayRepository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final NotificationService notificationService;

  @override
  void initState() {
    super.initState();
    notificationService = NotificationService();
    notificationService.initialize();
    listenNotification();
    checkBirthday(widget.birthdayRepository);
  }

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

  void listenNotification() => notificationService.onNotificationClick.stream
      .listen(onNotificationListener);

  void onNotificationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => BirthdayScreen(payload: payload))));
    }
  }

  void checkBirthday(BirthdayRepository birthdayRepository) {
    int count = 0;

    birthdayRepository.birthdays.forEach((element) {
      for (var e in element) {
        final splittedDate = e.date.split('/');
        int days = int.parse(splittedDate[0]);
        int months = int.parse(splittedDate[1]);
        if (daysBetween(DateTime(DateTime.now().year, months, days)) == 0) {
          notificationService.showNotificationPayload(
              id: count++,
              title: 'Il y a un anniversaire !',
              body: "C'est l'anniversaire de ${e.firstname} ${e.surname}",
              payload: 'payload');
        }
      }
    });
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
              ? const Center(
                  child: Text(
                  "La liste d'anniversaire est vide",
                  style: TextStyle(color: Colors.white),
                ))
              : ListView.separated(
                  itemCount: listBirthday.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Color.fromARGB(255, 56, 4, 65),
                    thickness: 3,
                    indent: 10,
                    endIndent: 10,
                  ),
                  itemBuilder: (context, index) {
                    String birthday =
                        '${listBirthday[index].firstname} ${listBirthday[index].surname} - ${listBirthday[index].date}';
                    final splittedDate = listBirthday[index].date.split('/');
                    int days = int.parse(splittedDate[0]);
                    int months = int.parse(splittedDate[1]);

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
                          edit(context, listBirthday[index], index);
                          return false;
                        }
                        return null;
                      },
                      onDismissed: (direction) =>
                          dismissItem(context, index, direction, listBirthday),
                      background: buildSwipeActionLeft(),
                      secondaryBackground: buildSwipeActionRight(),
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              margin: const EdgeInsets.only(
                                  left: 15, top: 10, bottom: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: ListTile(
                                title: Text(birthday),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 65,
                            width: 65,
                            margin: const EdgeInsets.only(right: 15),
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Center(
                                child: Text(
                              "${daysBetween(DateTime(DateTime.now().year, months, days))}j restants",
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ],
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

void edit(BuildContext context, BirthdayModel birthdayModel, index) {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();

  firstnameController.text = birthdayModel.firstname;
  surnameController.text = birthdayModel.surname;

  final splittedDate = birthdayModel.date.split('/');
  DateTime formattedDate = DateTime(int.parse(splittedDate[2]),
      int.parse(splittedDate[1]), int.parse(splittedDate[0]));
  DateTime date = formattedDate;

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => StatefulBuilder(
        builder: ((context, setState) =>
            BlocListener<EditBirthdayBloc, EditBirthdayState>(
              listener: (context, state) {
                if (state is EditBirthdaySuccessState) {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green[800],
                    content: Row(children: const [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 20),
                      Expanded(
                          child: Text("L'anniversaire a bien été modifié")),
                    ]),
                  ));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Modifier un anniversaire",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: firstnameController,
                        decoration:
                            const InputDecoration(hintText: "Entrez le prénom"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: surnameController,
                        decoration:
                            const InputDecoration(hintText: "Entrez le nom"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                            child: const Text("Sélectionner une date"),
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(1900, 1, 1),
                                lastDate: DateTime.now(),
                                locale: const Locale('fr', 'FR'),
                              );

                              if (newDate == null) return;
                              setState(() => date = newDate);
                            },
                          ),
                          const SizedBox(width: 60),
                          Text('${date.day}/${date.month}/${date.year}'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              firstnameController.clear();
                              surnameController.clear();
                              date = date;
                            },
                            child: Text("Annuler".toUpperCase()),
                          ),
                          TextButton(
                            onPressed: () {
                              if (firstnameController.text.isNotEmpty &&
                                  surnameController.text.isNotEmpty) {
                                context
                                    .read<EditBirthdayBloc>()
                                    .add(OnEditBirthdayEvent(
                                      id: birthdayModel.id,
                                      index: index,
                                      firstname:
                                          firstnameController.text.trim(),
                                      surname: surnameController.text.trim(),
                                      date:
                                          '${date.day}/${date.month}/${date.year}',
                                    ));

                                firstnameController.clear();
                                surnameController.clear();
                                date = DateTime.now();
                              } else {
                                String emptyText;
                                firstnameController.text.isEmpty
                                    ? emptyText = "prénom"
                                    : emptyText = "nom";

                                Navigator.pop(context);

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.red[800],
                                  content: Row(children: [
                                    const Icon(Icons.error,
                                        color: Colors.white),
                                    const SizedBox(width: 20),
                                    Expanded(
                                        child: Text(
                                            "Le $emptyText ne peut pas être vide")),
                                  ]),
                                ));
                              }
                            },
                            child: Text("Valider".toUpperCase()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))),
  );
}

int daysBetween(DateTime birthday) {
  DateTime today = DateTime.now();

  if (today.month == birthday.month) {
    if (today.day > birthday.day) {
      birthday = DateTime(birthday.year + 1, birthday.month, birthday.day);
    }
  } else if (today.month > birthday.month) {
    birthday = DateTime(birthday.year + 1, birthday.month, birthday.day);
  }

  today = DateTime(today.year, today.month, today.day);
  return (birthday.difference(today).inHours / 24).round();
}
