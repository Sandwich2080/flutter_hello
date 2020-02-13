import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hello/common/utils/toast.dart';
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

    // Fetch external directories on SD Card.
    getExternalStorageDirectories(type: StorageDirectory.dcim).then((List<Directory> dirs){
      for(int i=0;i<dirs.length;i++){
        print("dcim:${dirs[i].path}");
      }
    });
    getExternalStorageDirectories(type: StorageDirectory.movies).then((List<Directory> dirs){
      for(int i=0;i<dirs.length;i++){
        print("dcim:${dirs[i].path}");
      }
    });
    getExternalStorageDirectories(type: StorageDirectory.documents).then((List<Directory> dirs){
      for(int i=0;i<dirs.length;i++){
        print("dcim:${dirs[i].path}");
      }
    });
    getExternalStorageDirectories(type: StorageDirectory.downloads).then((List<Directory> dirs){
      for(int i=0;i<dirs.length;i++){
        print("dcim:${dirs[i].path}");
      }
    });

    getExternalStorageDirectory().then((d) {
      setState(() {
        sdDir = d.path;
        files = d.listSync();

        for (int i = 0; i < files.length; i++) {
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

    // Using 'GestureDetector' to wrap 'Card' to implement the feature of 'onItemClick'.
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(isFile
                ? "assets/images/img_file.png"
                : "assets/images/img_folder.png"),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${file.path.substring(file.parent.path.length + 1)}",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("${fileStat.modified}"),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        onItemClick(file);
      },
    );

    /*return Card(
      margin: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(isFile
              ? "assets/images/img_file.png"
              : "assets/images/img_folder.png"),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${file.path.substring(file.parent.path.length + 1)}",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${fileStat.modified}"),
            ],
          ),
        ],
      ),
    );*/
  }

  void onItemClick(FileSystemEntity file) {
    print("${file.path} is clicked");
    ToastUtil.show(
        "${file.path} is a ${FileSystemEntity.isFileSync(file.path) ? "file" : "directory"}");
  }
}
