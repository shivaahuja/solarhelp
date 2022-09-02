import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class AddCompany extends StatefulWidget {
  const AddCompany({Key? key}) : super(key: key);

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  final database = FirebaseDatabase.instance.ref('/companies');
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  var link;
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
              TextField(
                controller: _ratingController,
                decoration: const InputDecoration(
                  hintText: 'Rating',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final logo = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg'],
                  );
                  if (logo == null) {
                    Fluttertoast.showToast(msg: 'No file was selected');
                  }
                  final path = logo!.files.single.path;
                  File file = File(path!);
                  try {
                    await storage.ref('images/').putFile(file);
                    link = await storage.ref('images/').getDownloadURL();
                  } on firebase_core.FirebaseException catch (e) {
                    Fluttertoast.showToast(msg: e.message ?? 'unkown error');
                  }
                },
                child: const Text('uploadfile'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await company.push().update({
                    'Name': _nameController.text,
                    'Link': _linkController.text,
                    'Rating': int.parse(_ratingController.text),
                    'LogoLink': link,
                  });
                  Fluttertoast.showToast(msg: 'Company has been added');
                  _nameController.clear();
                  _linkController.clear();
                  _ratingController.clear();
                },
                child: const Text('Add company'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
