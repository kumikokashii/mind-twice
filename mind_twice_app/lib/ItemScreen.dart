import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import './UIList.dart';
import './TextEditor.dart';

class ItemScreen extends StatefulWidget {
  Item item;
  Function onSaveItem;
  ItemScreen(this.item, this.onSaveItem);

  @override
  _ItemScreenState createState() => _ItemScreenState(item);
}

class _ItemScreenState extends State<ItemScreen> {
  Item item;
  File tempImage;
  _ItemScreenState(item)
      : this.item = item.copy(),
        tempImage = null,
        super();

  void saveItem() async {
    //Format item
    if (tempImage != null) {
      List<int> imageBytes = await tempImage.readAsBytes();
      item.image = base64Encode(imageBytes);
    }

    widget.onSaveItem(item);
  }

  //Parts
  Widget datePart(context) {
    String strItemDate = DateFormat('E, MMMM d, y').format(item.date);

    return GestureDetector(
      child: Center(
          child: Container(
        child: Text(strItemDate, style: TextStyle(fontSize: 20)),
        color: Colors.yellow[200],
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
      )),
      onTap: () {
        showDatePicker(
                context: context,
                initialDate: item.date,
                firstDate: DateTime(2001),
                lastDate: DateTime(2021))
            .then((value) {
          if (value == null) {
            return;
          }
          item.date = value;
          setState(() {});
        });
      },
    );
  }

  Widget picturePart(context) {
    //image is stored in database as byte string (String).
    //image pulled from camera or gallery is an image file (File).

    Widget imageWidget = SizedBox.shrink();
    if (tempImage != null) {
      imageWidget = Image.file(tempImage);
    } else if (item.image != null) {
      imageWidget = Image.memory(base64Decode(item.image));
    }

    return Center(
        child: Container(
            child: Column(children: <Widget>[
      imageWidget,
      Padding(
          padding: EdgeInsets.all(17.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RawMaterialButton(
                onPressed: () async {
                  tempImage =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                  if (tempImage == null) {
                    return;
                  }
                  setState(() {});
                },
                child: Icon(
                  Icons.photo_library,
                  color: Colors.orange[500],
                  size: 35.0,
                ),
                shape: CircleBorder(),
                elevation: 12.0,
                fillColor: Colors.white,
                padding: EdgeInsets.all(20.0),
              ),
              RawMaterialButton(
                onPressed: () {},
                child: Icon(
                  Icons.photo_camera,
                  color: Colors.orange[500],
                  size: 35.0,
                ),
                shape: CircleBorder(),
                elevation: 12.0,
                fillColor: Colors.white,
                padding: EdgeInsets.all(20.0),
              ),
            ],
          ))
    ])));
  }

  Widget firstNotePart(context) {
    //Normal mode is text. On tap, shows text editor. On confirm, update text.
    String text = (item.firstNote == null || item.firstNote.trim() == '')
        ? 'Write here'
        : item.firstNote;

    return GestureDetector(
        child: Center(
            child: Container(
          child: Text(text, style: TextStyle(fontSize: 18)),
          color: Colors.yellow[50],
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(8.0),
        )),
        onTap: () async {
          String newNote = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TextEditor('Note Editor', item.firstNote),
            ),
          );
          if (newNote == null) {
            return;
          }
          item.firstNote = newNote;
        });
  }

  Widget date4backPart(context) {
    String strItemDate4Back = (item.date4back == null)
        ? 'Pick your next date'
        : DateFormat('E, MMMM d, y').format(item.date4back);

    return GestureDetector(
      child: Center(
          child: Container(
        child: Text(strItemDate4Back, style: TextStyle(fontSize: 20)),
        color: Colors.lightGreen[100],
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
      )),
      onTap: () {
        showDatePicker(
                context: context,
                initialDate:
                    item.date4back == null ? DateTime.now() : item.date4back,
                firstDate: DateTime(2001),
                lastDate: DateTime(2021))
            .then((value) {
          if (value == null) {
            return;
          }
          item.date4back = value;
          setState(() {});
        });
      },
    );
  }

  Widget secondNotePart(context) {
    //Normal mode is text. On tap, shows text editor. On confirm, update text.
    String text = (item.secondNote == null || item.secondNote.trim() == '')
        ? 'Write here'
        : item.secondNote;

    return GestureDetector(
        child: Center(
            child: Container(
          child: Text(text, style: TextStyle(fontSize: 18)),
          color: Colors.lightGreen[50],
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(8.0),
        )),
        onTap: () async {
          String newNote = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TextEditor('Note Editor', item.secondNote),
            ),
          );
          if (newNote == null) {
            return;
          }
          item.secondNote = newNote;
        });
  }
  //End Parts

  @override
  Widget build(BuildContext context) {
    String titleText = (item.title == null || item.title.trim() == '')
        ? 'Add title here...'
        : item.title;

    return Scaffold(
        appBar: AppBar(
            title: GestureDetector(
          child: Text(titleText),
          onTap: () async {
            String newTitle = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TextEditor('Title Editor', item.title),
              ),
            );
            if (newTitle == null) {
              return;
            }
            item.title = newTitle;
          },
        )),
        body: SingleChildScrollView(
            child: Column(children: [
          datePart(context),
          picturePart(context),
          firstNotePart(context),
          date4backPart(context),
          secondNotePart(context),
        ])),
        floatingActionButton: FloatingActionButton(
          child: Text('Save'),
          onPressed: () {
            saveItem();
          },
        ));
  }
}
