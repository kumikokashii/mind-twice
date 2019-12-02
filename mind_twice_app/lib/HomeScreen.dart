import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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

  Future<String> onSaveItem(item) async {
    String id = await widget.uiList.saveItemInDB(item);
    await widget.uiList.setOriginalData();
    setState(() {});

    return id;
  }

  //For sqlite db file location
  Future<void> getLocalPath() async {
    var directory = await getApplicationDocumentsDirectory();
    print(directory.path);
  }

  //Build
  @override
  Widget build(BuildContext context) {
    getLocalPath();

    return (Scaffold(
        appBar: AppBar(
          title: Text('Stuff to Mind Twice'),
        ),
        drawer: Drawer(
            child: HomeDrawer(
                listSettings: listSettings,
                onListSettingsChanged: onListSettingsChanged)),
        
        body: HomeList(widget.uiList.getFilteredAndSorted(listSettings), onSaveItem),

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
