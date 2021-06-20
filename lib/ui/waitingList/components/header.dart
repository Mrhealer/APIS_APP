import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WaitingListHeader extends StatelessWidget {
  const WaitingListHeader(
      {Key key,
      @required this.title,
      @required this.press,
      @required this.count})
      : super(key: key);

  final String title;
  final GestureTapCallback press;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "OpenSans",
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            "Total : $count",
            style: TextStyle(
              fontSize: 18,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontFamily: "OpenSans",
            ),
          ),
        ),
      ],
    );
  }
}
