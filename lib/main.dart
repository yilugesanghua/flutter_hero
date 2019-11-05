import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_hero/hero/hero_first.dart';

import 'calendar/calendar.dart';
import 'calendar/sliver_calendar_app_bar.dart';

double statusBarHeight = MediaQueryData.fromWindow(window).padding.top;

void main() => runApp(MyApp());

class CalendarViewApp extends StatelessWidget {
  void handleNewDate(date) {
    print("handleNewDate ${date}");
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: CusSliverPersistentHeaderDelegate(),
            ),
//            SliverSafeArea(
//              sliver: SliverToBoxAdapter(
//                child: new Calendar(
//                  onSelectedRangeChange: (range) =>
//                      print("Range is ${range.item1}, ${range.item2}"),
//                  isExpandable: true,
//                ),
//              ),
//            ),

//            SliverAppBar( snap: false,expandedHeight: 250,floating: true,),
//
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index.isEven) {
                  return Container(
                    height: 100,
                    color: Colors.yellow,
                  );
                } else {
                  return Divider(
                    height: 10,
                    color: Colors.transparent,
                  );
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}

class CusSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
//    child: new Calendar(
//      onSelectedRangeChange: (range) =>
//          print("Range is ${range.item1}, ${range.item2}"),
//      isExpandable: true,
//    ),
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 12,bottom: 12),
          child: Icon(
            Icons.access_time,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => math.max(minExtent, minExtent);

  @override
  // TODO: implement minExtent
  double get minExtent => kToolbarHeight + statusBarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return HeroFirst();
  }
}
