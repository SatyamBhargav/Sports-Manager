import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CDataFetch extends StatefulWidget {
  @override
  State<CDataFetch> createState() => _CDataFetchState();
}

// enum SingingCharacter { lafayette, jefferson }

class _CDataFetchState extends State<CDataFetch> {
  //to access the different database
  final Query<Map<String, dynamic>> _matchdata =
      FirebaseFirestore.instance.collection('Match');

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
