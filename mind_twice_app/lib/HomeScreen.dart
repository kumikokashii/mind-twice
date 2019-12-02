import 'package:flutter/material.dart';
import './UIList.dart';
import './HomeDrawer.dart';
import './HomeList.dart';
import './ItemScreen.dart';

class HomeScreen extends StatefulWidget {
  final UIList uiList;
  HomeScreen(this.uiList);

  @override
  _HomeScreenState createState() => _HomeScreenState(uiList.originalData);
}

class _HomeScreenState extends State<HomeScreen> {
  //Variables
  Map<String, bool> listSettings;
  Map<String, Item> originalData;
  //

  //Constructor
  _HomeScreenState(this.originalData)
      : listSettings = {
          'filterOnceOnly': false,
          'sortByDate4Back': false, //Default is sort by date
          'sortAscending': true
        },
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
          title: Text('Stuff to Mind Twice'),
        ),
        drawer: Drawer(
            child: HomeDrawer(
                listSettings: listSettings,
                onListSettingsChanged: onListSettingsChanged)),
        body: SingleChildScrollView(
            child: Column(children: [
          Text('filterOnceOnly: ' + listSettings['filterOnceOnly'].toString()),
          Text('sortByDate4Back: ' + listSettings['sortByDate4Back'].toString()),
          Text('sortAscending: ' + listSettings['sortAscending'].toString()),
          HomeList(widget.uiList.getFilteredAndSorted(listSettings)),
        ])),
        floatingActionButton: FloatingActionButton(
            child: Text('NEW'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemScreen(Item.newNoID()),
                ),
              );
            })));
  }
}
