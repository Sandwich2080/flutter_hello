import 'package:flutter/material.dart';

class DraggableExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DraggableExampleState();
}

class DraggableExampleState extends State<DraggableExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Draggable Example"),
      ),
      body: Draggable(
          onDragCompleted: () {
            print("onDragCompleted");
          },
          onDragEnd: (d) {
            print("onDragEnd: $d");
          },
          onDraggableCanceled: (velocity, offset) {
            print("onDraggableCanceled: $velocity, $offset");
          },
          onDragStarted: () {
            print("onDragStarted");
          },
          child: Image.asset("assets/images/logo.png"),
          feedback: Text("Feedback")),
    );
  }
}
