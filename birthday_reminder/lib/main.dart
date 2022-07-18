import 'package:birthday_reminder/repositories/birthday_repository.dart';
import 'package:birthday_reminder/screens/home_screen.dart';
import 'package:birthday_reminder/services/add_birthday/add_birthday_bloc.dart';
import 'package:birthday_reminder/services/edit_birthday/edit_birthday_bloc.dart';
import 'package:birthday_reminder/services/list_birthday/list_birthday_bloc.dart';
import 'package:birthday_reminder/services/remove_birthday/remove_birthday_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Database database = await openDatabase(
    join(await getDatabasesPath(), 'birthdays.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE birthdays(id INTEGER PRIMARY KEY, firstname TEXT, surname TEXT, date TEXT)',
      );
    },
    version: 1,
  );

  final BirthdayRepository birthdayRepository = BirthdayRepository(
    database: database,
  );

  runApp(App(
    birthdayRepository: birthdayRepository,
  ));
}

class App extends StatelessWidget {
  final BirthdayRepository birthdayRepository;

  const App({Key? key, required this.birthdayRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListBirthdayBloc>(
          lazy: false,
          create: (context) => ListBirthdayBloc(birthdayRepository)
            ..add(OnInitializeListBirthdayEvent()),
        ),
        BlocProvider<AddBirthdayBloc>(
          create: (context) => AddBirthdayBloc(birthdayRepository),
        ),
        BlocProvider<RemoveBirthdayBloc>(
          create: (context) => RemoveBirthdayBloc(birthdayRepository),
        ),
        BlocProvider<EditBirthdayBloc>(
          create: (context) => EditBirthdayBloc(birthdayRepository),
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
