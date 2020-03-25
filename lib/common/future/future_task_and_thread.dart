import 'dart:async';

import 'package:flutter/material.dart';

class FutureTaskAndThread extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FutureTaskAndThreadState();
}

class _FutureTaskAndThreadState extends State<FutureTaskAndThread> {
  List<String> _titleList = ["Future", "Timer"];

  @override
  Widget build(BuildContext context) {
    var buttons = List<Widget>.generate(_titleList.length, (index) {
      return Container(
        margin: EdgeInsets.all(10.0),
        child: MaterialButton(
          color: Colors.blue,
          onPressed: () {
            _onButtonPressed(index);
          },
          child: Text(
            _titleList[index],
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Future Task And Thread Example"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: buttons,
      ),
    );
  }

  void _onButtonPressed(int index) {
    switch (index) {
      case 0:
        print("Future.delayed...");
        Future.delayed(Duration(seconds: 2),(){
          _task();
        });


        break;
      case 1:
        var _timer = Timer(Duration(seconds: 2), (){
          _task();
        });
        print("Timer task created.");
        _timer.cancel();
        print("Timer task canceled.");

        break;
      default:
        break;
    }
  }

  void _task() async {
    print("_task excuted.");
  }
}
