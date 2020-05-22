import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class FullArticeWV extends StatelessWidget {
  static const String route = '/NewsDetail/FullArticleWV';

  @override
  Widget build(BuildContext context) {
    String url = ModalRoute.of(context).settings.arguments;
    return WebviewScaffold(
      url: url,
      mediaPlaybackRequiresUserGesture: false,
      withLocalStorage: true,
      hidden: true,
      initialChild: Center(child: CircularProgressIndicator()),
    );
  }
}
