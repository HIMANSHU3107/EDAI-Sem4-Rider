import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Driverlist extends StatefulWidget {
  const Driverlist({key}) : super(key: key);

  @override
  _DriverlistState createState() => _DriverlistState();
}

class _DriverlistState extends State<Driverlist> {
  final dbRef = FirebaseDatabase.instance.reference();
  String numbertext;
  List lists = [];
  List avai_driver_list = [];
  List uid_drivers = [];
  List uid_available_drivers = [];

  bool state = false;

  String distance = '000.00';

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
            Map<dynamic, dynamic> valuesAvaiDrivers =
                snapshot.data.value['driversAvailable'];

            values.removeWhere(
                (key, value) => values[key]['status'] == 'offline');

            //print('later half' + values.toString());

            values.forEach((key, values) {
              lists.add(values);
            });

            /* valuesAvaiDrivers.forEach((key, value) {
              avai_driver_list.add(valuesAvaiDrivers);
            }); */

            uid_available_drivers = valuesAvaiDrivers.keys.toList();

            //print(avai_driver_list);
            //print(avai_driver_list.toSet().elementAt(0).);
            //print(avai_driver_list.toString().substring(52, 62));
            print(valuesAvaiDrivers['1gFxyofcSdSWxqx6ZEa2o0W9y2r1']['l'][0]);

            return values.isEmpty
                ? Scaffold(
                    body: Center(
                    child: Text(
                      'Cab not found',
                      style: TextStyle(fontSize: 20),
                    ),
                  ))
                : new ListView.builder(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      icon: Image.network(
                                          "https://png.pngtree.com/png-vector/20190321/ourmid/pngtree-vector-users-icon-png-image_856952.jpg"),
                                      iconSize: 50,
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            builder: (_) => new AlertDialog(
                                                title: new Text(
                                                  "Driver Details",
                                                  style: TextStyle(
                                                    fontSize: 35.0,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                                content: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Text(
                                                        lists[index]
                                                            ["fullname"],
                                                        style: TextStyle(
                                                            fontSize: 30.0,
                                                            color:
                                                                Colors.blueGrey[
                                                                    700])),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text("Vehicle Model:",
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            color:
                                                                Colors.blue)),
                                                    Text(
                                                        lists[index][
                                                                "vehicle_details"]
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
                                                            color:
                                                                Colors.blue)),
                                                    Text(
                                                        lists[index][
                                                                "vehicle_details"]
                                                            ["vehicle_number"],
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                        )),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextButton(
                                                        onPressed: () async {
                                                          distance = calculateDistance(
                                                                  valuesAvaiDrivers[
                                                                          uid_available_drivers[
                                                                              index]]
                                                                      ['l'][0],
                                                                  valuesAvaiDrivers[
                                                                          uid_available_drivers[
                                                                              index]]
                                                                      ['l'][1])
                                                              .toString();
                                                        },
                                                        child: Text(
                                                            'Get Driver distance')),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                        "Distance from Driver:",
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            color:
                                                                Colors.blue)),
                                                    Text(
                                                        distance.substring(
                                                                0, 5) +
                                                            " Km",
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
                                        )),
                                    IconButton(
                                        /*onPressed: () async {
                                          FlutterPhoneDirectCaller.callNumber(
                                              lists[index]["phone"]);
                                        },*/
                                        onPressed: () {
                                          FlutterOpenWhatsapp.sendSingleMessage(
                                              "+91" + numbertext, "Hello");
                                        },
                                        icon: Icon(
                                          Icons.chat,
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

  Future<double> calculateDistance(lat1, lon1) async {
    Position currentPosition;

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    LatLng pos = LatLng(position.latitude, position.longitude);

    double lat2 = pos.latitude.toDouble();
    double lon2 = pos.longitude.toDouble();

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    print(12742 * asin(sqrt(a)));
    distance = (12742 * asin(sqrt(a))).toString();
    return 12742 * asin(sqrt(a));
  }
}
