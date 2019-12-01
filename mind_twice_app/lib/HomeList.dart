import 'package:flutter/material.dart';
import 'package:mind_twice_app/ItemScreen.dart';
import './UIList.dart';
// import './DatabaseHelper.dart';

class HomeList extends StatelessWidget {
  final List<Item> items; //This is already sorted
  HomeList(this.items);

  @override
  Widget build(BuildContext context) {
    return 
      ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            Item item = items[index];
            return Card(child: ListTile(
              title: Text(item.title),
              subtitle: Text(item.date),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemScreen(item),
                  ),
                );
              },
            ));
          }
      );
  }
  // (children: [
  //   Text('List!'),
  //   RaisedButton(
  //       child: Text('To its own screen'),
  //       onPressed: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => ItemScreen()),
  //         );
  //       })
  // ]);
}
