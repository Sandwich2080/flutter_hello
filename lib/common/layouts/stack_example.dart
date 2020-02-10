import 'package:flutter/material.dart';

class StackExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StackExampleState();
}

class StackExampleState extends State<StackExample> {
  @override
  Widget build(BuildContext context) {
    var stack = Stack(
      alignment: Alignment(0.6, 0.6),
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/logo.png"),
          radius: 100,
        ),
        Container(
          decoration: BoxDecoration(color: Colors.black38),
          child: Text(
            "Mia B",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Stack Example"),
      ),
      body: Center(
        child: stack,
      ),
    );
  }
}
