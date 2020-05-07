import 'package:flutter/material.dart';
import 'package:news_feed/Services/Api.dart';
import 'package:news_feed/models/Article.dart';

class NewsHolder extends ChangeNotifier {

  List<Article> _articles = [];

  NewsHolder() {
    Api().getHeaderLines().then((value) => articles = value);
    notifyListeners();
  }

  getByCategory(String category) {
    Api().getNewByCategory(category: category).then((value) => articles = value);
    notifyListeners();
  }

  set articles(List<Article> articles) {
    assert(articles != null);
    _articles.clear();
    _articles.addAll(articles);
    notifyListeners();
  }

  List<Article> get articles => _articles;
}
