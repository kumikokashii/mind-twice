import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import './HomeScreen.dart';
import './UIList.dart';

Future<void> copyCloudDBtoLocalDB(userId) async {
  print('HELLO!!!');
  //Local path
  var directory = await getApplicationDocumentsDirectory();
  String dbFilePath = directory.path + '/' + 'MindTwice.db';
  print(dbFilePath);

  //Forebase file
  print(userId);
  final StorageReference storageRef =
      FirebaseStorage.instance.ref().child(userId + '.db');
  final StorageFileDownloadTask downloadTask =
      storageRef.writeToFile(File(dbFilePath));
  downloadTask.future;
  print('done');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('email') != null) {
    await copyCloudDBtoLocalDB(prefs.getString('userId'));
  }

  UIList uiList = UIList();
  await uiList.setOriginalData();

  runApp(MaterialApp(
    title: 'Mind Twice',
    home: HomeScreen(prefs, uiList),
  ));
}
