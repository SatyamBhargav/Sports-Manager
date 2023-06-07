import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricketapp/Screens/tab_bar_creen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailForm extends StatefulWidget {
  const DetailForm({super.key});

  @override
  State<DetailForm> createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  TextEditingController _teamone = TextEditingController();
  TextEditingController _teamtwo = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _time = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final match = FirebaseFirestore.instance.collection('Match');

  void clear() {
    _teamone.clear();
    _teamtwo.clear();
    _date.clear();
    _time.clear();
    _location.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Match",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          // onTap: () {
          //   // Get.back()
          //   // Navigator.push(
          //   //   context,
          //   //   MaterialPageRoute(builder: (context) => TabBarScreen()),
          //   // );
          // },
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
        child: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 1), () {
              setState(() {
                clear();
              });
            });
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      // margin: EdgeInsets.only(top: 100),
                      child: Image(
                        image: AssetImage('assets/add.jpg'),
                        // height: 200,
                      ),

                      // image: AssetImage('assets/add.jpg'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some value';
                        }
                      },
                      controller: _teamone,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some value';
                        }
                      },
                      controller: _teamtwo,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select date';
                        }
                      },
                      controller: _date,
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
                              setState(() {
                                _date.text =
                                    DateFormat('dd/MM/yyyy').format(pickeddate);
                              });
                            }
                          },
                          icon: Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.blue[400],
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: 'DD/MM/YYYY',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select time';
                        }
                      },
                      controller: _time,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            TimeOfDay? pickedtime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(hour: 9, minute: 0),
                            );
                            if (pickedtime != null) {
                              setState(() {
                                _time.text = pickedtime.format(context);
                                // _date.text = DateFormat('dd/MM/yyyy').format(pickedtime);
                              });
                            }
                          },
                          icon: Icon(
                            Icons.watch_later_outlined,
                            color: Colors.blue[400],
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: 'HH:MM',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some value';
                        }
                      },
                      controller: _location,
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
                          FirebaseFirestore.instance
                              .collection('Match')
                              .doc()
                              .set({
                            'Team1': _teamone.text,
                            'Team2': _teamtwo.text,
                            'Date': _date.text,
                            'Time': _time.text,
                            'Location': _location.text
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Match Added Successfully'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                          clear();
                        }
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); // hide the keyboard
                      },
                      child: Text(
                        'Add Match',
                        style: TextStyle(fontSize: 16),
                      ),
                      // style: ElevatedButton.styleFrom(
                      //   backgroundColor: Color(0xff32cdfd),
                      // ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
