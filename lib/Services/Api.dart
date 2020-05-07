import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:news_feed/models/Article.dart';

class Api {
  final String baseUrl = 'https://newsapi.org/v2/';
  final String topHeaderLines = 'top-headlines?';
  final String apiKey = 'apiKey=43650e7b746a43548d89d2658979b4d9';
  final String categoryParams = 'category=';
  String country = 'country=it';
  String language = 'language=it';
  final String sources = 'sources?';
  var client = null;
  final Dio dio = Dio();

  //final DioCacheManager dioCache =
  // DioCacheManager(CacheConfig(baseUrl: baseUrl));

  Api() {
    /*dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = 5000;
    dio.transformer = FlutterTransformer();
    dio.interceptors.add(dioCache.interceptor);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      var params = options.queryParameters;
      print(options.path);
      params['apiKey'] = apiKey;
      params['language'] = country;
      options.queryParameters = params;
      print(options.queryParameters);
      return options;
    }, onResponse: (Response response) async {
      print(response.request.path);
      print(response.data);
      return response;
    }));*/
  }

  Future<List<Article>> getNewByCategory({@required String category}) async {
    var response = await http.get(
      baseUrl +
          topHeaderLines +
          country +
          '&' +
          language +
          '&' +
          categoryParams +
          category +
          '&' +
          apiKey,
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<dynamic> articleJson = jsonResponse['articles'];
      List<Article> article = new List();
      await articleJson.forEach((element) {
        article.add(Article.fromJson(element));
      });
      return article;
    } else
      return new List();
  }

  Future<List<Article>> getHeaderLines() async {
    String url =
        baseUrl + topHeaderLines + country + '&' + language + '&' + apiKey;

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      LinkedHashMap<String, dynamic> jsonResponse =
          await jsonDecode(response.body);
      dynamic articleJson = jsonResponse['articles'];
      List<Article> article = new List();
      articleJson.forEach((element) {
        article.add(Article.fromJson(element));
      });
      return article;
    } else
      return new List();
  }
}
