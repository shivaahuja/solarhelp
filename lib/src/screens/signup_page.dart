// ignore_for_file: use_build_context_synchronously, unnecessary_new, prefer_typing_uninitialized_variables

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solarhelp/src/screens/signin_page.dart';
import 'package:solarhelp/src/screens/verifyscreen.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _securePwd = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _repeatPwdController = TextEditingController();
  late String _email, _password, _name;
  late String _repeatPassword;
  var _emailError;
  var _passwordError;
  var _repeatPasswordError;
  final auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50.0),
          const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              'Sign up',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
          ),
          const SizedBox(height: 20.0),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Center(
                child: Image(
              image: AssetImage('lib/src/images/logo.jpg'),
            )),
          ),
          const SizedBox(height: 10.0),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Name',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      errorText: _emailError,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) => !EmailValidator.validate(email!)
                        ? _emailError = 'Enter a valid email'
                        : _emailError = null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    controller: _pwdController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      errorText: _passwordError,
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
                    validator: (password) => _pwdController.text.length < 8
                        ? _passwordError = 'Password must contain 8 characters'
                        : _passwordError = null,
                    obscureText: _securePwd,
                    onChanged: (value) {
                      setState(() {
                        _password = value.trim();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: _repeatPwdController,
                    decoration: InputDecoration(
                      hintText: 'Repeat Password',
                      errorText: _repeatPasswordError,
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
                    validator: (repeatPassword) =>
                        _pwdController.text != _repeatPwdController.text
                            ? _repeatPasswordError = 'Password do not match'
                            : _repeatPasswordError = null,
                    obscureText: _securePwd,
                    onChanged: (value) {
                      setState(() {
                        _repeatPassword = value.trim();
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () => _signup(_email, _password),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(88, 55),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                        ),
                        child: const Text(
                          'Sign Up',
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
                        builder: (context) => const Signin()));
                  },
                  child: const Text('Sign in')),
              TextButton(
                  onPressed: () {}, child: const Text('Forgot Password?'))
            ],
          )
        ],
      ),
    ));
  }

  _signup(String email, String password) async {
    final form = _formKey.currentState!;
    try {
      if (form.validate()) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        try {
          final user = FirebaseAuth.instance.currentUser;
          await user!.sendEmailVerification();
        } catch (e) {
          Fluttertoast.showToast(
              msg: e.toString(), gravity: ToastGravity.CENTER);
        }

        await userCredential.user!.updateDisplayName(_name);
        await userCredential.user!.sendEmailVerification();

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const VerifyScreen()));
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message ?? 'Unknown Error', gravity: ToastGravity.CENTER);
    }
  }
}
