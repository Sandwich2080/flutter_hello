import 'package:flutter/material.dart';

class GridViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GridViewExampleState();
}

class GridViewExampleState extends State<GridViewExample> {
  List<Widget> buildItems() {
    return List<Container>.generate(20, (int index) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.amberAccent,
            border: Border.all(width: 0.1, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(0.1))),
        child: Image.asset("assets/images/logo.png"),
      );
    });
  }

  Widget buildGridView() {
    return GridView.extent(
      maxCrossAxisExtent: 150,
      padding: EdgeInsets.all(4.0),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: buildItems(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gridview Example"),
      ),
      body: buildGridView(),
    );
  }
}
