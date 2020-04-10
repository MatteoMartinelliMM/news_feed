import 'package:flutter/material.dart';

class NewsFeedContainer extends StatefulWidget {
  String title;

  NewsFeedContainer(this.title);

  @override
  State<StatefulWidget> createState() {
    return new NewsFeedContainerState();
  }
}

class NewsFeedContainerState extends State<NewsFeedContainer> {
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Text(widget.title);
  }

  @override
  void initState() {
    _pageController = new PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
