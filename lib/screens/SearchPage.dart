import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  static const String route = '/SearchPage';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: TextField(
        style: TextStyle(color: Colors.white),
        focusNode: _focusNode,
        autofocus: true,
        decoration: InputDecoration(border: InputBorder.none),
      )),
      body: Center(child: Text('Search screen')),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }
}
