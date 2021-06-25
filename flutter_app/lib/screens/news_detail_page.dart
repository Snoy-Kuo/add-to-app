import 'package:flutter/material.dart';
import 'package:flutter_module/flutter_module.dart';
import '../l10n/l10n.dart';

class NewsDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NewsItem item =
        ModalRoute.of(context)?.settings.arguments as NewsItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Container(
        child: Center(
          child: Text( L10n.of(context)!.thisIsNewsDetailWidget(item.id)),
        ),
      ),
    );
  }
}
