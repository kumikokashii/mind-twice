import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import './UIList.dart';
import './TextEditor.dart';

class ItemScreen extends StatefulWidget {
  Item item;
  Function onSaveItem;
  ItemScreen(this.item, this.onSaveItem);

  @override
  _ItemScreenState createState() => _ItemScreenState(item);
}

List<Uint8List> imageStrListToByteList(List<String> strList) {
  List<Uint8List> byteList = [];
  for (var i = 0; i < strList.length; i++) {
    var value = strList[i];
    if (value == null) {
      byteList.add(null);
    } else {
      byteList.add(base64Decode(value));
    }
  }
  return byteList;
}

List<String> imageByteListToStrList(List<Uint8List> byteList) {
  List<String> strList = [];
  for (var i = 0; i < byteList.length; i++) {
    var value = byteList[i];
    if (value == null) {
      strList.add(null);
    } else {
      strList.add(base64Encode(value));
    }
  }
  return strList;
}

class _ItemScreenState extends State<ItemScreen> {
  Item item;
  List<Uint8List> imgByteList;
  _ItemScreenState(item)
      : this.item = item.copy(),
        this.imgByteList = imageStrListToByteList(item.images),
        super();

  Future<void> saveItem(context) async {
    //Format item
    item.images = imageByteListToStrList(imgByteList);

    String id = await widget.onSaveItem(item);
    item.id = id;

    //Snackbar
    final snackBar = SnackBar(
        content: Container(
          child: Text('Saved',
              style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
        ),
        duration: const Duration(milliseconds: 750));
    Scaffold.of(context).showSnackBar(snackBar);
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

  Widget getPictureButton(source, icon) {
    return RawMaterialButton(
      onPressed: () async {
        File tempImage = await ImagePicker.pickImage(source: source);
        if (tempImage == null) {
          return;
        }

        Uint8List tempImageInByte = await tempImage.readAsBytes();
        for (var i = 0; i < imgByteList.length; i++) {
          if (imgByteList[i] == null) {
            imgByteList[i] = tempImageInByte;
            return;
          }
        }
      },
      child: Icon(
        icon,
        color: Colors.orange[500],
        size: 35.0,
      ),
      shape: CircleBorder(),
      elevation: 12.0,
      fillColor: Colors.white,
      padding: EdgeInsets.all(20.0),
    );
  }

  void deleteIthImage(i) {
    List<Uint8List> newImgByteList = [];
    for (var j = 0; j < imgByteList.length; j++) {
      if (i != j) {
        newImgByteList.add(imgByteList[j]);
      }
    }
    newImgByteList.add(null);
    imgByteList = newImgByteList;
    setState(() {});
  }

  Widget picturePart(context) {
    List<Widget> imageWidgets = [];
    for (var i = 0; i < imgByteList.length; i++) {
      if (imgByteList[i] != null) {
        imageWidgets.add(InkWell(
          child: Image.memory(imgByteList[i]),
          onTap: () async {
            var deleteResponse = await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Center(child: Text('Delete the image?')),
                    content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(color: Colors.red, width: 2),
                              ),
                              child: Text('no',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.red)),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              }),
                          FlatButton(
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(color: Colors.red, width: 2),
                              ),
                              child: Text('yes',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              }),
                        ]),
                  );
                });
            if (deleteResponse) {
              deleteIthImage(i);
            }
          },
        ));
      }
    }

    if (imageWidgets.length < 5) {
      imageWidgets.add(Padding(
          padding: EdgeInsets.all(17.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              getPictureButton(ImageSource.gallery, Icons.photo_library),
              getPictureButton(ImageSource.camera, Icons.photo_camera)
            ],
          )));
    }

    return Builder(builder: (BuildContext context) {
      return CarouselSlider(
          height: MediaQuery.of(context).size.width,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          autoPlay: false,
          items: imageWidgets.map((widget) {
            return Builder(
              builder: (BuildContext context) {
                return Container(child: widget);
              },
            );
          }).toList());
    });
  }

  Widget firstNotePart(context) {
    //Normal mode is text. On tap, shows text editor. On confirm, update text.
    String text = (item.firstNote == null || item.firstNote.trim() == '')
        ? 'Write here...'
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
        ? 'Write here...'
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
          Container(
            height: 77,
          )
        ])),
        floatingActionButton: Builder(builder: (BuildContext context) {
          return FloatingActionButton(
            child: Text('SAVE'),
            onPressed: () {
              saveItem(context);
            },
          );
        }));
  }
}
