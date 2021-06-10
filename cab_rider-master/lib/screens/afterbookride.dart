import 'package:flutter/material.dart';

class Afterbookride extends StatefulWidget {
  const Afterbookride({Key key}) : super(key: key);

  @override
  _AfterbookrideState createState() => _AfterbookrideState();
}

class _AfterbookrideState extends State<Afterbookride> {
  @override
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
                    new Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                    "https://png.pngtree.com/png-vector/20190321/ourmid/pngtree-vector-users-icon-png-image_856952.jpg")))),
                    Text(
                      'Driver Name',
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(
                      Icons.call,
                      size: 30.0,
                    ),
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
