import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_feed/components/WebImage.dart';
import 'package:news_feed/model/Article.dart';
import 'package:news_feed/services/DbRepository.dart';
import 'package:share/share.dart';

class NewsElement extends StatefulWidget {
  Article article;

  NewsElement({@required this.article});

  @override
  State<StatefulWidget> createState() {
    return new NewsElementState();
  }
}

class NewsElementState extends State<NewsElement> {
  bool selected;
  Box<Article> favoriteBox;

  @override
  void initState() {
    favoriteBox = Hive.box(NewsBox);
    selected = favoriteBox.containsKey(widget.article.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Stack(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                WebImage(
                  url: widget.article.urlToImage,
                  height: 200.0,
                  radius: 16.0,
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      widget.article.title,
                      style: TextStyle(fontSize: 16),
                    ))
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(0XEC, 0XEC, 0XEC, 0.4)),
              child: Center(
                child: IconButton(
                  icon: Icon(selected ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    if (favoriteBox.containsKey(widget.article.id)) {
                      favoriteBox.delete(widget.article.id);
                      return;
                    }
                    favoriteBox.put(widget.article.id, widget.article);
                    setState(() {
                      selected = !selected;
                    });
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(0XEC, 0XEC, 0XEC, 0.4)),
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share('Penso possa interessarti quest\'articolo ' +
                        widget.article.url);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
