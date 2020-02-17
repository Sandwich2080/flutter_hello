import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommonNetwork extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommonNetworkState();
}

class CommonNetworkState extends State<CommonNetwork> {
  @override
  Widget build(BuildContext context) {
    var marinSizedBox = SizedBox(
      width: 3,
    );
    var horizontalButtons = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MaterialButton(
          onPressed: () {
            onButtonClicked(0);
          },
          child: Text("HttpClient"),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        marinSizedBox,
        MaterialButton(
          onPressed: () {
            onButtonClicked(1);
          },
          child: Text("http"),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        marinSizedBox,
        MaterialButton(
          onPressed: () {
            onButtonClicked(2);
          },
          child: Text("dio"),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        marinSizedBox,
        MaterialButton(
          onPressed: () {
            onButtonClicked(3);
          },
          child: Text("Socket"),
          color: Colors.blue,
          textColor: Colors.white,
        )
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Network"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            horizontalButtons,
            SizedBox(
              height: 760,
              width: 400,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(responseDesc == null
                        ? "No response yet"
                        : responseDesc),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String responseDesc;

  void onButtonClicked(int btnId) {
    switch (btnId) {
      case 0:

        /// Using HttpClient
        getIpAddress();
        break;
      case 1:

        /// Using http
        onClickHttp();
        break;
      case 2:

        /// Using dio
        onClickDio();
        break;
      case 3:
        onClickSocket();

        /// Using Socket
        break;
      default:
        break;
    }
  }

  void updateRequestState(String desc) {
    setState(() {
      responseDesc = desc;
    });
  }

  void onClickSocket() async {
    var host = "api.github.com";
    var port = 443;
    /*var socket = await Socket.connect(host, port);
    socket.write("GET / HTTP1.1\r\nhost:$host");
    socket.close();*/
    var desc1 = "Connect via Socket: $host:$port";
    print(desc1);
    updateRequestState(desc1);

    Socket.connect(host, port, timeout: Duration(seconds: 30)).then(
        (Socket socket) {
      var desc2 =
          "Socket connected successfully.\n\n local address:${socket.address}\n\n local port:${socket.port}\n\n encoding:${socket.encoding.name}";
      print(desc2);
      updateRequestState("$desc1\n\n$desc2");
      socket.flush();
      socket.close();
    }, onError: (Object error) {
      socketConnectError(error);
    });
  }

  void socketConnectError(Object error) {
    var desc = "Socket connect error:$error";
    print(desc);
    updateRequestState(desc);
  }

  void onClickDio() async {
    String url = "https://api.github.com";
    var desc1 = "Request via dio...\n Dio().get('$url')\n";
    print(desc1);
    updateRequestState(desc1);

    var dio = Dio();
    var response = await dio.get(url);
    var desc2 = "Response statusCode:${response.statusCode}";

    print(desc2);
    updateRequestState("$desc1\n\n $desc2");

    var desc3 = "Response body:${response.data}";

    print(desc3);
    updateRequestState("$desc1\n $desc2\n\n $desc3");
  }

  void onClickHttp() async {
    //String url = "https://app.modaily.cn/app_if/getConfig?appID=1";
    //1. directly using the http api
    String url = "https://api.github.com";
    var desc1 = "Request via http directly...\n http.get('$url')";
    print(desc1);
    updateRequestState(desc1);
    var response = await http.get(url);

    var desc2 = "Response statusCode:${response.statusCode}";
    print(desc2);
    updateRequestState("$desc1\n\n $desc2");
    var desc3 = "Response body:${response.body}";
    print(desc3);
    updateRequestState("$desc1\n\n $desc2\n\n $desc3");

    //2. Create a client for multiple request usage. Don't forget to close the client when all task finished.
    var desc4 = "Request via http.Client() ...\n http.Client().get('$url')";
    print(desc4);
    updateRequestState("$desc1\n\n$desc2\n\n$desc3\n\n$desc4\n\n");
    var client = http.Client();
    var response2 = await client.get(url);
    var desc5 = "Response statusCode: ${response2.statusCode}";
    print(desc5);
    updateRequestState("$desc1\n\n$desc2\n\n$desc3\n\n$desc4\n\n$desc5\n\n");
    var desc6 = "Response body:${response2.body}";
    print(desc6);
    updateRequestState(
        "$desc1\n\n$desc2\n\n$desc3\n\n$desc4\n\n$desc5\n\n$desc6\n\n");
    client.close();
  }

  void getIpAddress() async {
    //var url = 'https://httpbin.org/ip';
    var url = 'https://api.github.com';
    var httpClient = HttpClient();
    var desc1 = "Request via HttpClient...\nHttpClient().getUrl: $url";
    print(desc1);
    updateRequestState(desc1);
    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      var desc2 = "Response statusCode:${response.statusCode}";
      print(desc2);
      updateRequestState("$desc1\n\n$desc2");
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        var desc3 = "Response body:$json";
        print(desc3);
        updateRequestState("$desc1\n\n $desc2\n\n $desc3");
        var data = jsonDecode(json);
        result = data['origin'];
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting IP address';
    }
    print("result: $result");
  }
}
