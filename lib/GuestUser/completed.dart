import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CUpcoming extends StatefulWidget {
  @override
  State<CUpcoming> createState() => _CUpcomingState();
}

class _CUpcomingState extends State<CUpcoming> {
  //to access the different database
  final Query<Map<String, dynamic>> _matchdata =
      FirebaseFirestore.instance.collection('Complete');

  deletedata(id) async {
    await FirebaseFirestore.instance.collection('Complete').doc(id).delete();
  }

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

                      subtitle: Text(
                        documentSnapshot['Location'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                              title: 'Match Details',
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.start,
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
                      // trailing:
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
