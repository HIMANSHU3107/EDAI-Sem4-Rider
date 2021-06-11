import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Driverlist extends StatefulWidget {
  const Driverlist({key}) : super(key: key);

  @override
  _DriverlistState createState() => _DriverlistState();
}

class _DriverlistState extends State<Driverlist> {
  final dbRef = FirebaseDatabase.instance.reference();
  String numbertext;
  List lists = [];
  List uid_drivers = [];
  List uid_available_drivers = [];
  TextEditingController _numberCtrl = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _numberCtrl.text = numbertext;
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dbRef.once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.hasData) {
            lists.clear();
            Map<dynamic, dynamic> values = snapshot.data.value['drivers'];
            Map<dynamic, dynamic> values_avai_drivers =
                snapshot.data.value['driversAvailable'];
            values.forEach((key, values) {
              lists.add(values);
            });
            uid_drivers = values.keys.toList();
            uid_available_drivers = values_avai_drivers.keys.toList();
            print(values[uid_available_drivers[0]]["fullname"]);
            print(uid_available_drivers);

            return new ListView.builder(
                shrinkWrap: true,
                itemCount: lists.length,
                itemBuilder: (BuildContext context, int index) {
                  numbertext = lists[index]["phone"];
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Text("Email: " + lists[index]["email"]),
                        // Text("Name: " + lists[index]["fullname"]),
                        // Text("Phone: " + lists[index]["phone"]),

                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: Image.network(
                                      "https://png.pngtree.com/png-vector/20190321/ourmid/pngtree-vector-users-icon-png-image_856952.jpg"),
                                  iconSize: 50,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => new AlertDialog(
                                            title: new Text(
                                              "Driver Details",
                                              style: TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            content: Column(
                                              children: [
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Text(lists[index]["fullname"],
                                                    style: TextStyle(
                                                        fontSize: 30.0,
                                                        color: Colors
                                                            .blueGrey[700])),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text("Vehicle Model:",
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.blue)),
                                                Text(
                                                    lists[index]
                                                            ["vehicle_details"]
                                                        ["car_model"],
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                    )),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text("Vehicle Number:",
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.blue)),
                                                Text(
                                                    lists[index]
                                                            ["vehicle_details"]
                                                        ["vehicle_number"],
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                    )),
                                              ],
                                            )));
                                  },
                                ),
                                Text(
                                  lists[index]["fullname"],
                                  style: TextStyle(fontSize: 20),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      FlutterPhoneDirectCaller.callNumber(
                                          lists[index]["phone"]);
                                    },
                                    icon: Icon(
                                      Icons.call,
                                      size: 30.0,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }
          return CircularProgressIndicator();
        });
  }
}
