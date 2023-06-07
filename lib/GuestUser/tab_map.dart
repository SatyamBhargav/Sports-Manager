import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'insights_screen.dart';

final List<Map<String, dynamic>> pageDetails = [
  {
    'pageName': CHomeScreen(
      bgColor: Colors.blue.shade200,
    ),
    'title': 'Upcoming',
    // 'navigationBarColor': Colors.amber[700],
    'navigationBarColor': Colors.blue.shade200,

    'bottom_color': Colors.blue.shade600
  },
  {
    'pageName': CInsightsScreen(
      bgColor: Colors.green.shade200,
    ),
    'title': 'Completed',
    'navigationBarColor': Colors.green.shade200,
    'bottom_color': Colors.green.shade600
  },
  {
    'pageName': CHomeScreen(
      bgColor: Colors.blue.shade200,
    ),
    'title': 'Upcoming',
    // 'navigationBarColor': Colors.amber[700],
    'navigationBarColor': Colors.blue.shade200,

    'bottom_color': Colors.blue.shade600
  },
  {
    'pageName': CInsightsScreen(
      bgColor: Colors.green.shade200,
    ),
    'title': 'Completed',
    'navigationBarColor': Colors.green.shade200,
    'bottom_color': Colors.green.shade600
  },
];
