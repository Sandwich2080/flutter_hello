import 'package:flutter/material.dart';
import 'package:flutter_hello/common/layouts/common_layout_constants.dart';
import 'package:flutter_hello/common/layouts/container_example.dart';
import 'package:flutter_hello/common/layouts/gridview_example.dart';
import 'package:flutter_hello/common/layouts/listview_example.dart';

///  Flutter中常用布局的使用
class CommonLayouts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommonLayoutsState();
}

class CommonLayoutsState extends State<CommonLayouts> {
  void onButtonClicked(int btnId) {
    switch (btnId) {
      case CommonLayoutConstants.LAYOUT_CONTAINER:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ContainerExample()));
        break;
      case CommonLayoutConstants.LAYOUT_GRIDVIEW:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => GridViewExample()));
        break;

      case CommonLayoutConstants.LAYOUT_LISTVIEW:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ListViewExample()));

        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Common Layouts in Flutter"),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 10, top: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  onButtonClicked(CommonLayoutConstants.LAYOUT_CONTAINER);
                },
                child: Text("Container"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              MaterialButton(
                onPressed: () {
                  onButtonClicked(CommonLayoutConstants.LAYOUT_GRIDVIEW);
                },
                child: Text("GridView"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              MaterialButton(
                onPressed: () {
                  onButtonClicked(CommonLayoutConstants.LAYOUT_LISTVIEW);
                },
                child: Text("ListView"),
                color: Colors.blue,
                textColor: Colors.white,
              )
            ],
          ),
        ));
  }
}
