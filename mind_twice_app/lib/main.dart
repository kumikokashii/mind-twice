import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import './UIList.dart';


void main() {
  //Fetch data
  UIList uiList = UIList.defaultConstructor();

  runApp(MaterialApp(
    title: 'Mind Twice',
    home: HomeScreen(uiList),
  ));
}
