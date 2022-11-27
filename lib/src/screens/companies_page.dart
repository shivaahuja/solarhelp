// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:solarhelp/src/models/company.dart';
import 'package:solarhelp/src/screens/add_company.dart';
import 'package:solarhelp/src/screens/navigation.dart';
import 'package:url_launcher/link.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({Key? key}) : super(key: key);

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  final _database = FirebaseDatabase.instance.ref();
  final _user = FirebaseAuth.instance.currentUser!.uid;
  final String _admin = 'WVewNHbl3rZZeXi7QyL2rJ3eCgC3';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF367D38)),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green[500],
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Navigation(currentIndex: 1)));
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _admin == _user,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF367D38)),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.green[500],
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AddCompany()));
                      },
                      child: const Icon(
                        Icons.add_business,
                        size: 30.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
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
                fontSize: 24,
                fontWeight: FontWeight.w900,
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
                    color: Colors.green[300],
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(
                          color: Colors.green.shade700,
                        ),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(15, 6, 8, 6),
                      leading: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: const Color(0xFF367D38)),
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
                return const SizedBox(
                    height: 500,
                    width: 1000,
                    child: Center(child: CircularProgressIndicator()));
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
