import 'package:birthday_reminder/services/add_birthday/add_birthday_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBirthdayComponent extends StatefulWidget {
  const AddBirthdayComponent({Key? key}) : super(key: key);

  @override
  State<AddBirthdayComponent> createState() => _AddBirthdayComponentState();
}

class _AddBirthdayComponentState extends State<AddBirthdayComponent> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void _modal(BuildContext context) => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => BlocListener<AddBirthdayBloc, AddBirthdayState>(
          listener: (context, state) {
            if (state is AddBirthdaySuccess) {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green[800],
                content: Row(children: const [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 20),
                  Expanded(child: Text("L'anniversaire a bien été ajouté")),
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
                    controller: _controller,
                    decoration: const InputDecoration(
                        hintText: "Entrez le prénom et le nom"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Annuler".toUpperCase()),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            context
                                .read<AddBirthdayBloc>()
                                .add(OnAddBirthdayEvent(
                                  name: _controller.text,
                                  date: "date",
                                ));

                            _controller.clear();
                          } else {
                            Navigator.pop(context);

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red[800],
                              content: Row(children: const [
                                Icon(Icons.error, color: Colors.white),
                                SizedBox(width: 20),
                                Expanded(
                                    child: Text(
                                        "Le prénom ne peut pas être vide")),
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
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _modal(context),
      child: const Icon(Icons.add),
    );
  }
}
