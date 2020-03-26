import 'package:flutter/material.dart';
import 'package:flutter_hello/common/layouts/card_example.dart';
import 'package:flutter_hello/common/layouts/common_layout_constants.dart';
import 'package:flutter_hello/common/layouts/container_example.dart';
import 'package:flutter_hello/common/layouts/dialogs_example.dart';
import 'package:flutter_hello/common/layouts/gridview_example.dart';
import 'package:flutter_hello/common/layouts/listview_example.dart';
import 'package:flutter_hello/common/layouts/stack_example.dart';
import 'package:flutter_hello/common/layouts/vertical_autoswitch_pager.dart';
import 'package:flutter_hello/common/layouts/visibility_detector_example.dart';

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
      case CommonLayoutConstants.LAYOUT_STACK:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StackExample()));
        break;
      case CommonLayoutConstants.LAYOUT_CARD:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CardExample()));
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
              ),
              MaterialButton(
                onPressed: () {
                  onButtonClicked(CommonLayoutConstants.LAYOUT_STACK);
                },
                child: Text("Stack"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              MaterialButton(
                onPressed: () {
                  onButtonClicked(CommonLayoutConstants.LAYOUT_CARD);
                },
                child: Text("Card"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              MaterialButton(
                onPressed: () {
                  _gotoDialogExamples();
                },
                child: Text("Dialogs"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              MaterialButton(
                onPressed: () {
                  _gotoVisibilityDetector();
                },
                child: Text("Visibility Detector"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              MaterialButton(
                onPressed: () {
                  _gotoVerticalPager();
                },
                child: Text("Vertical Pager"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ],
          ),
        ));
  }

  void _gotoVerticalPager() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => VerticalAutoSwitchPagerExample()));
  }

  void _gotoVisibilityDetector() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => VisibilityDetectorExample()));
  }

  void _gotoDialogExamples() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DialogsExample()));
  }
}
