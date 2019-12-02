import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './ItemScreen.dart';
import './UIList.dart';

class HomeList extends StatelessWidget {
  final List<Item> items; //This is already sorted
  Function onSaveItem;
  HomeList(this.items, this.onSaveItem);

  @override
  Widget build(BuildContext context) {
    getStrDate(date) {
      if (date == null) {
        return '';
      }
      return DateFormat('E MMM d, y').format(date);
    }

    //For dates
    getSmallTextContainer(text, bgColor) {
      if (text == '') {
        return SizedBox.shrink();
      }

      return (Container(
        child:
            Text(text, style: TextStyle(fontSize: 16, color: Colors.grey[850])),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ));
    }

    String getTitleText(item) {
      return item.title == null ? 'TBD' : item.title;
    }

    return (ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          Item item = items[index];
          return GestureDetector(
              child: Card(
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(getTitleText(item),
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        padding: EdgeInsets.only(
                            top: 14, right: 18, bottom: 7, left: 18)),
                    Row(
                      children: <Widget>[
                        getSmallTextContainer(
                            getStrDate(item.date4back), Colors.green[50]),
                        getSmallTextContainer(
                            getStrDate(item.date), Colors.yellow[50]),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemScreen(item, onSaveItem),
                  ),
                );
              });
        }));
  }
}
