import 'package:birthday_reminder/services/add_birthday/add_birthday_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBirthdayComponent extends StatefulWidget {
  const AddBirthdayComponent({Key? key}) : super(key: key);

  @override
  State<AddBirthdayComponent> createState() => _AddBirthdayComponentState();
}

class _AddBirthdayComponentState extends State<AddBirthdayComponent> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  DateTime date = DateTime.now();

  @override
  void dispose() {
    _firstnameController.dispose();
    _surnameController.dispose();
    _dateController.dispose();

    super.dispose();
  }

  void _modal(BuildContext context) => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => StatefulBuilder(
            builder: ((context, setState) =>
                BlocListener<AddBirthdayBloc, AddBirthdayState>(
                  listener: (context, state) {
                    if (state is AddBirthdaySuccessState) {
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green[800],
                        content: Row(children: const [
                          Icon(Icons.check_circle, color: Colors.white),
                          SizedBox(width: 20),
                          Expanded(
                              child: Text("L'anniversaire a bien été ajouté")),
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
                            "Ajouter un nouvel anniversaire",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _firstnameController,
                            decoration: const InputDecoration(
                                hintText: "Entrez le prénom"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _surnameController,
                            decoration: const InputDecoration(
                                hintText: "Entrez le nom"),
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
                                    initialDate: DateTime.now(),
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
                                  _firstnameController.clear();
                                  _surnameController.clear();
                                  date = DateTime.now();
                                },
                                child: Text("Annuler".toUpperCase()),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (_firstnameController.text.isNotEmpty &&
                                      _surnameController.text.isNotEmpty) {
                                    context
                                        .read<AddBirthdayBloc>()
                                        .add(OnAddBirthdayEvent(
                                          firstname:
                                              _firstnameController.text.trim(),
                                          surname:
                                              _surnameController.text.trim(),
                                          date:
                                              '${date.day}/${date.month}/${date.year}',
                                        ));

                                    _firstnameController.clear();
                                    _surnameController.clear();
                                    date = DateTime.now();
                                  } else {
                                    String emptyText;
                                    _firstnameController.text.isEmpty
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
                                child: Text("Ajouter".toUpperCase()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ))),
      );

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _modal(context),
      child: const Icon(Icons.add),
    );
  }
}
