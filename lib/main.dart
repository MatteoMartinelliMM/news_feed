import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_feed/models/Article.dart';
import 'package:news_feed/screens/NewsDetail.dart';
import 'file:///C:/Users/matteoma/StudioProjects/news_feed/lib/screens/FavouriteNews.dart';
import 'file:///C:/Users/matteoma/StudioProjects/news_feed/lib/screens/NewsFeedContainer.dart';
import 'package:provider/provider.dart';

import 'models/NewsHolder.dart';

void main() async {
  await Hive.initFlutter();

  //Register the type adapter
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return ChangeNotifierProvider(
      create: (context) => NewsHolder(),
      child: Consumer<NewsHolder>(
        builder: (context, provider, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Theme.of(context).brightness,
          ),
          home: HomeNews(title: 'News'),
          initialRoute: '/',
          routes: {
            NewsDetail.route: (context) => NewsDetail(),
          },
        ),
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
    topic = [
      'Ultime notizie',
      'Business',
      'Entertainment',
      'General',
      'Health',
      'Science',
      'Sports',
      'Technology'
    ];
    _tabController = new TabController(length: topic.length, vsync: this);
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
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          leading: mIndex == 0 ? Icon(Icons.search) : null,
          title: Center(child: Text(widget.title)),
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
    setState(() {
      mIndex = index;
      widget.title = mIndex == 0 ? 'News' : 'Favoriti';
    });
  }

  Widget buildPage(int mIndex) {
    return mIndex == 0
        ? NewsFeedContainer(widget.title, topic[_tabController.index])
        : FavouriteNews(widget.title);
  }

  List<Widget> buildTabs() {
    List<Tab> topicsTab = new List();
    topic.forEach((e) => topicsTab.add(new Tab(text: e)));
    return topicsTab;
  }

  void updateNewsFeedPage(int value) {
    goToPage(mIndex);
  }
}
