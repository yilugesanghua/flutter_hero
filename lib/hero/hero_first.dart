import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'hero_second.dart';

class HeroFirst extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HeroFirstState();
  }
}

class HeroFirstState extends State<HeroFirst> {
  static const opacityCurve = const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('HeroDemo'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              alignment: Alignment.center,
              child: Hero(
                createRectTween: (Rect begin, Rect end) {
                  return MaterialRectCenterArcTween(begin: begin, end: end);
                },
                transitionOnUserGestures: true,
                flightShuttleBuilder: (flightContext, animation, direction,
                    fromContext, toContext) {
                  if (direction == HeroFlightDirection.push) {
                    return Container(
                      width: 100,
                      height: 100,
                      child: Image.network(
                          "https://img-blog.csdnimg.cn/20190323161457466.png"),
                    );
                  } else {
                    return Container(
                      width: 100,
                      height: 100,
                      child: Image.network(
                          "https://img-blog.csdnimg.cn/20190323161418695.png"),
                    );
                  }
                },
                tag: "image",
                child: Image.network(
                    "https://img-blog.csdnimg.cn/20190323161159133.png"),
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder<void>(
                    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                      return AnimatedBuilder(
                          animation: animation,
                          builder: (BuildContext context, Widget child) {
                            return Opacity(
                              opacity: opacityCurve.transform(animation.value),
                              child: HeroSecond(),
                            );
                          }
                      );
                    },
                  ),
                );

              },
              child: Icon(Icons.done),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
