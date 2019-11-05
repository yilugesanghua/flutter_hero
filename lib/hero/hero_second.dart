import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hero/guide/guide_bean_entity.dart';
import 'package:flutter_hero/guide/guide_custom.dart';
import 'package:flutter_hero/zefyr/ZefyrPage.dart';

class HeroSecond extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HeroSecondState();
  }
}

class HeroSecondState extends State<HeroSecond> {
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
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 400,
              height: 400,
              alignment: Alignment.centerRight,
              child: Hero(
                transitionOnUserGestures: true,
                tag: "image",
                child: Image.network(
                    "https://img-blog.csdnimg.cn/20190323161535761.png"),
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (buildContext) {
                      return ZefyrPage();
//                  return GuidePage(
//                    [
//                      GuideBean(path: "images/back_100n.jpg", id: 0),
//                      GuideBean(path: "images/back_100d.jpg", id: 1),
//                      GuideBean(path: "images/back_101n.jpg", id: 2),
//                      GuideBean(path: "images/back_101d.jpg", id: 3)
//                    ],
//                    currentIndex: 1,
//                  );
                }));
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
