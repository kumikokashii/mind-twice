import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import './UserAccount.dart';

//On every change of settings, the state class will update the parent (home screen).

class HomeDrawer extends StatefulWidget {
  SharedPreferences prefs;
  Map<String, bool> listSettings;
  Function onListSettingsChanged;

  HomeDrawer(
      {@required this.prefs,
      @required this.listSettings,
      @required this.onListSettingsChanged})
      : super();

  @override
  _HomeDrawerState createState() => _HomeDrawerState(listSettings);
}

class _HomeDrawerState extends State<HomeDrawer> {
  Map<String, bool> listSettings;

  _HomeDrawerState(this.listSettings);

  getSwitchListTileWidget(field, label, icon) {
    return (Container(
      child: SwitchListTile(
        title: Text(label),
        value: listSettings[field] == null ? false : listSettings[field],
        onChanged: (newValue) {
          setState(() {
            listSettings[field] = newValue;
          });
          widget.onListSettingsChanged(listSettings);
        },
        secondary: Icon(icon),
      ),
      padding: EdgeInsets.only(bottom: 20),
    ));
  }

  getSaveToCloudWidget() {
    return (Column(children: [
      FloatingActionButton.extended(
        onPressed: () async {
          //Local path
          var directory = await getApplicationDocumentsDirectory();
          String dbFilePath = directory.path + '/' + 'MindTwice.db';
          print(dbFilePath);

          //Forebase file
          String userId = widget.prefs.getString('userId');
          final StorageReference storageRef =
              FirebaseStorage.instance.ref().child(userId + '.db');
          final StorageUploadTask uploadTask =
              storageRef.putFile(File(dbFilePath));
          await uploadTask.onComplete;
          print('done');
        },
        icon: Icon(Icons.cloud_upload),
        label: Text('Save to cloud'),
      ),
      SizedBox(height: 10),
      Text('Logged in as: ' + widget.prefs.getString('email'),
          style: TextStyle(color: Colors.grey))
    ]));
  }

  getUserAccountWidget(context) {
    return (Column(
      children: <Widget>[
        FloatingActionButton.extended(
          onPressed: () async {
            var result = await showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return UserAccount('create', context, widget.prefs);
                });
            if (result) {
              setState(() {});
            }
          },
          icon: Icon(Icons.person_add),
          label: Text('Create account'),
        ),
        SizedBox(height: 20),
        FloatingActionButton.extended(
            onPressed: () async {
              var result = await showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (BuildContext context) {
                    return UserAccount('login', context, widget.prefs);
                  });
              if (result) {
                setState(() {});
              }
            },
            icon: Icon(Icons.account_circle),
            label: Text('Log in'),
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.white),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    bool loggedIn = widget.prefs.getString('userId') != null;

    return (SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: Column(children: [
          SizedBox(height: 50),
          getSwitchListTileWidget('filterOnceOnly',
              'Only show once-minded items', Icons.battery_unknown),
          getSwitchListTileWidget('sortByDate4Back', 'Sort by date to be back',
              Icons.calendar_today),
          getSwitchListTileWidget(
              'sortAscending', 'Sort ascending', Icons.arrow_upward),
          loggedIn ? getSaveToCloudWidget() : getUserAccountWidget(context)
        ])));
  }
}
