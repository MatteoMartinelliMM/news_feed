import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_feed/models/Article.dart';
import 'package:news_feed/models/NewsHolder.dart';

class Api {
  final String baseUrl = 'https:/newsapi.org/v2/top-headlines?';
  final String apiKey = 'apiKey=43650e7b746a43548d89d2658979b4d9';
  final String categoryParams = 'category=';
  String country = 'country=it';
  String language = 'language=it';
  var client = null;

  Api() {
    client = http.Client();
  }

  Future<List<Article>> getNewByCategory(String category) async {
    client = http.Client();
    var response = await client.get(baseUrl +
        country +
        '&' +
        language +
        '&' +
        categoryParams +
        category +
        '&' +
        apiKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<dynamic> articleJson = jsonResponse['articles'];
      List<Article> article = new List();
      articleJson.forEach((element) {
        article.add(Article.fromJson(element));
      });
    }
  }

  Future<List<Article>> getHeaderLines() async {
    client = http.Client();
    var response =
        await client.get(baseUrl + country + '&' + language + '&' + apiKey);
  }
}
