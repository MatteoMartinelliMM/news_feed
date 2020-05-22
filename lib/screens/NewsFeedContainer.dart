import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/NewsBloc.dart';
import 'package:news_feed/components/NewsElement.dart';
import 'package:news_feed/model/Article.dart';
import 'package:news_feed/screens/NewsDetail.dart';
import 'package:provider/provider.dart';

class NewsFeedContainer extends StatelessWidget {
  String title;

  NewsFeedContainer(this.title);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<NewsBloc>(context);
    return StreamBuilder<List<Article>>(
      stream: bloc.articles,
      builder: (context, AsyncSnapshot<List<Article>> snapshot) {
        if (!snapshot.hasData)
          return CircularProgressIndicator();
        else if (!snapshot.data.isEmpty)
          return !kIsWeb
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, NewsDetail.route,
                            arguments: snapshot.data[position]),
                        child: NewsElement(article: snapshot.data[position]));
                  })
              : GridView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, NewsDetail.route,
                            arguments: snapshot.data[position]),
                        child: NewsElement(article: snapshot.data[position]));
                  });
        else
          return Center(
              child: Column(
            children: <Widget>[
              Icon(Icons.error, color: Colors.black12),
              Text(
                "Something went wrong.",
                style: TextStyle(color: Colors.black12, fontSize: 14),
              )
            ],
          ));
      },
    );
  }
}
