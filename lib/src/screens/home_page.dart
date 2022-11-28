// ignore_for_file: sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solarhelp/src/screens/signin_page.dart';
import 'package:showcaseview/showcaseview.dart';

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
  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();
  final keyFour = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
          builder: (context) => Scaffold(
                backgroundColor: Colors.grey[200],
                body: SingleChildScrollView(
                  child: Column(
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
                                border:
                                    Border.all(color: const Color(0xFF367D38)),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.green[500],
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
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFF367D38)),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.green[500],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => ShowCaseWidget.of(context)
                                        .startShowCase([
                                      keyOne,
                                      keyTwo,
                                      keyThree,
                                      keyFour
                                    ]),
                                  );
                                },
                                child: const Icon(
                                  Icons.info,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(35, 10, 20, 0),
                        child: Text(
                          'Calculate your savings',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 28,
                          ),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.green[200],
                                border:
                                    Border.all(color: const Color(0xFF367D38)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Showcase(
                                key: keyOne,
                                description: 'Enter your Roof area',
                                child: TextField(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: "Area in m2"),
                                  controller: myInputArea,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              'Enter your power cost',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.green[200],
                                border:
                                    Border.all(color: const Color(0xFF367D38)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Showcase(
                                key: keyTwo,
                                description: 'Enter your cent/kwH price',
                                child: TextField(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: "Cent/kwH"),
                                  controller: myInputCost,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              'Select no. of years',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                            const SizedBox(height: 20),
                            Showcase(
                              key: keyThree,
                              description: 'Select number of years',
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      duration(15),
                                      duration(20),
                                      duration(25),
                                      duration(30),
                                      duration(35),
                                      duration(40),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            GestureDetector(
                              onTap: () {
                                final double result1 = calcSolar(
                                    myInputArea.text,
                                    myInputCost.text,
                                    selected)[0];
                                final double resultTotalCost = calcSolar(
                                    myInputArea.text,
                                    myInputCost.text,
                                    selected)[1];
                                final double resultBreakEven = calcSolar(
                                    myInputArea.text,
                                    myInputCost.text,
                                    selected)[2];
                                final double resultNetProfit = calcSolar(
                                    myInputArea.text,
                                    myInputCost.text,
                                    selected)[3];

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
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 30, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  resultTotalCost,
                                                  "Total Cost of Solar Panels ",
                                                  '€'),
                                              result(
                                                  resultBreakEven,
                                                  "Break even point  ",
                                                  'years'),
                                              result(
                                                  resultNetProfit,
                                                  'Net profit after $selected years  ',
                                                  '€'),
                                              const SizedBox(height: 20),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  myInputArea.clear();
                                                  myInputCost.clear();
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20.0),
                                                  child: Container(
                                                    height: 60,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Colors.green[600],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        "Recalculate",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white),
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
                              child: Showcase(
                                key: keyFour,
                                description: 'Click to calculate',
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Calculate",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
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
              )),
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
        padding: const EdgeInsets.fromLTRB(6, 5, 6, 0),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            border: title == selected
                ? Border.all(color: const Color(0xFF367D38), width: 2)
                : null,
            color: Colors.green[500],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Text(title.toString())),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myInputArea.dispose();
    myInputCost.dispose();
    super.dispose();
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
  //var resultPowerYear = (resultPower);
  //var resultPowerDay = (resultPower / 365);
  // 1642.5 durschnitts an Sonnenstunden im Jahr in Deutschland
  //var resultCostYear = ((3500 * selected * (myInputCost / 100)) - result);

  var totalCost = 6000 + (myInputArea * 40);
  var breakEvenPoint = (totalCost / result) * selected;
  var netsaving = result - totalCost;

  return [result, totalCost, breakEvenPoint, netsaving];
}
