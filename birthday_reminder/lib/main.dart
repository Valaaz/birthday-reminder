import 'package:birthday_reminder/repositories/birthday_repository.dart';
import 'package:birthday_reminder/screens/home_screen.dart';
import 'package:birthday_reminder/services/add_birthday/add_birthday_bloc.dart';
import 'package:birthday_reminder/services/list_birthday/list_birthday_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final List<Map<String, dynamic>> listBirthdays = [
  {'firstname': 'John', 'surname': 'Doe', 'date': '25/04/2002'},
  {'firstname': 'Valentin', 'surname': 'Azancoth', 'date': '25/06/2001'},
  {'firstname': 'Bob', 'surname': 'Bobby', 'date': '14/12/1988'},
];

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final BirthdayRepository birthdayRepository = BirthdayRepository(
      listBirthdays: listBirthdays,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<ListBirthdayBloc>(
          lazy: false,
          create: (context) => ListBirthdayBloc(birthdayRepository),
        ),
        BlocProvider<AddBirthdayBloc>(
          create: (context) => AddBirthdayBloc(birthdayRepository),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('fr', 'FR'),
        ],
        title: "Birthday Reminder",
        theme: ThemeData(primarySwatch: Colors.purple),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
