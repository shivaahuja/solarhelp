import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({Key? key}) : super(key: key);

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  final database = FirebaseDatabase.instance.ref('/companies');
  @override
  Widget build(BuildContext context) {
    final company = database;
    return Scaffold(
      appBar: AppBar(title: const Text('Add Company')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await company
                        .push()
                        .update({'Name': 'Google', 'Link': 'www.google.com'});
                    debugPrint('Company Added');
                  },
                  child: const Text('Add company'))
            ],
          ),
        ),
      ),
    );
  }
}
