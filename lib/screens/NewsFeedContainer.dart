import 'package:flutter/material.dart';
import 'package:news_feed/components/NewsElement.dart';
import 'package:news_feed/models/Article.dart';
import 'package:news_feed/models/NewsHolder.dart';
import 'package:news_feed/screens/NewsDetail.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsHolder>(builder: (context, news, child) {
      if (news.articles.length == 0)
        return CircularProgressIndicator();
      else
        return ListView.builder(
            itemCount: news.articles.length,
            itemBuilder: (context, position) {
              return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, NewsDetail.route,
                      arguments: news.articles[position]),
                  child: NewsElement(article: news.articles[position]));
            });
    });
  }

  @override
  void initState() {}

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
