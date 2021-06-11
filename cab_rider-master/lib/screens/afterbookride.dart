import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Afterbookride extends StatefulWidget {
  const Afterbookride({Key key}) : super(key: key);

  @override
  _AfterbookrideState createState() => _AfterbookrideState();
}

class _AfterbookrideState extends State<Afterbookride> {
  TextEditingController _numberCtrl = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _numberCtrl.text = "8888404583";
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Rider App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    // new Container(
                    //     width: 60.0,
                    //     height: 60.0,
                    //     decoration: new BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         image: new DecorationImage(
                    //             fit: BoxFit.fill,
                    //             image: new NetworkImage(
                    //                 "https://png.pngtree.com/png-vector/20190321/ourmid/pngtree-vector-users-icon-png-image_856952.jpg")))),

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
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                content: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text("Raju Yadav",
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.blueGrey[700])),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text("Vehicle Model:",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.blue)),
                                    Text("xxx",
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
                                    Text(" MH 32 1234",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        )),
                                  ],
                                )));
                      },
                    ),
                    Text(
                      'Raju Yadav',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () async {
                          FlutterPhoneDirectCaller.callNumber(_numberCtrl.text);
                        },
                        icon: Icon(
                          Icons.call,
                          size: 30.0,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
