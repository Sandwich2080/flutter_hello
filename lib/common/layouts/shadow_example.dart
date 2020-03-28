import 'package:flutter/material.dart';

class ShadowExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShadowExampleState();
}

class _ShadowExampleState extends State<ShadowExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shadow Example"),
      ),

      body: Container(
        alignment: Alignment.center,
        
        height: 600,
        child: Material(

          elevation: 5,
          shadowColor:  Color(0x24000000).withOpacity(.08),
          color: Colors.white,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 56,
          ),
        ),
      ),


    );
  }
}
