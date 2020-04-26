import 'dart:io';
import 'config.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import './UIList.dart';
import 'DatabaseHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (initSetup['RESET_DATA']) {
    File path = File(await DatabaseHelper.getPathToDatabase());
    path.delete();
  }

  UIList uiList = UIList();
  await uiList.setOriginalData();

  runApp(MaterialApp(
    title: 'Mind Twice',
    home: HomeScreen(uiList),
  ));
}
