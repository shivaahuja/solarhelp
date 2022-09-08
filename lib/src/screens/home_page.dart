import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
 Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Stromkostenrechner',
      home: MyCustomForm(),
    );
  }
}
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}
// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myInputArea = TextEditingController();
  final myInputCost = TextEditingController();

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
      appBar: AppBar(
        title: const Text('Retrieve Text Input'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 75,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                  hintText: 'm^2',
                  hintStyle: TextStyle(color: Colors.blue),
                  labelText: "Gib deine Solapanelfläche in m^2 ein"),
              controller: myInputArea,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                  hintText: 'Ct/KwH',
                  hintStyle: TextStyle(color: Colors.blue),
                  labelText: "Gib deine Kosten in Cent/kwH ein"),
              controller: myInputCost,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.

        onPressed: () {
          final double result1 =
              calcSolar(myInputArea.text, myInputCost.text)[0];
          final double resultCostYear =
              calcSolar(myInputArea.text, myInputCost.text)[1];
          final double resultPowerYear =
              calcSolar(myInputArea.text, myInputCost.text)[2];
          final double resultPowerDay =
              calcSolar(myInputArea.text, myInputCost.text)[3];

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  // Retrieve the text the that user has entered by using the
                  // TextEditingController.
                  // title: Text(result1.toString()),
                  content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                //position
                mainAxisSize: MainAxisSize.min,
                // wrap content in flutter
                children: <Widget>[
                  Text("Kostenersparnis von $result1€ im Jahr"),
                  Text(
                      "Durchschnitts Stromkosten im Jahr mit Solarpanel (bei 3500Kw) $resultCostYear€"),
                  Text(
                      "Durchschnittlich Generierter Strom am Tag $resultPowerDay KwH"),
                  Text(
                      "Durchschnittlich Generierter Strom im Jahr: $resultPowerYear KwH"),
                ],
              ));
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}

// 32,81 cent bei cent/kWh
// per squaremeter 1360 watts
calcSolar(myInputArea, myInputCost) {
  myInputArea = double.parse(myInputArea);
  myInputCost = double.parse(myInputCost);

  var resultPower = myInputArea * 1.360;
  var result = ((1642.5 * resultPower) / 1000) * myInputCost;
  var resultPowerYear = (1642.5 * resultPower);
  var resultPowerDay = (4.5 * resultPower);
  // 1642.5 durschnitts an Sonnenstunden im Jahr in Deutschland
  var resultCostYear =
      ((myInputCost * 34) - ((1642.5 * resultPower) / 1000) * myInputCost);

  return [result, resultCostYear, resultPowerYear, resultPowerDay];
}
