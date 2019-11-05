import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverCalendarAppBar extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return SliverCalendarAppBarState();
  }

}
class SliverCalendarAppBarState extends State<SliverCalendarAppBar>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MediaQuery.removePadding(
        context: context,
        removeBottom: true,
    child:AppBar());
  }

}