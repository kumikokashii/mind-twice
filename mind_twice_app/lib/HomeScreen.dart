import 'package:flutter/material.dart';
import './UIList.dart';
import './HomeDrawer.dart';
import './HomeList.dart';

class HomeScreen extends StatefulWidget {
  final UIList uiList;
  HomeScreen(this.uiList);

  @override
  _HomeScreenState createState() => _HomeScreenState(uiList.originalData);
}

class _HomeScreenState extends State<HomeScreen> {
  //Variables
  Map<String, dynamic> listSettings;
  Map<String, Item> originalData;
  //

  //Constructor
  _HomeScreenState(this.originalData)
      : listSettings = {'sortByAscending': true},
        super();

  //Methods
  void onListSettingsChanged(newListSettings) {
    setState(() {
      listSettings = newListSettings;
    });
  }

  //Build
  @override
  Widget build(BuildContext context) {    
    return (Scaffold(
      appBar: AppBar(
        title: Text('App Bar Title'),
      ),
      drawer: Drawer(
          child: HomeDrawer(
              listSettings: listSettings,
              onListSettingsChanged: onListSettingsChanged)),
      body: SingleChildScrollView(
        child: Column(children: [
        Text('Sort Order: ' + listSettings['sortByAscending'].toString()),
        HomeList(widget.uiList.getFilteredAndSorted(listSettings)),
      ])
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('NEW'),
        onPressed: null, //todo::Add later
      ),
    ));
  }
}
