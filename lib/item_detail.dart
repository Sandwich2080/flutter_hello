import 'package:flutter/material.dart';
import 'package:flutter_hello/list_item.dart';

class ItemDetail extends StatelessWidget {
  final ListItem itemData;

  ItemDetail(this.itemData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemData.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(itemData.description),
      ),
    );
  }
}
