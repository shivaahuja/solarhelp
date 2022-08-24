import 'package:flutter/material.dart';

class LearnFlutter extends StatefulWidget {
  const LearnFlutter({Key? key}) : super(key: key);

  @override
  State<LearnFlutter> createState() => _LearnFlutterState();
}

class _LearnFlutterState extends State<LearnFlutter> {
  bool isSwitch = false;
  bool? isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Learn Flutter'),
      //   automaticallyImplyLeading: false,
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //     icon: const Icon(Icons.arrow_back),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         debugPrint('Info button clicked');
      //       },
      //       icon: const Icon(Icons.info_outline),
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('lib/src/images/ironman.jpg'),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.black,
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              color: Colors.amberAccent,
              width: double.infinity,
              child: const Center(
                child: Text(
                  'This is a Text Widget',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: isSwitch ? Colors.red : Colors.amber),
              onPressed: () {
                debugPrint('pressed');
              },
              child: const Text('Button'),
            ),
            OutlinedButton(
              onPressed: () {
                debugPrint('pressed');
              },
              child: const Text('Button'),
            ),
            TextButton(
              onPressed: () {
                debugPrint('pressed');
              },
              child: const Text('Button'),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                debugPrint('Row touched');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(
                    Icons.money,
                    color: Colors.blue,
                  ),
                  Text('Row Widget'),
                  Icon(
                    Icons.attach_money,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            Switch(
              value: isSwitch,
              onChanged: ((bool newBool) {
                setState(() {
                  isSwitch = newBool;
                });
              }),
            ),
            Checkbox(
              value: isCheck,
              onChanged: (bool? newBool) {
                setState(() {
                  isCheck = newBool;
                });
              },
            ),
            Image.network(
                'https://cdn-ssl.s7.disneystore.com/is/image/DisneyShopping/6101047624065-3?fmt=jpeg&qlt=90&wid=652&hei=652')
          ],
        ),
      ),
    );
  }
}
