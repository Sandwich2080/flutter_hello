import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReadExternalFiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ReadExternalFilesState();
}

class ReadExternalFilesState extends State<ReadExternalFiles> {
  void onButtonPressed(int btnId) {
    switch (btnId) {
      case 0:
        openGallery();
        break;
      case 1:
        openCamera();
        break;
      default:
        break;
    }
  }

  openGallery() async {
    File path = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = path;
    });
  }

  openCamera() async {
    File path = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = path;
    });
  }

  File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Read External files."),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 50, top: 20, right: 50),
                child: Stack(
                  alignment: Alignment(0.0, 0.0),
                  children: <Widget>[
                    Align(
                      child: MaterialButton(
                        onPressed: () {
                          onButtonPressed(0);
                        },
                        child: Text("Pick a image"),
                        textColor: Colors.white,
                        color: Colors.blue,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        onPressed: () {
                          onButtonPressed(1);
                        },
                        child: Text("Take a photo"),
                        textColor: Colors.white,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              ),
              buildImageWidget(),
              /*GridView.extent(
                maxCrossAxisExtent: 150,
                padding: EdgeInsets.all(4.0),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                children: buildItems(),
              )*/
            ],
          ),
        ));
  }

  Widget buildImageWidget() {
    if (imageFile == null) {
      return Center(
        child: Text("Pick a image or take photo"),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Image.file(imageFile),
      );
    }
  }

/*List<Widget> buildItems() {
    return <Widget>[];
  }*/
}
