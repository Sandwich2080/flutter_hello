import 'package:flutter/material.dart';

class ListViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListViewExampleState();
}

class ListViewExampleState extends State<ListViewExample> {
  @override
  Widget build(BuildContext context) {
    var list = <Widget>[
      ListTile(
        title: Text(
          "Title 1",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        subtitle: Text("Subtitle 1"),
        leading: Icon(
          Icons.theaters,
          color: Colors.blue[500],
        ),
      ),
      ListTile(
        title: Text(
          "Title 2",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        subtitle: Text("Subtitle 2"),
        leading: Icon(
          Icons.theaters,
          color: Colors.blue[500],
        ),
      ),
      ListTile(
        title: Text(
          "Title 3",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        subtitle: Text("Subtitle 3"),
        leading: Icon(
          Icons.theaters,
          color: Colors.blue[500],
        ),
      ),
      ListTile(
        title: Text(
          "Title 4",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        subtitle: Text("Subtitle 4"),
        leading: Icon(
          Icons.theaters,
          color: Colors.blue[500],
        ),
      ),
      ListTile(
        title: Text(
          "Title 5",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        subtitle: Text("Subtitle 5"),
        leading: Icon(
          Icons.theaters,
          color: Colors.blue[500],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("ListView Example"),
      ),
      body: Center(
        child: ListView(
          children: list,
        ),
      ),
    );
  }
}
