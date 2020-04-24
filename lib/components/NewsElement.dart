import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/models/Article.dart';

class NewsElement extends StatelessWidget {
  Article article;

  NewsElement(this.article);

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(article.title));
  }
}
