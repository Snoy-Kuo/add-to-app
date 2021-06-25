import 'package:flutter/material.dart';
import 'package:flutter_module/flutter_module.dart';
import '../l10n/l10n.dart';

class QuotDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final QuotItem item =
        ModalRoute.of(context)?.settings.arguments as QuotItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Container(
        child: Center(
          child: Text(L10n.of(context)!.thisIsQuotDetailWidget(item.id)),
        ),
      ),
    );
  }
}
