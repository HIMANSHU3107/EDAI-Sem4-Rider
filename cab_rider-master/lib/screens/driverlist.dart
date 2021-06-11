import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Driverlist extends StatefulWidget {
  const Driverlist({key}) : super(key: key);

  @override
  _DriverlistState createState() => _DriverlistState();
}

class _DriverlistState extends State<Driverlist> {
  final dbRef = FirebaseDatabase.instance.reference().child("drivers");
  List lists = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dbRef.once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.hasData) {
            lists.clear();
            Map<dynamic, dynamic> values = snapshot.data.value;
            values.forEach((key, values) {
              lists.add(values);
            });
            return new ListView.builder(
                shrinkWrap: true,
                itemCount: lists.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Email: " + lists[index]["email"]),
                        Text("Name: " + lists[index]["fullname"]),
                        Text("Phone: " + lists[index]["phone"]),
                      ],
                    ),
                  );
                });
          }
          return CircularProgressIndicator();
        });
  }
}
