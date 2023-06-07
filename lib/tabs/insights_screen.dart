import 'package:cricketapp/completed.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InsightsScreen extends StatelessWidget {
  Color bgColor;
  InsightsScreen({
    Key? key,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
        child: Container(
          child: Upcoming(),
        ),
      ),
    );
  }
}
