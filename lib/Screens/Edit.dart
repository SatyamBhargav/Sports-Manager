import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricketapp/Screens/tab_bar_creen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

class UpdateStudentPage extends StatefulWidget {
  final String id;
  UpdateStudentPage({Key? key, required this.id}) : super(key: key);

  @override
  _UpdateStudentPageState createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formKey = GlobalKey<FormState>();

  // Updaing Student
  CollectionReference students = FirebaseFirestore.instance.collection('Match');

  Future<void> updateUser(
      id, teamone, teamtwo, matchdate, matchtime, matchlocation) {
    return students.doc(id).update({
      'Team1': teamone,
      'Team2': teamtwo,
      'Date': matchdate,
      'Time': matchtime,
      'Location': matchlocation
    });
    // .then((value) => print("User Updated"))
    // .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Match",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          child: IconButton(
            icon: Icon(
              Icons.chevron_left_outlined,
              color: Colors.black,
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => TabBarScreen()),
              );
            },
          ),
        ),

        // actions: [Text('dataxcvc vvvbvbnv')],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus(); // hide the keyboard
        },
        child: SingleChildScrollView(
          // physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('Match')
                      .doc(widget.id)
                      .get(),
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      print('Something Went Wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var data = snapshot.data!.data();
                    var teamone = data!['Team1'];
                    var teamtwo = data['Team2'];
                    var matchdate = data['Date'];
                    var matchtime = data['Time'];
                    var matchlocation = data['Location'];
                    TextEditingController dateController =
                        TextEditingController(text: matchdate);
                    TextEditingController timeController =
                        TextEditingController(text: matchtime);
                    // String nevalue = _dateController as String;

                    return Column(
                      children: [
                        Container(
                          // margin: EdgeInsets.only(top: 100),
                          child: Image(
                            image: AssetImage('assets/Edit.jpg'),
                            height: 250,
                          ),

                          // image: AssetImage('assets/add.jpg'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          initialValue: teamone,
                          onChanged: (value) => teamone = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some value';
                            }
                          },
                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            labelText: 'Team One',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          initialValue: teamtwo,
                          onChanged: (value) => teamtwo = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some value';
                            }
                          },

                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            labelText: 'Team Two',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: dateController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select date';
                            }
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () async {
                                DateTime? pickeddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2023),
                                  lastDate: DateTime(2101),
                                );

                                if (pickeddate != null) {
                                  dateController.text = DateFormat('dd/MM/yyyy')
                                      .format(pickeddate);
                                  matchdate = dateController.text;
                                }
                              },
                              icon: Icon(
                                Icons.calendar_today_rounded,
                                color: Colors.blue[400],
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            labelText: 'DD/MM/YYYY',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: timeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select time';
                            }
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () async {
                                TimeOfDay? pickedtime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(hour: 12, minute: 0),
                                );
                                if (pickedtime != null) {
                                  timeController.text =
                                      pickedtime.format(context);
                                  matchtime = timeController.text;
                                }
                              },
                              icon: Icon(
                                Icons.watch_later_outlined,
                                color: Colors.blue[400],
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            labelText: 'HH:MM',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          initialValue: matchlocation,
                          onChanged: (value) => matchlocation = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some value';
                            }
                          },
                          // obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            labelText: 'Location',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              minimumSize: const Size.fromHeight(50),
                              shape: StadiumBorder() // NEW
                              ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              updateUser(widget.id, teamone, teamtwo, matchdate,
                                  matchtime, matchlocation);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Details Updated Successfully'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TabBarScreen()),
                            );
                            FocusManager.instance.primaryFocus
                                ?.unfocus(); // hide the keyboard
                          },
                          child: Text(
                            'Edit/Update',
                            style: TextStyle(fontSize: 16),
                          ),
                          // style: ElevatedButton.styleFrom(
                          //   backgroundColor: Color(0xff32cdfd),
                          // ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
