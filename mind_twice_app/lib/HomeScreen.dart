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
          'sortByDate4Back': false,
          'sortAscending': true
        },
        super();

  //Methods
  void onListSettingsChanged(newListSettings) {
    setState(() {
      listSettings = newListSettings;
    });
  }

  onSaveItem(item) {
    //do the thing
    print('do the thing');
    widget.uiList.saveItemInDB(item);
    originalData = widget.uiList.getOriginalData();
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
          HomeList(
              widget.uiList.getFilteredAndSorted(listSettings), onSaveItem),
        ])),
        floatingActionButton: FloatingActionButton(
            child: Text('NEW'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemScreen(Item.newNoID(), onSaveItem),
                ),
              );
            })));
  }
}
