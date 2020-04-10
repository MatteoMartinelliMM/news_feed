import 'package:flutter/material.dart';
import 'package:news_feed/Services/Api.dart';
import 'package:news_feed/models/Article.dart';

class NewsHolder extends ChangeNotifier {
  NewsHolder() {
  }

  final List<Article> _articles = [];

  set articles(List<Article> articles) {
    assert(articles != null);
    _articles.clear();
    _articles.addAll(articles);
    notifyListeners();
  }

  List<Article> get articles => _articles;
}
