class Article {
  String _author;

  String _title;

  String _description;

  String _url;

  String _imageUrl;

  String _publishedAt;

  String _content;

  String get author => _author;

  set author(String value) {
    _author = value;
  }

  String get title => _title;

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  String get publishedAt => _publishedAt;

  set publishedAt(String value) {
    _publishedAt = value;
  }

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  set title(String value) {
    _title = value;
  }

  static fromJson(Map<String, dynamic> jsonResponse) {
    Article a = new Article();
    a.author = jsonResponse['author'];
    a.title = jsonResponse['title'];
    a.description = jsonResponse['description'];
    a.url = jsonResponse['url'];
    a.imageUrl = jsonResponse['urlToImage'];
    a.publishedAt = jsonResponse['publishedAt'];
    a.content = jsonResponse['content'];
    return a;
  }
}
