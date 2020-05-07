import 'package:flutter/material.dart';
import 'package:news_feed/NewsBloc.dart';
import 'package:news_feed/components/NewsElement.dart';
import 'package:news_feed/models/Article.dart';
import 'package:news_feed/models/NewsHolder.dart';
import 'package:news_feed/screens/NewsDetail.dart';
import 'package:provider/provider.dart';

class NewsFeedContainer extends StatelessWidget {
  String title, topic;

  NewsFeedContainer(this.title, this.topic);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<NewsBloc>(context);
    return StreamBuilder<List<Article>>(
      stream: bloc.articles,
      builder: (context, AsyncSnapshot<List<Article>> snapshot) {
        if (!snapshot.hasData || snapshot.data.isEmpty)
          return CircularProgressIndicator();
        else
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, position) {
                return GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, NewsDetail.route,
                            arguments: snapshot.data[position]),
                    child: NewsElement(article: snapshot.data[position]));
              });
      },
    );
  }
}