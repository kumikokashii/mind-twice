import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import './UIList.dart';

void main() async {
  UIList uiList = UIList();
  await uiList.setOriginalData();

  runApp(MaterialApp(
    title: 'Mind Twice',
    home: HomeScreen(uiList),
  ));
}
