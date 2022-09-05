// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:solarhelp/src/models/company.dart';
import 'package:solarhelp/src/screens/add_company.dart';
import 'package:url_launcher/link.dart';

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
      // appBar: AppBar(
      //   title: const Text(
      //     'Companies Name',
      //   ),
      //   actions: [
      //     Visibility(
      //       visible: _user == _admin ? true : false,
      //       child: ElevatedButton(
      //           onPressed: () {
      //             Navigator.of(context).push(MaterialPageRoute(
      //                 builder: (context) => const AddCompany()));
      //           },
      //           child: const Icon(Icons.add_business_outlined)),
      //     )
      //   ],
      // ),
      backgroundColor: Colors.grey[300],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 75),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  child: const Icon(Icons.arrow_back, size: 30.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25.0),
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddCompany(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add_business,
                        size: 30.0,
                        color: Colors.black,
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              'Our Choices For Solar Power',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          // List of the companies
          StreamBuilder(
            stream: _database.child('companies').onValue,
            builder: (context, AsyncSnapshot snap) {
              final tilesList = <Card>[];
              if (snap.hasData) {
                final companies =
                    Map<String, dynamic>.from(snap.data.snapshot.value);
                companies.forEach((key, value) {
                  final nextCompany =
                      Company.fromRTDB(Map<String, dynamic>.from(value));
                  final companyTile = Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.grey[300],
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(15, 6, 8, 6),
                      leading: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(5.0),
                        child: Image.network(nextCompany.logolink),
                      ),
                      subtitle: Align(
                        alignment: const Alignment(-1.2, 0),
                        child: RatingBar(
                          initialRating: nextCompany.rating.toDouble(),
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          ignoreGestures: true,
                          itemSize: 25.0,
                          ratingWidget: RatingWidget(
                            full: const Icon(
                              Icons.star,
                              color: Colors.green,
                            ),
                            empty: const Icon(
                              Icons.star,
                            ),
                            half: const Icon(Icons.heart_broken),
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Link(
                          uri: Uri.parse(nextCompany.link.toString()),
                          builder: (context, followLink) => ElevatedButton(
                            onPressed: followLink,
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      title: Align(
                        alignment: const Alignment(-1.1, 0),
                        child: Text(nextCompany.name),
                      ),
                      tileColor: Colors.grey[200],
                    ),
                  );
                  tilesList.add(companyTile);
                });
              } else {
                return const CircularProgressIndicator();
              }
              return Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(10.0),
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
