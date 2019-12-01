import 'package:flutter/material.dart';
import './UIList.dart';

class ItemScreen extends StatefulWidget {
  Item item;
  ItemScreen(this.item);

  @override
  _ItemScreenState createState() => _ItemScreenState(item);
}

class _ItemScreenState extends State<ItemScreen> {
  Item item;
  _ItemScreenState(this.item);

  //Parts
  Widget datePart() {
    return GestureDetector(
        child: Container(
      child: Text(item.date),
    ));
  }

  Widget picturePart() {
    return Text('image part');
  }

  Widget firstNotePart() {
    return Text('firstNotePart');
  }

  Widget secondNotePart() {
    return Text('secondNotePart');
  }

  Widget saveButtonPart() {
    return RaisedButton(child: Text('Save'), onPressed: null);
  }
  //End Parts

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(item.title)),
        body: Column(children: [
          datePart(),
          picturePart(),
          firstNotePart(),
          secondNotePart(),
          saveButtonPart(),
        ]));
  }
}
