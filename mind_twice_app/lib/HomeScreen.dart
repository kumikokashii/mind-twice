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

  Future<void> onSaveItem(item) async {
    await widget.uiList.saveItemInDB(item);
    await widget.uiList.setOriginalData();
    print('YAY');
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
