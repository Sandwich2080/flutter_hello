import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class VerticalAutoSwitchPagerExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VerticalAutoSwitchPagerExampleState();
}

class _VerticalAutoSwitchPagerExampleState
    extends State<VerticalAutoSwitchPagerExample> {
  bool _vertical = true;

  @override
  Widget build(BuildContext context) {
    List<String> pages = ['page 1', 'page 2', 'page 3'];

    var pageWidgets = List<Widget>.generate(pages.length, (index) {
      return Container(
        child: Center(
          child: Text(pages[index]),
        ),
      );
    });

    var pager = DefaultTabController(
        length: pages.length, child: TabBarView(children: pageWidgets));

    var verticalBanner = Swiper(
      onTap: (index) { print("tap index: $index"); },
      duration: 3000,
      autoplay: true,
      itemCount: pages.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Container(
          child: Center(
            child: Text(pages[index]),
          ),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Vertical Auto Swicth Pager Example"),
      ),
      body: _vertical ? verticalBanner : pager,
    );
  }
}
