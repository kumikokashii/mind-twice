import 'package:flutter/material.dart';

//On every change of settings, the state class will update the parent (home screen).
//That will re-render the home screen, which also re-render this drawer class.

class HomeDrawer extends StatefulWidget {
  Map<String, bool> listSettings;
  Function onListSettingsChanged;

  HomeDrawer(
      {@required this.listSettings, @required this.onListSettingsChanged})
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

  @override
  Widget build(BuildContext context) {
    return (
      SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: Column(
          children: [
            getSwitchListTileWidget('filterOnceOnly', 'Only show once-minded items', Icons.battery_unknown),
            getSwitchListTileWidget('sortByDate4Back', 'Sort by date to be back', Icons.calendar_today),
            getSwitchListTileWidget('sortAscending', 'Sort ascending', Icons.arrow_upward),
          ])
      ));
  }
}
