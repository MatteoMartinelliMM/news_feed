import 'dart:async';

import 'package:hive/hive.dart';
import 'package:news_feed/services/DbRepository.dart';

import 'Services/Api.dart';
import 'model/Article.dart';

String categoryName(Categories category) => category.toString().split('.').last;

class NewsBloc {
  final Api _repository = Api();
  final DbRepository _dbRepository = DbRepository();

  Categories _actualCategory = Categories.general;
  AppScreen _actualScreen = AppScreen.main;

  //Streams
  Stream<List<Article>> get articles => _articles.stream;

  Stream<List<Article>> get searchArticles => _searchArticles.stream;

  Stream<Categories> get actualCategory => _screenController.stream;

  Stream<AppScreen> get actualScreen => _actualScreenController.stream;

  final StreamController<Categories> _screenController =
      StreamController<Categories>.broadcast();
  final StreamController<List<Article>> _articles =
      StreamController<List<Article>>.broadcast();
  final StreamController<List<Article>> _searchArticles =
      StreamController<List<Article>>.broadcast();
  final StreamController<AppScreen> _actualScreenController =
      new StreamController<AppScreen>.broadcast();

  NewsBloc() {
    Hive.box<Article>(NewsBox).watch().forEach((element) {
      print(element.toString());
      _manageArticles();
    });
    _manageArticles();
  }

  changeCategory(int index) {
    _actualCategory = Categories.values[index];
    _articles.sink.add(null); //Clear news
    _screenController.sink.add(_actualCategory);
    getNews();
  }

  changeScreen(int index) {
    _actualScreen = AppScreen.values[index];
    _actualScreenController.sink.add(_actualScreen);
    _manageArticles();
  }

  _manageArticles() {
    if (AppScreen.favorites == _actualScreen)
      _articles.sink.add(_dbRepository.getArticles());
    else
      getNews();
  }

  getNews() async {
    String requestCategory = _actualCategory == Categories.general
        ? null
        : categoryName(_actualCategory);
    _repository
        .getNewByCategory(category: requestCategory)
        .then((response) => _articles.sink.add(response));
  }

  fetchSearchArticles(String title) {
    if (title.isNotEmpty)
      _searchArticles.sink.add(_dbRepository.searchArticle(title));
  }

  dispose() {
    _screenController?.close();
    _searchArticles?.close();
    _articles?.close();
    _actualScreenController?.close();
  }
}

enum AppScreen { main, favorites }

enum Categories {
  general,
  business,
  entertainment,
  health,
  science,
  sports,
  technology
}
