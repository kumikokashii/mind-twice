import 'package:flutter/material.dart';
import './HomeDrawer.dart';
import './HomeList.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Variables
  Map<String, dynamic> listSettings;
  //

  _HomeScreenState()
      : listSettings = {'sortByAscending': true},
        super();

  void onListSettingsChanged(newListSettings) {
    setState(() {
      listSettings = newListSettings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text('App Bar Title'),
      ),
      drawer: Drawer(
        child: HomeDrawer(
          listSettings: listSettings,
          onListSettingsChanged: onListSettingsChanged
          )),
      body: Column(children: [
        Text('Sort Order: ' + listSettings['sortByAscending'].toString()),
        HomeList(),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Text('NEW'),
        onPressed: null, //todo::Add later
      ),
    ));
  }
}
