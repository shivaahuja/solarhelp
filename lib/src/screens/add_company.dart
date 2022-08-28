import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({Key? key}) : super(key: key);

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  final database = FirebaseDatabase.instance.ref('/companies');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
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
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
              ),
              TextField(
                controller: _linkController,
                decoration: const InputDecoration(
                  hintText: 'Link',
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await company.push().update({
                      'Name': _nameController.text,
                      'Link': _linkController.text
                    });
                    Fluttertoast.showToast(msg: 'Company has been added');
                    _nameController.text = '';
                    _linkController.text = '';
                  },
                  child: const Text('Add company'))
            ],
          ),
        ),
      ),
    );
  }
}
