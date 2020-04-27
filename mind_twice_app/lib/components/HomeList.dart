import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './ItemScreen.dart';
import './UIList.dart';
import 'reusable.dart';

class HomeList extends StatelessWidget {
  final List<Item> items; //This is already sorted
  Function onSaveItem;
  Function onDeleteItem;
  HomeList(this.items, this.onSaveItem, this.onDeleteItem);
  final SlidableController slidableController = SlidableController();

  Future<void> deleteItem(item) async {
    onDeleteItem(item);
  }

  @override
  Widget build(BuildContext context) {
    getStrDate(date) {
      if (date == null) {
        return '';
      }
      return DateFormat('E, MMM d, y').format(date);
    }

    String getTitleText(item) {
      return item.title == null ? 'TBD' : item.title;
    }

    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          Item item = items[index];
          return Slidable(
              actionPane: SlidableScrollActionPane(),
              controller: slidableController, //Only 1 open at a time
              actionExtentRatio: 0.25,
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    deleteItem(item);
                  },
                ),
              ],
              child: Card(
                  child: InkWell(
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
                                  getStrDate(item.date), Colors.yellow[50]),
                              getSmallTextContainer(
                                  getStrDate(item.date4back), Colors.green[50]),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemScreen(item, onSaveItem),
                          ),
                        );
                      })));
        });
  }
}
