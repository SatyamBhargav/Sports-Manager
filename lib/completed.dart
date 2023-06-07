import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Upcoming extends StatefulWidget {
  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  //to access the different database
  final Query<Map<String, dynamic>> _matchdata =
      FirebaseFirestore.instance.collection('Complete');

  deletedata(id) async {
    await FirebaseFirestore.instance.collection('Complete').doc(id).delete();
  }
  // bool _validate = false,

  String? team1;
  String? team2;
  String? teamname;
  CollectionReference students =
      FirebaseFirestore.instance.collection('Complete');

  updateUser(id, team1, team2, teamname) {
    return students.doc(id).update({
      'Score1': team1,
      'Score2': team2,
      'Won': teamname,
    });
  }

  final _formKey = GlobalKey<FormState>();

//main code
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffda7b93),
      backgroundColor: Color(0xffa5d6a7),
      body: StreamBuilder(
        stream: _matchdata.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data?.size == 0) {
            // collection has no data
            return Center(
              child: Image(
                image: AssetImage('assets/complete.png'),
                // height: 250,
              ),
            );
          }

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

                      leading: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(children: [
                          Text(documentSnapshot['Date'],
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(documentSnapshot['Time'],
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ]),
                      ),

                      // Text(documentSnapshot['Date'],
                      //     style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        documentSnapshot['Location'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      // trailing:
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                                title: 'Update Match Details',
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
                                          hintText: 'Team Won / Note',
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
                                        if (_formKey.currentState!.validate()) {
                                          updateUser(documentSnapshot.id, team1,
                                              team2, teamname);
                                        }
                                      },
                                      child: Text('Match Complete')),
                                ]);
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
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Score'),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(documentSnapshot['Team1'] +
                                        ' : ' +
                                        documentSnapshot['Score1']),
                                    Text(documentSnapshot['Team2'] +
                                        ' : ' +
                                        documentSnapshot['Score2']),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Team Won / Note:'),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(documentSnapshot['Won']),
                                  ],
                                ));
                          },
                          icon: Icon(Icons.info_outline),
                          color: Colors.amber[800],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
