import 'package:flutter/material.dart';

class ItemScreen extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  _ItemScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('This reading...')),
        body: Column(
          children: <Widget>[
            Text('Name Row'),
            Text('Date Row'),
            Text('ETC ^_^')
          ],
        ));
  }
}
