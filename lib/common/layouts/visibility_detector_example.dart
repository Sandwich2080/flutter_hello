import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VisibilityDetectorExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VisibilityDetectorExampleState();
}

class _VisibilityDetectorExampleState extends State<VisibilityDetectorExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visibility Detector Example"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    var pages = ["page 1", "page 2", "page 3"];

    var widgetPages = List<Widget>.generate(pages.length, (index) {


      return VisibilityDetector(key: Key("${pages[index]}"), child: Center(
        child: Text(
          pages[index],
          style: TextStyle(fontSize: 24),
        ),
      ), onVisibilityChanged: (visibilityInfo){
          print("${pages[index]}: visible->${visibilityInfo.visibleFraction.compareTo(1.0)==0}");
      });
    });

    return DefaultTabController(
        length: pages.length, child: TabBarView(children: widgetPages));
  }
}
