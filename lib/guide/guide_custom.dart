import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hero/guide/guide_progress_widget.dart';
import 'dart:math' as math;

import 'guide_bean_entity.dart';
import 'guide_progress_listener.dart';

class GuidePage extends StatefulWidget {
  List<GuideBean> mData;
  int currentIndex;

  GuidePage(this.mData, {this.currentIndex = 0}) : assert(mData != null);

  @override
  State<StatefulWidget> createState() {
    return GuidePageState();
  }
}

class GuidePageState extends State<GuidePage> {
  var screenWidth;
  int total = 4;
  double offset = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.yellow,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GuideWidget(
                    screenWidth,
                    widget.mData,
                    (int currentIndex, double offset, int total) {
                      setState(() {
                        widget.currentIndex = currentIndex;
                        this.offset = offset;
                        this.total = total;
                      });
                    },
                    currentIndex: widget.currentIndex,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: SizedBox(
                width: 300,
                height: 10,
                child: GuideProgress(
                    widget.currentIndex ?? 0, offset ?? 0, total ?? 0),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GuideWidget extends StatefulWidget {
  var screenWidth;
  List<GuideBean> data;
  GuideProgressListener onProgress;
  int currentIndex;

  GuideWidget(this.screenWidth, this.data, this.onProgress,
      {this.currentIndex = 0})
      : assert(
          data != null,
        ),
        assert(onProgress != null);

  @override
  State<StatefulWidget> createState() {
    return GuideWidgetState();
  }
}

class GuideWidgetState extends State<GuideWidget>
    with TickerProviderStateMixin {
  final GlobalKey globalKey = GlobalKey();
  DragStartDetails startDrag;
  double offset, endOffset;
  double direction = 0;
  AnimationController finishScrollController;
  PageController controller;

  //控件宽度
  var width;

  @override
  void initState() {
    super.initState();
    finishScrollController = AnimationController(
        duration: Duration(milliseconds: 150), vsync: this)
      ..addListener(() {
        print('finishScrollController.value  ${finishScrollController.value}');
        offset = endOffset + (1 - endOffset) / (finishScrollController.value);
        if (direction < 0) {
          if (widget.currentIndex == 3) {
            offset = (1 - finishScrollController.value) * endOffset;
          } else {
            offset =
                endOffset - (1 + endOffset) * (finishScrollController.value);
          }
        } else {
          if (widget.currentIndex == 0) {
            offset = (1 - finishScrollController.value) * endOffset;
          } else {
            offset =
                endOffset + (1 - endOffset) * (finishScrollController.value);
          }
        }
        widget.onProgress(widget.currentIndex, offset, widget.data.length);
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        print('AnimationStatus status -->$status');
        if (status == AnimationStatus.completed) {
          offset = 0;
          widget.currentIndex =
              direction < 0 ? widget.currentIndex + 1 : widget.currentIndex - 1;
          widget.currentIndex = math.max(math.min(3, widget.currentIndex), 0);
          widget.onProgress(widget.currentIndex, offset, widget.data.length);
          setState(() {});
        }
      });
  }

  List<Widget> _buildItem() {
    int index = widget.data.length;
    return widget.data.map((GuideBean guideBean) {
      index--;
      return Opacity(
        opacity: (widget.currentIndex - 1 == index ||
                widget.currentIndex + 1 == index)
            ? (offset ?? 0).abs()
            : widget.currentIndex == index ? (1.0 - (offset ?? 0).abs()) : 1,
        child: Transform.rotate(
          angle: (widget.currentIndex - 1 == index ||
                  widget.currentIndex + 1 == index)
              ? 0
              : widget.currentIndex == index
                  ? ((offset ?? 0) * math.pi / 4)
                  : 0,
          alignment: Alignment.bottomCenter,
          origin: Offset(0.5, 0.5),
          child: FractionalTranslation(
            translation:
                Offset((offset ?? 0) + index - widget.currentIndex, 0.0),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.asset(
                    guideBean.path,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: globalKey,
      onHorizontalDragStart: (DragStartDetails startDetail) {
        startDrag = startDetail;
        print('DragStartDetails:  ${startDetail.globalPosition}');
        widget.onProgress(widget.currentIndex, offset, widget.data.length);
      },
      onHorizontalDragUpdate: (DragUpdateDetails updateDetails) {
        width = globalKey.currentContext.size.width;
        double dragDistance =
            updateDetails.globalPosition.dx - startDrag.globalPosition.dx;
        direction = dragDistance;
        setState(() {
          offset = dragDistance / width;
          print('---------offset------------->$offset    width  -----> $width');
        });
        widget.onProgress(widget.currentIndex, offset, widget.data.length);
        print(
            'DragUpdateDetails   globalPosition   : ${updateDetails.globalPosition}');
        print('DragUpdateDetails delta  : ${updateDetails.delta}');
      },
      onHorizontalDragEnd: (DragEndDetails endDetails) {
        print('DragUpdateDetails :  ');
        endOffset = offset;
        finishScrollController.forward(from: 0);
      },
      onHorizontalDragCancel: () {},
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: _buildItem(),
      ),
    );
  }
}
