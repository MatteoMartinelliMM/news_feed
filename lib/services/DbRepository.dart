import 'package:hive/hive.dart';
import 'package:news_feed/model/Article.dart';

const NewsBox = 'newsBox';

class DbRepository {
  Box<Article> favoritesNews = Hive.box(NewsBox);

  addArticle(Article article) => favoritesNews.put(article.id, article);

  List<Article> getArticles() {
    return favoritesNews.values.toList();
  }

  List<Article> searchArticle(String title) {
    return favoritesNews.values
        .toList()
        .where((element) =>
            element.title.toLowerCase().startsWith(title.toLowerCase()))
        .toList();
  }

  watch() => favoritesNews.watch();
}
