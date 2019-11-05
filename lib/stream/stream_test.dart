import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class StreamClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StreamClassState();
  }
}

class StreamClassState extends State<StreamClass> {
  StreamSubscription streamSubscription;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Stream'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('开始'),
          ),
          RaisedButton(
            child: Text('暂停'),
            onPressed: () => streamSubscription?.pause(),
          ),
          RaisedButton(
            child: Text('恢复'),
            onPressed: () => streamSubscription?.resume(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
        ),
        onPressed: (){
          start(streamSubscription);
        },
      ),
    );
  }


  void start( StreamSubscription streamSubscription) async {
    streamSubscription = Stream.fromFutures([
      futureFun(3),
      futureFun(6),
    ]).listen((onData) {
      print('=====onData===${onData.runtimeType}=====${onData}');
      streamSubscription.pause();
    }, onDone: () {
      print("=============onDone");
    });
  }

  Future futureFun(params) async {
//    return Stream.periodic(Duration(seconds: params), (value) {
//      return 'params -->$params   value --> $value';
//    });
    return await Future.delayed(Duration(seconds: params), () {
      print('结果走了没有~');
      return 'params -->$params   ';
    });
//    return Stream.periodic(Duration(seconds: 5), (value) {
//      return 'params -->$params   value --> $value';
//    });
  }
}
