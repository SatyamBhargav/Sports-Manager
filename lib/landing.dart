import 'package:cricketapp/pages/login_register_page.dart';
import 'package:cricketapp/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'auth.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  Future<void> guest() async {
    await Auth().guest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/loading.jpg'),
          fit: BoxFit.cover,
        )),
        height: double.infinity,
        width: double.infinity,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Text(
              'Its hard \n to beat',
              style: GoogleFonts.getFont('Lobster',
                  fontSize: 50, color: Colors.white),
            ),
          ),
          Text(
            'a person who \nnever give up.',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 450),
            child: ElevatedButton(
                onPressed: () {
                  guest();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WidgetTree()),
                  );
                },
                child: Text(
                  'Welcome',
                  style: TextStyle(fontSize: 30),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  elevation: 0.0,
                  backgroundColor: Colors.red.withOpacity(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      side: BorderSide(color: Colors.white)),
                )),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WidgetTree()),
                );
              },
              child: Text(
                'Login',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ))
        ]),
      ),
    );
  }
}
