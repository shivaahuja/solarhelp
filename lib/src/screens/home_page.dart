// ignore_for_file: sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solarhelp/src/screens/signin_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _HomePageState extends State<HomePage> {
  final auth = FirebaseAuth.instance;
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myInputArea = TextEditingController();
  final myInputCost = TextEditingController();
  late int selected = 1;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myInputArea.dispose();
    myInputCost.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    auth.signOut();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Signin()));
                  },
                  child: const Icon(
                    Icons.logout_rounded,
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
                'Calculate your savings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 40, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter the area of your Roof',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: "Area in m2"),
                      controller: myInputArea,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Enter your power cost in cent/kwH',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: "Cent/kwH"),
                      controller: myInputCost,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Select no. of years',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      duration(1),
                      duration(2),
                      duration(3),
                      duration(4),
                      duration(5),
                      duration(10),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      duration(15),
                      duration(20),
                      duration(25),
                      duration(30),
                      duration(35),
                      duration(40),
                    ],
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      final double result1 = calcSolar(
                          myInputArea.text, myInputCost.text, selected)[0];
                      final double resultCostYear = calcSolar(
                          myInputArea.text, myInputCost.text, selected)[1];
                      final double resultPowerYear = calcSolar(
                          myInputArea.text, myInputCost.text, selected)[2];
                      final double resultPowerDay = calcSolar(
                          myInputArea.text, myInputCost.text, selected)[3];

                      showModalBottomSheet(
                          isDismissible: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 400,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 30, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Results",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(height: 15),
                                    result(
                                      result1,
                                      'Savings in $selected years',
                                      '€',
                                    ),
                                    result(
                                        resultCostYear,
                                        "Average cost of electricity(3500Kwh)",
                                        '€'),
                                    result(
                                        resultPowerDay,
                                        "Average engery produced in a day ",
                                        'Kwh'),
                                    result(
                                        resultPowerYear,
                                        'Average engery produced in a year ',
                                        'Kwh'),
                                    const SizedBox(height: 20),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        myInputArea.clear();
                                        myInputCost.clear();
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: Container(
                                          height: 60,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[600],
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Recalculate",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: Text(
                          "Calculate",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget result(
    double result1,
    String title,
    String unit,
  ) {
    return ListTile(
      title: Text(title),
      trailing: Text('${result1.toStringAsFixed(2) + unit} '),
    );
  }

  Widget duration(int title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = title;
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            border: title == selected
                ? Border.all(color: Colors.black, width: 2)
                : null,
            color: Colors.grey[500],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Text(title.toString())),
        ),
      ),
    );
  }
}

// 32,81 cent bei cent/kWh
// per squaremeter 1360 watts
calcSolar(myInputArea, myInputCost, selected) {
  myInputArea = double.parse(myInputArea);
  myInputCost = double.parse(myInputCost);

  var resultPower = myInputArea * 25;
  // var result = ((1642.5 * resultPower) / 1000) * myInputCost * selected;
  var result = resultPower * (myInputCost / 100) * selected;
  var resultPowerYear = (resultPower);
  var resultPowerDay = (resultPower / 365);
  // 1642.5 durschnitts an Sonnenstunden im Jahr in Deutschland
  var resultCostYear = ((3500 * selected * (myInputCost / 100)) - result);

  return [result, resultCostYear, resultPowerYear, resultPowerDay];
}
