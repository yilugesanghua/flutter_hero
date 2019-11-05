import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class GuideProgressPainter extends CustomPainter {
  Paint mBgPaint, mProgressPaint, darkPaint;
  RRect mBgRRect;
  int currentIndex;
  int total;
  double offset;

  ///每一个的长度
  double itemLength;
  Path mPath, mDarkPath;
  RRect mProgressRect;

  GuideProgressPainter(
    this.currentIndex,
    this.offset,
    this.total,
  ) {
    mBgPaint = Paint();
    mBgPaint.isAntiAlias = true;
    mBgPaint.color = Colors.grey.withAlpha(163);
    mBgPaint.strokeCap = StrokeCap.round;

    mProgressPaint = Paint();
    mProgressPaint.isAntiAlias = true;
    mProgressPaint.color = Colors.red;
    mProgressPaint.strokeCap = StrokeCap.round;

    darkPaint = Paint();
    darkPaint.isAntiAlias = true;
    darkPaint.color = Colors.black.withAlpha(0);
    darkPaint.strokeCap = StrokeCap.round;

    mPath = Path();
    mDarkPath = Path();
  }

  @override
  void paint(Canvas canvas, Size size) {
    itemLength = size.width / total;
    mBgRRect = RRect.fromLTRBR(
        0, 0, size.width, size.height, Radius.circular(size.height / 2));
    mProgressRect = RRect.fromRectAndRadius(
        Rect.fromLTRB(
            (math.min(
                math.max(0, currentIndex - offset) * itemLength, size.width)),
            0,
            (math.min(math.max(0, currentIndex - offset + 1) * itemLength,
                size.width)),
            size.height),
        Radius.circular(size.height / 2));
    mPath.reset();
    mPath.addRRect(mProgressRect);
    mDarkPath.reset();

    print("mPath:   ${mPath.getBounds()}");
//    canvas.drawColor(Colors.red, BlendMode.color);
    canvas.drawRRect(mBgRRect, mBgPaint);
    canvas.drawPath(mPath, mProgressPaint);
    if (mProgressRect.width.ceil() < itemLength) {
      mDarkPath.addRRect(mProgressRect);
      darkPaint.color =
          Colors.black.withAlpha((offset.abs() / 2 * 255).toInt());
      canvas.drawPath(mDarkPath, darkPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
