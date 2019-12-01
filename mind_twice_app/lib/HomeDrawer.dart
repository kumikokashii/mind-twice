import 'package:flutter/material.dart';

class HomeDrawer extends StatefulWidget {
  Map<String, dynamic> listSettings;
  Function onListSettingsChanged;

  HomeDrawer(
      {@required this.listSettings, @required this.onListSettingsChanged})
      : super();

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  _HomeDrawerState();

  void toggleSortByAscending() {
    widget.listSettings['sortByAscending'] =
        !widget.listSettings['sortByAscending'];
    widget.onListSettingsChanged(widget.listSettings);
  }

  @override
  Widget build(BuildContext context) {
    return (Column(children: [
      Text(widget.listSettings['sortByAscending'].toString()),
      RaisedButton(
        child: Text('Toggle sort order'),
        onPressed: toggleSortByAscending,
      ),
      Text('In Drawer'),
      Text('Another one'),
      Text('Third line')
    ]));
  }
}
