import 'package:cricketapp/GuestUser/tab_bar_creen.dart';
import 'package:cricketapp/Screens/tab_bar_creen.dart';
import 'package:cricketapp/pages/login_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshort) {
          User? user = snapshort.data;

          if (snapshort.hasData) {
            if (user!.isAnonymous) {
              return CTabBarScreen();
            } else {
              return TabBarScreen();
            }
            // return HomePage();
          }
          return LoginPage();
        });
  }
}
