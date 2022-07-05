import 'package:flutter/material.dart';

const List<Map<String, dynamic>> listBirthdays = [
  {'name': 'John Doe', 'date': '25/04/2002'},
  {'name': 'Valentin Azancoth', 'date': '25/06/2001'},
  {'name': 'Bob Bobby', 'date': '14/12/1988'},
  // {'name': 'John Doe', 'date': '25/04/2002'},
  // {'name': 'Valentin Azancoth', 'date': '25/06/2001'},
  // {'name': 'Bob Bobby', 'date': '14/12/1988'},
  // {'name': 'John Doe', 'date': '25/04/2002'},
  // {'name': 'Valentin Azancoth', 'date': '25/06/2001'},
  // {'name': 'Bob Bobby', 'date': '14/12/1988'},
  // {'name': 'John Doe', 'date': '25/04/2002'},
  // {'name': 'Valentin Azancoth', 'date': '25/06/2001'},
  // {'name': 'Bob Bobby', 'date': '14/12/1988'},
];

void _modal(BuildContext context) => showModalBottomSheet(
      context: context,
      builder: (context) => const Center(
        child: Text("Coucou bg"),
      ),
    );

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _modal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListViewTiles extends StatelessWidget {
  const ListViewTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return listBirthdays.isEmpty
        ? const Center(child: Text("La liste d'anniversaire est vide"))
        : ListView.separated(
            itemCount: listBirthdays.length,
            separatorBuilder: (context, index) => const Divider(
              color: Color.fromARGB(255, 56, 4, 65),
              thickness: 3,
              indent: 10,
              endIndent: 10,
            ),
            itemBuilder: (context, index) {
              String birthday = listBirthdays[index]['name'] +
                  ' - ' +
                  listBirthdays[index]['date'];

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
  }
}
