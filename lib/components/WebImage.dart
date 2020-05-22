import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cached_network_image/cached_network_image.dart' hide kIsWeb;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WebImage extends StatelessWidget {
  String url;
  double height, radius;

  WebImage({@required this.url, @required this.height, @required this.radius});

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      if (!kIsWeb) {
        return CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius)),
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill)),
          ),
          placeholder: (context, url) => Center(
            child: Padding(
                padding: EdgeInsets.all(height / 2),
                child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) => Padding(
            padding: EdgeInsets.all(height / 2),
            child: Icon(Icons.image),
          ),
          fadeInCurve: Curves.bounceIn,
        );
      } else {
        return Padding(
          padding: EdgeInsets.all(height / 2),
          child: Icon(
            Icons.image,
            color: Theme.of(context).iconTheme.color,
          ),
        );
      }
    } else
      return Image.network(url);
  }
}
