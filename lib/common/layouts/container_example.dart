import 'package:flutter/material.dart';

class ContainerExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ContainerExampleState();
}

class ContainerExampleState extends State<ContainerExample> {
  @override
  Widget build(BuildContext context) {
    var imgExpanded = Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black38,
            border: Border.all(width: 2, color: Colors.black38),
            borderRadius: BorderRadius.all(Radius.circular(2.0))),
        child: Image.asset("assets/images/logo.png"),
      ),
    );

    var container = Container(
      decoration: BoxDecoration(color: Colors.black54),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[imgExpanded, imgExpanded, imgExpanded],
          ),
          Row(
            children: <Widget>[imgExpanded, imgExpanded, imgExpanded],
          ),
          Row(
            children: <Widget>[imgExpanded, imgExpanded, imgExpanded],
          ),
          Row(
            children: <Widget>[imgExpanded, imgExpanded, imgExpanded],
          ),
          Row(
            children: <Widget>[imgExpanded, imgExpanded, imgExpanded],
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Container Example"),
      ),
      body: container,
    );
  }
}
