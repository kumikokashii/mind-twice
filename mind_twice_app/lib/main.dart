import 'config.dart';
import 'package:flutter/material.dart';
import './components/HomeScreen.dart';
import './components/UIList.dart';
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
    debugShowCheckedModeBanner: initSetup['KEEP_DEBUG_BAR'],
    title: 'Mind Twice',
    home: HomeScreen(uiList),
    theme: ThemeData(
      primaryColor: themeColor,
      accentColor: themeColor
    )
  ));
}
