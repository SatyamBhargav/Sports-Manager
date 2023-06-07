import 'package:cricketapp/DataFetch.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  Color bgColor;
  HomeScreen({
    Key? key,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
        child: Container(
          child: DataFetch(),
        ),
      ),
      // Container(
      //   color: Colors.green,
      //   child: DataFetch(),
      // ),
    );
  }
}
