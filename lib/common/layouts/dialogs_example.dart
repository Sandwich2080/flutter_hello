import 'package:flutter/material.dart';

class DialogsExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DialogsExample();
}

class _DialogsExample extends State<DialogsExample> {
  @override
  Widget build(BuildContext context) {
    List<String> dialogs = ["Single Item Dialog", "Confirm Dialog"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Dialog Examples"),
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: dialogs.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _onItemClick(index);
              },
              child: Container(
                alignment: Alignment.center,
                height: 56,
                child: Stack(
                  children: <Widget>[
                    Align(
                      child: Text(
                        dialogs[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                      alignment: Alignment.center,
                    ),
                    Align(
                      child: Divider(
                        color: Colors.grey,
                      ),
                      alignment: Alignment.bottomCenter,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  _onItemClick(index) {
    switch (index) {
      case 0:
        _showSingleItemDialog();
        break;
      case 1:
        _showConfirmDialog();
        break;
      default:
        break;
    }
  }

  _showSingleItemDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              Center(
                child: Text(
                  "保存图片",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              )
            ],
          );
        });
  }

  _showConfirmDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("确定要退出吗？"),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("确定"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("取消"),
              )
            ],
          );
        });
  }
}
