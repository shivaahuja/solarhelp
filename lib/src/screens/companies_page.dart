// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:solarhelp/src/models/company.dart';
import 'package:solarhelp/src/screens/add_company.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({Key? key}) : super(key: key);

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  final _database = FirebaseDatabase.instance.ref();
  final _user = FirebaseAuth.instance.currentUser!.uid;
  final String _admin = 'mdZm8SQVDBR5TUsRdnPj11w5bfm1';
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
        actions: [
          Visibility(
            visible: _user == _admin ? true : false,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddCompany()));
                },
                child: const Icon(Icons.add_business_outlined)),
          )
        ],
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
