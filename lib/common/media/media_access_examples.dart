import 'package:flutter/material.dart';
import 'package:flutter_hello/common/media/image_save_example.dart';

class MediaAccessExamples extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MediaAccessExamplesState();
}

class _MediaAccessExamplesState extends State<MediaAccessExamples> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media Access Examples"),
      ),
      body: _buildBody(),
    );
  }

  List<String> options = ["Image"];

  _buildBody() {
    var children = List<Widget>.generate(options.length, (index) {
      return GestureDetector(
        onTap: () {
          _onItemClick(index);
        },
        child: Container(
          alignment: Alignment.center,
          height: 56,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(options[index]),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Divider(
                  height: 0.5,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      );
    });

    return ListView(
      scrollDirection: Axis.vertical,
      children: children,
    );
  }

  _onItemClick(index) {
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ImageSaveExample()));
        break;
      default:
        break;
    }
  }
}
