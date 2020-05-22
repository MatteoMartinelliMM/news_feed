import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_feed/model/Article.dart';

class Api {
  static final String baseUrl = 'https://newsapi.org/v2/';
  final String topHeaderLines = 'top-headlines';
  final String apiKey = '43650e7b746a43548d89d2658979b4d9';
  final String apiKeyQuery = 'apiKey=43650e7b746a43548d89d2658979b4d9';

  final String categoryParams = 'category=';
  String country = 'it';
  String countryParams = 'country=it';
  String language = 'it';
  String languageParams = 'language=it';
  final String sources = 'sources?';
  var client = null;
  final Dio dio = Dio();

  final DioCacheManager dioCache =
      DioCacheManager(CacheConfig(baseUrl: baseUrl));

  String category;

  Api() {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = 5000;
    dio.transformer = FlutterTransformer();
    dio.interceptors.add(dioCache.interceptor);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      options.queryParameters['language'] = country;
      options.queryParameters['country'] = country;
      options.queryParameters['apiKey'] = apiKey;
      if (category != null) {
        options.queryParameters['category'] = category;
        category = null;
      }
      print(options.path);
      print(options.queryParameters);
      print(options.uri);
      return options;
    }, onResponse: (Response response) async {
      print(response.realUri);
      print(response.request.path);
      print(response.data);
      return response;
    }, onError: (DioError e) async {
      print(e.request.uri);
      print(e);
      return e;
    }));
  }

  Future<List<Article>> getNewByCategory(
      {@required String category, String query}) async {
    this.category = category;
    var response = await dio.get(topHeaderLines,
        options: buildCacheOptions(Duration(seconds: 120),
            options: Options(extra: createExtras(category, query))));
    if (response.statusCode == 200) {
      return response.data['articles']
          .map<Article>((json) => Article.fromJson(json))
          .toList();
    } else
      return new List();
  }

  Map<String, dynamic> createExtras(String category, String query) {
    LinkedHashMap<String, dynamic> map = LinkedHashMap();
    if (category != null) map['category'] = category;
    if (query != null) map['q'] = query;
    return map;
  }
}
