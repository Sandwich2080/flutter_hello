import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hello/common/utils/toast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageSaveExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImageSaveExampleState();
}

class _ImageSaveExampleState extends State<ImageSaveExample> {
  var _imageUrl =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1585829049863&di=0fe537a3a3aa640cbeac2ec0a753e8c9&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fbaike%2Fs%253D220%2Fsign%3De03c0bc3f3deb48fff69a6dcc01e3aef%2Fc83d70cf3bc79f3de51a7592baa1cd11738b299c.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image save example"),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width - 10,
          height: 500,
          child: Image.network(
            _imageUrl,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        MaterialButton(
          onPressed: _saveNetworkImage,
          child: Text(
            "保存到相册",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue,
        )
      ],
    );
  }

  _saveNetworkImage() async {
    var response = await Dio()
        .get(_imageUrl, options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    if (result != null) {
      ToastUtil.show("已成功保存到相册");
    }
  }
}
