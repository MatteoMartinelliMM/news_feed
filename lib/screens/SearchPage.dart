import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/components/NewsElement.dart';
import 'package:news_feed/model/Article.dart';
import 'package:provider/provider.dart';

import '../NewsBloc.dart';
import 'NewsDetail.dart';

class SearchPage extends StatefulWidget {
  static const String route = '/SearchPage';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FocusNode _focusNode;

  TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<NewsBloc>(context);
    return new Scaffold(
        appBar: AppBar(
            title: TextField(
          style: TextStyle(color: Colors.white),
          focusNode: _focusNode,
          controller: _controller,
          onEditingComplete: () => bloc.fetchSearchArticles(_controller.text),
          autofocus: true,
          decoration: InputDecoration(border: InputBorder.none),
        )),
        body: StreamBuilder<List<Article>>(
          stream: bloc.searchArticles,
          builder: (context, AsyncSnapshot<List<Article>> snapshot) {
            if (!snapshot.hasData)
              return Container();
            else if (!snapshot.data.isEmpty)
              return !kIsWeb
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, position) {
                        return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, NewsDetail.route,
                                arguments: snapshot.data[position]),
                            child:
                                NewsElement(article: snapshot.data[position]));
                      })
                  : GridView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, position) {
                        return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, NewsDetail.route,
                                arguments: snapshot.data[position]),
                            child:
                                NewsElement(article: snapshot.data[position]));
                      });
            else
              return Center(
                  child: Column(
                children: <Widget>[
                  Icon(Icons.error, color: Colors.black12),
                  Text(
                    "Non sono presenti articoli per la ricerca effettuata",
                    style: TextStyle(color: Colors.black12, fontSize: 14),
                  )
                ],
              ));
          },
        ));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    Provider.of<NewsBloc>(context).dispose();
    super.dispose();
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.requestFocus();
    _controller = TextEditingController();
  }
}
