import 'package:flutter/material.dart';

const List<Map<String, dynamic>> listBirthdays = [
  {'name': 'John Doe', 'date': '25/04/2002'},
  {'name': 'Valentin Azancoth', 'date': '25/06/2001'},
  {'name': 'Bob Bobby', 'date': '14/12/1988'},
];

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Birthday Reminder"),
        ),
        body: const ListViewTiles(),
        backgroundColor: const Color.fromARGB(255, 135, 84, 144),
      ),
      debugShowCheckedModeBanner: false,
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
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  title: Text(listBirthdays[index]['name']),
                ),
              );
            },
          );
  }
}

// class Tile extends StatefulWidget {
//   const Tile({
//     Key? key,
//     this.name = "",
//   }) : super(key: key);

//   final String name;

//   @override
//   State<Tile> createState() => _TileState();
// }

// class _TileState extends State<Tile> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.grey,
//       height: 50,
//       child: Text(widget.name),
//     );
//   }
// }
