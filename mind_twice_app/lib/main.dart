import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './HomeScreen.dart';
import './UIList.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  UIList uiList = UIList();
  await uiList.setOriginalData();

  runApp(MaterialApp(
    title: 'Mind Twice',
    home: HomeScreen(prefs, uiList),
  ));
}
