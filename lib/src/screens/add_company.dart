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
  // ignore: prefer_typing_uninitialized_variables
  var link;
  @override
  Widget build(BuildContext context) {
    final company = database;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 75),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                'Add a new Company',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
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
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(77, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
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
                        await storage
                            .ref('/images/${_nameController.text}')
                            .putFile(file);
                        link = await storage
                            .ref('/images/${_nameController.text}')
                            .getDownloadURL();
                      } on firebase_core.FirebaseException catch (e) {
                        Fluttertoast.showToast(
                            msg: e.message ?? 'unkown error');
                      }
                    },
                    child: const Text('Upload Logo'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(88, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
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
          ],
        ),
      ),
    );
  }
}
