import 'package:flutter/material.dart';

class BirthdayScreen extends StatelessWidget {
  const BirthdayScreen({Key? key, required this.payload}) : super(key: key);

  final String payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anniversaire"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(payload),
      ),
    );
  }
}
