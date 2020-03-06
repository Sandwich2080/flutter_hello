import 'package:flutter/material.dart';
import 'package:flutter_hello/common/gestures/draggable_example.dart';
import 'package:flutter_hello/common/gestures/listener_example.dart';

class CommonGestures extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommonGesturesState();
}

class CommonGesturesState extends State<CommonGestures> {
  List<String> _gestureStrs = ["Draggable", "Listener"];

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List.generate(_gestureStrs.length, (index) {
      return MaterialButton(
        color: Colors.blue,
        onPressed: () {
          _onButtonPressed(index);
        },
        child: Text(
          _gestureStrs[index],
          style: TextStyle(color: Colors.white),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Common Gestures"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widgets,
        ),
      ),
    );
  }

  void _onButtonPressed(int index) {
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DraggableExample()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ListenerExample()));
        break;
      default:
        break;
    }
  }
}
