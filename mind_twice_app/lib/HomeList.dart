import 'package:flutter/material.dart';
import './ItemScreen.dart';

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  _HomeListState();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('List!'),
      RaisedButton(
          child: Text('To its own screen'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemScreen()),
            );
          })
    ]);
  }
}
