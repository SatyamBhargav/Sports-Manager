import 'package:cricketapp/Screens/Edit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'Screens/tab_bar_creen.dart';

class DataFetch extends StatefulWidget {
  @override
  State<DataFetch> createState() => _DataFetchState();
}

// enum SingingCharacter { lafayette, jefferson }

class _DataFetchState extends State<DataFetch> {
  //to access the different database
  final Query<Map<String, dynamic>> _matchdata =
      FirebaseFirestore.instance.collection('Match');

  deletedata(id) async {
    await FirebaseFirestore.instance.collection('Match')
      ..doc(id).delete();
  }

  String? team1;
  String? team2;
  String? teamname;
  final _formKey = GlobalKey<FormState>();

  // SingingCharacter? _character = SingingCharacter.lafayette;
//main code
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffda7b93),
      backgroundColor: Color(0xff90caf9),
      body: StreamBuilder(
        stream: _matchdata.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            // return Center(text);
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data?.size == 0) {
            // collection has no data
            return Center(
              child: Image(
                image: AssetImage('assets/update.png'),
                height: 320,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];

                return Card(
                  // color: Color(0xffdfb8ff),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                            documentSnapshot['Team1'] +
                                '  vs  ' +
                                documentSnapshot['Team2'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        trailing: Text(documentSnapshot['Time'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),

                        leading: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(children: [
                            Text(documentSnapshot['Date'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15)),
                          ]),
                        ),

                        // Text(documentSnapshot['Date'],
                        //     style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          documentSnapshot['Location'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateStudentPage(
                                        id: documentSnapshot.id)),
                              );
                            },
                            icon: Icon(Icons.edit),
                            color: Colors.green,
                          ),
                          IconButton(
                            onPressed: () {
                              deletedata(documentSnapshot.id);
                              setState(() {});
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          ),
                          IconButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Match Details',
                                  content: Form(
                                    key: _formKey,
                                    child: Column(children: [
                                      TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter data';
                                          }
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Score Of Team 1',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        onChanged: (value) {
                                          setState(() {
                                            team1 = value;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter data';
                                          }
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Score Of Team 2',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        onChanged: (value) {
                                          setState(() {
                                            team2 = value;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter data';
                                          }
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Team Won',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        onChanged: (value) {
                                          setState(() {
                                            teamname = value;
                                          });
                                        },
                                      ),
                                    ]),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            FirebaseFirestore.instance
                                                .collection('Complete')
                                                .doc()
                                                .set({
                                              'Team1':
                                                  documentSnapshot['Team1'],
                                              'Team2':
                                                  documentSnapshot['Team2'],
                                              'Date': documentSnapshot['Date'],
                                              'Time': documentSnapshot['Time'],
                                              'Location':
                                                  documentSnapshot['Location'],
                                              'Score1': team1,
                                              'Score2': team2,
                                              'Won': teamname
                                            });
                                            deletedata(documentSnapshot.id);
                                            setState(() {});
                                            Navigator.pop(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TabBarScreen()),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Match Complete & Score Updated'),
                                                duration: Duration(seconds: 3),
                                              ),
                                            );
                                          }
                                        },
                                        child: Text('Match Complete')),
                                  ]);
                            },
                            icon: Icon(Icons.lightbulb_sharp),
                            color: Colors.amber[800],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
