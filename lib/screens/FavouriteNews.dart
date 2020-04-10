import 'package:flutter/material.dart';

class FavouriteNews extends StatefulWidget {
  String title;

  FavouriteNews(this.title);

  @override
  State<StatefulWidget> createState() {
    return new FavouriteNewsState();
  }
}

class FavouriteNewsState extends State<FavouriteNews> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.title);
  }
}
