import 'package:flutter/material.dart';
import './DatabaseHelper.dart';

class ItemScreen extends StatefulWidget {
  ItemScreen();

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  _ItemScreenState();
  // DatabaseHelper dbHelper = DatabaseHelper.instance; //Create this singleton
  Map<String, dynamic> itemContent = {}; //Add later

  void saveItem() {
    //Format item content if needed
    var itemToUpload = itemContent;

    //Upload to db
    // try {
    //   dbHelper.upsert(itemToUpload);
    // } catch (e) {
    //   print('Error when saving to database');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('This reading...')),
        body: Column(
          children: <Widget>[
            Text('Name Row'),
            Text('Date Row'),
            Text('ETC ^_^'),
            RaisedButton(
              child: Text('Save'),
              onPressed: saveItem,
            )
          ],
        ));
  }
}
