import 'package:flutter/material.dart';
import './UIList.dart';
import './HomeDrawer.dart';
import './HomeList.dart';
import './ItemScreen.dart';

class HomeScreen extends StatefulWidget {
  final UIList uiList;
  HomeScreen(this.uiList);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Variables
  Map<String, bool> listSettings;
  //

  //Constructor
  _HomeScreenState()
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

  Future<String> onSaveItem(Item item) async {
    String id = await widget.uiList.saveItemInDB(item);
    await widget.uiList.setOriginalData();
    setState(() {});

    return id;
  }

  Future<void> onDeleteItem(Item item) async {
    await widget.uiList.deleteItemInDB(item);
    await widget.uiList.setOriginalData();
    setState(() {});
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
        body: HomeList(widget.uiList.getFilteredAndSorted(listSettings),
            onSaveItem, onDeleteItem),
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
