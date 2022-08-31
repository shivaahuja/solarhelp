// ignore_for_file: unnecessary_new, use_build_context_synchronously

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solarhelp/src/screens/navigation.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Please verify your email',
        ),
        backgroundColor: Colors.white70,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'An email has been sent to your ${user.email}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                height: 1.2,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 15.0),
            child: Text(
              'If you want the email to be sent again click the button',
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              user.sendEmailVerification();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(88, 55),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
            ),
            child: const Text('Sent again'),
          )
        ],
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();

    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Navigation(currentIndex: 0)));
    }
  }
}
