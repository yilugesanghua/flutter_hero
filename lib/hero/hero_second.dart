import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 400,
              height: 400,
              alignment: Alignment.center,
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
                  return HeroSecond();
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
