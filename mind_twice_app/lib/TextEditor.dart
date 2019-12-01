import 'package:flutter/material.dart';

class TextEditor extends StatefulWidget {
  String title;
  String initialValue;
  TextEditor(this.title, this.initialValue);

  @override
  _TextEditorState createState() => _TextEditorState(initialValue);
}

class _TextEditorState extends State<TextEditor> {
  TextEditingController controller;
  _TextEditorState(initialValue) {
    super.initState();
    controller = TextEditingController(text: initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(
              fontSize: 20,
            )
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text('Go!'),
          onPressed: () {
            Navigator.pop(context, controller.text);
          },
        )));
  }
}
