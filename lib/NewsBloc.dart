import 'dart:async';

import 'Services/Api.dart';
import 'models/Article.dart';

String categoryName(Categories category) => category.toString().split('.').last;

class NewsBloc {
  final Api _repository = Api();

  Categories _actualCategory = Categories.general;
  AppScreen _actualScreen = AppScreen.main;

  //Streams
  Stream<List<Article>> get articles => _articles.stream;

  Stream<Categories> get actualCategory => _screenController.stream;

  Stream<AppScreen> get actualScreen => _actualScreenController.stream;

  final StreamController<Categories> _screenController =
      StreamController<Categories>.broadcast();
  final StreamController<List<Article>> _articles =
      StreamController<List<Article>>.broadcast();
  final StreamController<AppScreen> _actualScreenController =
      new StreamController<AppScreen>.broadcast();

  NewsBloc() {
    /*Hive.box<Article>(NewsBox).watch().forEach((element) {
      print(element.toString());
      _manageArticles();
    });*/
    manageArticles();
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
    //_manageArticles();
  }

  manageArticles() {
    getNews();
  }

  getNews() async {
    List<Article> response = _actualCategory == Categories.general
        ? await _repository.getHeaderLines()
        : await _repository.getNewByCategory(
            category: categoryName(_actualCategory));
    _articles.sink.add(response);
  }

  dispose() {
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
