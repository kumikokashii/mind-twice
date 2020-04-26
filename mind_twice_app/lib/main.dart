import 'config.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import './UIList.dart';
import 'DatabaseHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (initSetup['RESET_DATA'] || initSetup['LOAD_TEST_DATA']) {
    await DatabaseHelper.instance.resetDBfile();
  }

  UIList uiList = UIList();
  if (initSetup['LOAD_TEST_DATA']) {
    await uiList.loadTestData(initSetup['TEST_DATA']);
  }
  await uiList.setOriginalData();

  runApp(MaterialApp(
    title: 'Mind Twice',
    home: HomeScreen(uiList),
  ));
}
