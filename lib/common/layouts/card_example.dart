import 'package:flutter/material.dart';

class CardExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CardExampleState();
}

class CardExampleState extends State<CardExample> {
  @override
  Widget build(BuildContext context) {
    var card = SizedBox(
      height: 210,
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: new Text('1625 Main Street',
                  style: new TextStyle(fontWeight: FontWeight.w500)),
              subtitle: new Text('My City, CA 99984'),
              leading: new Icon(
                Icons.restaurant_menu,
                color: Colors.blue[500],
              ),
            ),
            Divider(),
            ListTile(
              title: new Text('(408) 555-1212',
                  style: new TextStyle(fontWeight: FontWeight.w500)),
              leading: new Icon(
                Icons.contact_phone,
                color: Colors.blue[500],
              ),
            ),
            ListTile(
              title: new Text('costa@example.com'),
              leading: new Icon(
                Icons.contact_mail,
                color: Colors.blue[500],
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Card Example"),
      ),
      body: card,
    );
  }
}
