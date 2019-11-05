import 'package:flutter/cupertino.dart';
import 'package:flutter_hero/guide/guide_progress_paint.dart';
import 'package:flutter_hero/guide/guide_progress_painter.dart';

class GuideProgress extends StatefulWidget {
  int currentIndex;
  int total;
  double offset;

  GuideProgress(
    this.currentIndex,
    this.offset,
    this.total,
  );

  @override
  State<StatefulWidget> createState() {
    return GuideProgressState();
  }
}

class GuideProgressState extends State<GuideProgress> {
  @override
  Widget build(BuildContext context) {
    return widget.total == 0
        ? Container()
        : GuideProgressPaint(
            painter: GuideProgressPainter(
              widget.currentIndex,
              widget.offset,
              widget.total,
            ),
          );
  }
}
