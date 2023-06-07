import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth.dart';
import 'forgotpass.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('Login Page');
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: title,
        ),
      ),
    );
  }

  Widget _errorMessage() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(errorMessage == '' ? '' : 'Humm ? $errorMessage'),
    );
  }

  Widget _submitButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            // backgroundColor: Colors.black,
            minimumSize: const Size.fromHeight(50),
            shape: StadiumBorder()),
        onPressed: isLogin
            ? signInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Text(
          isLogin ? 'Login' : 'Register',
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? 'Register' : 'Login'));
  }

  Widget _image() {
    return CircleAvatar(
      backgroundColor: Colors.orange[400],
      backgroundImage: AssetImage('assets/avatar.png'),
      radius: 120,
    );
  }

  Widget _forgotpass() {
    return TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ForgotPassword()),
          );
        },
        child: Text('Forgot Password?'));
  }

  Widget _guest() {
    return TextButton(
        onPressed: () {
          Auth().guest();
        },
        child: Text('Guest User'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus(); // hide the keyboard
        },
        child: SingleChildScrollView(
          child: Container(
            // height: double.infinity,
            // width: double.infinity,
            margin: EdgeInsets.only(top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _image(),
                _entryField('Email', _controllerEmail),
                _entryField('Password', _controllerPassword),
                _errorMessage(),
                _submitButton(),
                _forgotpass(),
                // _loginOrRegisterButton(),
                // _guest()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
