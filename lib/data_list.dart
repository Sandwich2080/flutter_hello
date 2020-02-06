import 'package:flutter/material.dart';
import 'package:flutter_hello/item_detail.dart';
import 'package:flutter_hello/list_item.dart';

class DataList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ListItem> dataList =
        List.generate(20, (i) => ListItem('标题 $i', '内容 $i'));

    return Scaffold(
      appBar: AppBar(
        title: Text("data list"),
      ),
      body: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(dataList[index].title),
              subtitle: Text(dataList[index].description),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ItemDetail(dataList[index])));
              },
            );
          }),
    );
  }
}
