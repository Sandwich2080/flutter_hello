import 'package:flutter/material.dart';
import 'package:flutter_hello/common/io/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class DbOperations extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DbOperationsState();
}

class DbOperationsState extends State<DbOperations> {
  @override
  void initState() {
    super.initState();

    initDb();
  }

  @override
  void deactivate() {
    super.deactivate();

    if (db != null) {
      db.close();
    }
  }

  Database db;

  static const String create_tb_records_click =
      "create table if not exists records_click (id integer primary key autoincrement,click_time Text)";

  initDb() {
    getDatabasesPath().then((String value) {
      DbHelper(value + "/flutter_hello.db").getDb().then((Database d) {
        d.execute(create_tb_records_click);
        print("create table success");
        db = d;
      });
    }, onError: (Object error) {
      onDbInitError(error);
    });
  }

  onDbInitError(Object error) {
    print("Db open failed.$error");
  }

  void onButtonClicked() {
    setState(() {
      clickedTime = DateTime.now().toIso8601String();

      var values = {"click_time": clickedTime};

      db.insert("records_click", values);
    });
  }

  void loadDbData() {
    if (db != null && db.isOpen) {
      db.query("records_click").then((List<Map<String, Object>> dataList) {
        setState(() {
          int size = dataList.length;
          for (int i = 0; i < size; i++) {
            print(dataList[i]);
          }
          loadedDataList = dataList;
        });
      });
    }
  }

  String clickedTime;

  List<Map<String, Object>> loadedDataList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Database operations"),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("Click"),
                  onPressed: onButtonClicked,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(clickedTime == null ? "" : "clicked time: $clickedTime"),
              ],
            ),
            RaisedButton(
              onPressed: loadDbData,
              child: Text("Load db data"),
            ),
            Expanded(
              child: buildListView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListView() {
    if (loadedDataList == null || loadedDataList.isEmpty) {
      return Center(
        child: Text("No records yet."),
      );
    }

    List<Widget> widgets = <Widget>[];

    widgets.add(SizedBox(
      height: 30,
      child: Center(
        child: Text("Records in database."),
      ),
    ));

    for (int i = 0; i < loadedDataList.length; i++) {
      Widget w = SizedBox(
        height: 66,
        child: Card(
          margin: EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Text(
                  "id: ${loadedDataList[i]["id"]}  Click time: ${loadedDataList[i]["click_time"]}"),
              Divider(
                color: Colors.grey,
              ),
            ],
          ),
        ),
      );
      widgets.add(w);
    }

    return Container(
      child: Column(
        children: widgets,
      ),
    );

    /*return ListView.builder(
        shrinkWrap: true,
        itemCount: loadedDataList.length,
        itemExtent: 1.0,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                    "id: ${loadedDataList[index]["id"]}  Click time: ${loadedDataList[index]["click_time"]}")
              ],
            ),
          );
        });*/
  }
}
