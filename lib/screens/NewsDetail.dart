import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/components/WebImage.dart';
import 'package:news_feed/model/Article.dart';
import 'package:news_feed/screens/FullArticleWV.dart';

class NewsDetail extends StatefulWidget {
  static const route = '/newsDetail';

  @override
  State<StatefulWidget> createState() {
    return new NewsDetailState();
  }
}

class NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    Article a = ModalRoute.of(context).settings.arguments;
    String articleBody = a.content != null
        ? a.content
            .split('[')
            .first
            .substring(0, a.content.split('[').first.length - 4)
        : '';
    return Scaffold(
      body: Column(
        children: <Widget>[
          WebImage(url: a.urlToImage, height: 250.0, radius: 0),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              a.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(a.description,
                  style: TextStyle(fontStyle: FontStyle.italic))),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: RichText(
                text: TextSpan(
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    children: <TextSpan>[
                  TextSpan(text: articleBody),
                  TextSpan(
                      text: "...continua a leggere",
                      style: TextStyle(
                          color: Colors.lightBlue,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushNamed(
                            context, FullArticeWV.route,
                            arguments: a.url))
                ])),
          )
        ],
      ),
    );
  }
}
