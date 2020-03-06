import 'package:flutter/material.dart';
import 'package:flutter_hello/common/gestures/my_horizontal_drag_gesture_recognizer.dart';

class ListenerExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListenerExampleState();
}

class ListenerExampleState extends State<ListenerExample> {
  GestureRecognizerFactoryWithHandlers<MyHorizontalDragGestureRecognizer>
      _gestureRecognizer() {
    var myHorizontalDragGestureRecognizer = MyHorizontalDragGestureRecognizer(
        debugOwner: this,
        onVelocityChanged: (isFling, velocityX, velocityY) {
          print(
              "isFling-> $isFling, velocityX->$velocityX, velocityY->$velocityY");
        });

    return GestureRecognizerFactoryWithHandlers(() {
      return myHorizontalDragGestureRecognizer;
    }, _initializer);
  }

  void _initializer(MyHorizontalDragGestureRecognizer instance) {
    instance
      ..onStart = _onStart
      ..onUpdate = _onUpdate
      ..onEnd = _onEnd;
  }

  ///接受触摸事件
  void _onStart(DragStartDetails details) {
    print('触摸屏幕${details.globalPosition}');
  }

  double offsetDistance = 0.0;

  ///垂直移动
  void _onUpdate(DragUpdateDetails details) {
    print('垂直移动${details.delta}');
    offsetDistance = offsetDistance + details.delta.dy;
    //setState(() {});
  }

  ///手指离开屏幕
  void _onEnd(DragEndDetails details) {
    print('离开屏幕');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listener Example"),
      ),
      body: RawGestureDetector(
        gestures: {MyHorizontalDragGestureRecognizer: _gestureRecognizer()},
        child: GestureDetector(
          onHorizontalDragDown: (details) {
            print("onHorizontalDragDown: ${details.localPosition}");
          },
          child: Listener(
            onPointerDown: (p) {
              print("onPointerDown: pos->${p.position}");
            },
            onPointerCancel: (p) {
              print("onPointerCancel:pos->${p.position}");
            },
            onPointerMove: (p) {
              print("onPointerMove: delta->${p.delta}");
            },
            onPointerSignal: (p) {
              print("onPointerSignal: ${p.position}");
            },
            onPointerUp: (p) {
              print("onPointerUp: ${p.position}");
            },
            child: SizedBox(
              width: 300,
              height: 300,
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
