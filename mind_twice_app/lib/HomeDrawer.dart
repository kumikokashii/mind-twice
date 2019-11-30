import 'package:flutter/material.dart';


class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  _HomeDrawerState();

  @override
  Widget build(BuildContext context) {
    return (
      Column(
        children: [
          Text('In Drawer'),
          Text('Another one'),
          Text('Third line')
        ]
      )
    );
  }
}
