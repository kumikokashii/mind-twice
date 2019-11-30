import 'package:flutter/material.dart';
import './HomeDrawer.dart';
import './HomeList.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState();

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text('App Bar Title'),
      ),
      drawer: Drawer(child: HomeDrawer()),
      body: HomeList(),
      floatingActionButton: FloatingActionButton(
        child: Text('NEW'),
        onPressed: null, //todo::Add later
      ),
    ));
  }
}
