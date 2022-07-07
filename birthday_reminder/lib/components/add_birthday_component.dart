import 'package:flutter/material.dart';

class AddBirthdayComponent extends StatelessWidget {
  const AddBirthdayComponent({Key? key}) : super(key: key);

  void _modal(BuildContext context) => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration:
                      InputDecoration(hintText: "Entrez le prénom et le nom"),
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
                      onPressed: () => Navigator.pop(context),
                      child: Text("Ajouter".toUpperCase()),
                    ),
                  ],
                ),
              ),
            ],
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
