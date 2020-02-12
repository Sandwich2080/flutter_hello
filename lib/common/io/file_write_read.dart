import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hello/common/io/sd_card_files.dart';
import 'package:path_provider/path_provider.dart';

class FileWriteRead extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FileWriteReadState();
}

class FileWriteReadState extends State<FileWriteRead> {
  int counter = 0;

  Future<Null> onButtonPressed() async {
    setState(() {
      counter++;
    });

    (await getLocalFile()).writeAsString("$counter");
  }

  Future<File> getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;

    return File("$dir/config.txt");
  }

  Future<int> readCounter() async {
    try {
      File localFile = await getLocalFile();
      String contents = await localFile.readAsString();

      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    readCounter().then((int value) {
      setState(() {
        counter = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File write & read"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("You click $counter times on the button"),
            MaterialButton(
              onPressed: onButtonPressed,
              child: Text("Press the button"),
              color: Colors.blue,
              minWidth: 360,
              textColor: Colors.white,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SDCardFiles()));
              },
              child: Text("Read SD Card"),
              color: Colors.blue,
              minWidth: 360,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
