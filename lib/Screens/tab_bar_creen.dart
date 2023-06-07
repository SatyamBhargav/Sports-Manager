// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cricketapp/Screens/form.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../auth.dart';
import '../tabs/tab_map.dart';
import 'package:flutter/material.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  int _activePageIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pageDetails[_activePageIndex]['title'],
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        // backgroundColor: Colors.white,
        backgroundColor: pageDetails[_activePageIndex]['navigationBarColor'],
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailForm()),
            );
          },
          icon: Icon(Icons.my_library_add_rounded),
          color: Colors.black,
        ),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => DetailForm()),
          //     );
          //   },
          //   icon: Icon(Icons.my_library_add_rounded),
          //   color: Colors.black,
          // ),
          IconButton(
              onPressed: () {
                signOut();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Successfully Logged Out'),
                  duration: Duration(seconds: 1),
                ));
              },
              icon: Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: PageView(
          controller: _pageController,
          // scrollDirection: Axis.vertical, // to change scroll direction
          onPageChanged: (index) {
            setState(() {
              _activePageIndex = index;
            });
          },
          children: [
            pageDetails[0]['pageName'],
            pageDetails[1]['pageName'],
            // pageDetails[2]['pageName'],
            // pageDetails[3]['pageName'],
          ]),
      bottomNavigationBar: CurvedNavigationBar(
          color: pageDetails[_activePageIndex]['bottom_color'],
          backgroundColor: pageDetails[_activePageIndex]['navigationBarColor'],
          index: _activePageIndex,
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(microseconds: 400),
                curve: Curves.ease);
          },
          items: const [
            Icon(
              Icons.home,
              size: 30,
            ),
            Icon(
              Icons.domain_verification_rounded,
              size: 30,
            ),
            // Icon(Icons.share_rounded),
            // Icon(Icons.person),
          ]),
    );
  }
}
