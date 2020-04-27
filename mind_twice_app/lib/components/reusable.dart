import 'package:flutter/material.dart';

getSmallTextContainer(text, bgColor) {
  if (text == '') {
    return SizedBox.shrink();
  }

  return (Container(
    child:
        Text(text, style: TextStyle(fontSize: 16, color: Colors.grey[850])),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  ));
}
