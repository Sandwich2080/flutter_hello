import 'package:flutter/material.dart';
import 'package:flutter_hello/common/io/file_write_read.dart';
import 'package:flutter_hello/common/io/read_external_files.dart';
import 'package:flutter_hello/common/io/shared_preference.dart';

class IOOperations extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IOOperationsState();
}

class IOOperationsState extends State<IOOperations> {
  void onItemTap(int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FileWriteRead()));

        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ReadExternalFiles()));
        break;
      case 2:
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SharedPreferenceExample()));
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> operations = [
      "File Write/Read",
      "Read external files",
      "Database",
      "Config files"
    ];

    var listItems = List<Widget>.generate(operations.length, (int index) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(operations[index]),
            onTap: () => onItemTap(index),
          ),
          Divider(
            color: Colors.grey,
          ),
        ],
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("IO Operations"),
      ),
      body: ListView(
        children: listItems,
      ),
    );
  }
}
