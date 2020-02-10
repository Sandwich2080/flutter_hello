import 'package:flutter/material.dart';

///  Flutter中常用布局的使用
class CommonLayouts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommonLayoutsState();
}

class CommonLayoutsState extends State<CommonLayouts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Common Layouts in Flutter"),
      ),
      body: Container(),
    );
  }
}
