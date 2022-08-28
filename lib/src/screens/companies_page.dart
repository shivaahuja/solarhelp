// ignore_for_file: must_be_immutable

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:solarhelp/src/models/company.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({Key? key}) : super(key: key);

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  final _database = FirebaseDatabase.instance.ref();

  final ref = FirebaseDatabase.instance.ref();

  Query dbRef = FirebaseDatabase.instance.ref().child('Companies');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Companies Name',
        ),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: _database.child('companies').onValue,
            builder: (context, AsyncSnapshot snap) {
              final tilesList = <ListTile>[];
              if (snap.hasData) {
                final companies =
                    Map<String, dynamic>.from(snap.data.snapshot.value);
                companies.forEach((key, value) {
                  final nextCompany =
                      Company.fromRTDB(Map<String, dynamic>.from(value));
                  final companyTile = ListTile(
                    leading: const Icon(Icons.store),
                    title: Text(nextCompany.name),
                    subtitle: Text(nextCompany.link),
                  );
                  tilesList.add(companyTile);
                });
              }
              return Expanded(
                child: ListView(
                  children: tilesList,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
