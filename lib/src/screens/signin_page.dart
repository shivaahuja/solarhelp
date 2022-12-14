// ignore_for_file: unnecessary_new, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solarhelp/src/screens/home_page.dart';
import 'package:solarhelp/src/screens/navigation.dart';
import 'package:solarhelp/src/screens/signup_page.dart';
import 'package:solarhelp/src/screens/verifyscreen.dart';
import '../auth.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String? errorMessage = '';
  bool isSignedin = true;
  bool _securePwd = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String _email, _password;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Color(0xFF2D8565),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Image(
                  image: AssetImage('lib/src/images/logo.png'),
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _emailController,
                      autofillHints: const [AutofillHints.email],
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          _email = value.trim();
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: _passwordController,
                      autofillHints: const [AutofillHints.email],
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            icon: Icon(_securePwd
                                ? Icons.remove_red_eye_outlined
                                : Icons.security),
                            onPressed: () {
                              setState(() {
                                _securePwd = !_securePwd;
                              });
                            }),
                      ),
                      obscureText: _securePwd,
                      onChanged: (value) {
                        setState(() {
                          _password = value.trim();
                        });
                      },
                      validator: (value) {
                        if (value == null) {}
                        return 'Required';
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => _signin(_email, _password),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(88, 55),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                          ),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Signup()));
                  },
                  child: const Text('Create Account'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Password?'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  _signin(String _email, String _password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      if (userCredential.user!.emailVerified) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Navigation(
              currentIndex: 0,
            ),
          ),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const VerifyScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message ?? 'Unknown error', gravity: ToastGravity.TOP);
      errorMessage = e.message;
    }
  }
}
