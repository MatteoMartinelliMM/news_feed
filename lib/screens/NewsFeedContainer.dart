import 'package:flutter/material.dart';
import 'package:news_feed/models/Article.dart';


class NewsFeedContainer extends StatefulWidget {
  String title, topic;

  NewsFeedContainer(this.title, this.topic);

  @override
  State<StatefulWidget> createState() {
    return new NewsFeedContainerState();
  }
}

class NewsFeedContainerState extends State<NewsFeedContainer> {
  PageController _pageController;
  List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return Text(widget.title + ' ' + widget.topic);
  }

  @override
  void initState() {
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
