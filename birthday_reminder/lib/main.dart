import 'package:birthday_reminder/screens/home_screen.dart';
import 'package:birthday_reminder/services/add_birthday/add_birthday_bloc.dart';
import 'package:birthday_reminder/services/list_birthday/list_birthday_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<Map<String, dynamic>> listBirthdays = [
  {'name': 'John Doe', 'date': '25/04/2002'},
  {'name': 'Valentin Azancoth', 'date': '25/06/2001'},
  {'name': 'Bob Bobby', 'date': '14/12/1988'},
];

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListBirthdayBloc>(
          lazy: false,
          create: (context) => ListBirthdayBloc(listBirthdays)
            ..add(OninitializeListBirthdayEvent()),
        ),
        BlocProvider<AddBirthdayBloc>(
          create: (context) => AddBirthdayBloc(),
        )
      ],
      child: MaterialApp(
        title: "Birthday Reminder",
        theme: ThemeData(primarySwatch: Colors.purple),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
