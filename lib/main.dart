import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_feed/NewsBloc.dart';
import 'package:news_feed/screens/FullArticleWV.dart';
import 'package:news_feed/screens/NewsDetail.dart';
import 'package:news_feed/screens/NewsFeedContainer.dart';
import 'package:news_feed/screens/SearchPage.dart';
import 'package:news_feed/services/DbRepository.dart';
import 'package:provider/provider.dart';

import 'model/Article.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());
  await Hive.openBox<Article>(NewsBox);
  //Register the type adapter
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        Provider<NewsBloc>(
          create: (_) => NewsBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Theme.of(context).brightness,
        ),
        home: HomeNews(title: 'News'),
        initialRoute: '/',
        routes: {
          NewsDetail.route: (context) => NewsDetail(),
          FullArticeWV.route: (context) => FullArticeWV(),
          SearchPage.route: (context) => SearchPage()
        },
      ),
    );
  }
}

class HomeNews extends StatefulWidget {
  HomeNews({Key key, this.title}) : super(key: key);
  String title;

  @override
  _HomeNewsState createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews>
    with SingleTickerProviderStateMixin {
  int mIndex;
  List<String> topic = new List();
  TabController _tabController;

  @override
  void initState() {
    mIndex = 0;
    _tabController =
        new TabController(length: Categories.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mIndex == 0 ? 100 : kToolbarHeight),
        child: AppBar(
          centerTitle: true,
          leading: mIndex == 0
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () =>
                      Navigator.pushNamed(context, SearchPage.route))
              : null,
          title: Text(widget.title),
          bottom: mIndex == 0
              ? TabBar(
                  onTap: updateNewsFeedPage,
                  isScrollable: true,
                  tabs: buildTabs(),
                  controller: _tabController,
                )
              : null,
        ),
      ),
      body: Center(child: buildPage(mIndex)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: mIndex,
        onTap: goToPage,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.public), title: const Text('News')),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border), title: const Text('Favoriti'))
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void goToPage(int index) {
    final bloc = Provider.of<NewsBloc>(context, listen: false);
    bloc.changeScreen(index);
    setState(() {
      mIndex = index;
      widget.title = mIndex == 0 ? 'News' : 'Favoriti';
    });
  }

  Widget buildPage(int mIndex) {
    return NewsFeedContainer(widget.title);
  }

  List<Widget> buildTabs() {
    List<Tab> topicsTab = new List();
    Categories.values.forEach((e) => topicsTab.add(new Tab(
        text: StringUtils.capitalize(
            e.toString().substring(e.toString().indexOf('.') + 1)))));
    return topicsTab;
  }

  void updateNewsFeedPage(int value) {
    if (_tabController.indexIsChanging) {
      final bloc = Provider.of<NewsBloc>(context, listen: false);
      bloc.changeCategory(_tabController.index);
    }
  }
}
