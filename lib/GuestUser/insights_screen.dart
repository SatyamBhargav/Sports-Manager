import 'package:flutter/material.dart';

import 'completed.dart';

// ignore: must_be_immutable
class CInsightsScreen extends StatelessWidget {
  Color bgColor;
  CInsightsScreen({
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
          child: CUpcoming(),
        ),
      ),
    );
  }
}
