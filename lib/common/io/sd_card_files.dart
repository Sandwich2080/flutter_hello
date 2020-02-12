import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SDCardFiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SDCardFilesState();
}

class SDCardFilesState extends State<SDCardFiles> {
  String sdDir;

  List<FileSystemEntity> files;

  @override
  void initState() {
    super.initState();

    getExternalStorageDirectory().then((d) {
      setState(() {
        sdDir = d.path;
        files = d.listSync();
        
        for(int i=0;i<files.length;i++){
          print("File: ${files[i].path}");
        }
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SD Card"),
      ),
      body: ListView.builder(
        itemCount: files == null ? 0 : files.length,
        itemBuilder: (BuildContext context, int index) =>
            buildListItem(files[index]),
      ),
    );
  }

  Widget buildListItem(FileSystemEntity file) {
    var isFile = FileSystemEntity.isFileSync(file.path);

    var fileStat = file.statSync();
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(isFile
              ? "assets/images/img_file.png"
              : "assets/images/img_folder.png"),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "${file.path.substring(file.path.length)}",
                style: TextStyle(color: Colors.black),
              ),
              Text("${fileStat.modified}"),
            ],
          ),
        ],
      ),
    );
  }
}
