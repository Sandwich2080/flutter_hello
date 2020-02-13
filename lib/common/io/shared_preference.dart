import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SharedPreferenceExampleState();
}

class SharedPreferenceExampleState extends State<SharedPreferenceExample> {
  @override
  void initState() {
    super.initState();
    read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SharedPreference Example"),
      ),
      body: buildBody(),
    );
  }

  String username;

  Widget buildBody() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: TextEditingController.fromValue(TextEditingValue(
                text: displayedInputName(),
                selection: TextSelection.fromPosition(TextPosition(
                    affinity: TextAffinity.downstream,
                    offset: readUsername == null ? 0 : readUsername.length)),
                composing: TextRange.empty)),
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              labelText: "Input username",
              helperText: "Your registered username.",
            ),
            onChanged: (String content) {
              username = content;
            },
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  save();
                },
                child: Text("Save"),
              ),
              SizedBox(
                width: 15,
              ),
              Text(savedUsername == null
                  ? ""
                  : "username '$savedUsername' saved.")
            ],
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  read();
                },
                child: Text("Read"),
              ),
              SizedBox(
                width: 15,
              ),
              Text(readUsername == null
                  ? ""
                  : "username loaded: '$readUsername'")
            ],
          )
        ],
      ),
    );
  }

  String displayedInputName() {
    if (readUsername != null) {
      return readUsername;
    }
    if (savedUsername != null) {
      return savedUsername;
    }
    return "";
  }

  String savedUsername;

  String readUsername;

  void save() async {
    if(username!=null){
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString("username", username);
    }

    print("username saved:$username");

    setState(() {
      savedUsername = username;
    });
  }

  void read() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String username = sp.getString("username");
    print("username loaded:$username");
    setState(() {
      readUsername = username;
    });
  }
}
