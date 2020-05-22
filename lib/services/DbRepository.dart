import 'package:hive/hive.dart';
import 'package:news_feed/model/Article.dart';

const NewsBox = 'newsBox';

class DbRepository {
  Box<Article> favoritesNews = Hive.box(NewsBox);

  addArticle(Article article) => favoritesNews.put(article.id, article);

  List<Article> getArticles() {
    return favoritesNews.values.toList();
  }

  watch() => favoritesNews.watch();
}
