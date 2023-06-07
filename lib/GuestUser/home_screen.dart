import 'package:flutter/material.dart';
import 'CDataFetch.dart';

// ignore: must_be_immutable
class CHomeScreen extends StatelessWidget {
  Color bgColor;
  CHomeScreen({
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
          child: CDataFetch(),
        ),
      ),
      // Container(
      //   color: Colors.green,
      //   child: DataFetch(),
      // ),
    );
  }
}
