import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/components/StrokeText.dart';
import 'package:news_feed/components/WebImage.dart';
import 'package:news_feed/models/Article.dart';

class NewsElement extends StatelessWidget {
  Article article;

  NewsElement({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            WebImage(
              url: article.imageUrl,
              height: 200.0,
              radius: 16.0,
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  article.title,
                  style: TextStyle(fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
