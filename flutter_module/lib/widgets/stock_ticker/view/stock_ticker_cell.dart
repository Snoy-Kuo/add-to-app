import 'package:flutter/material.dart';
import 'package:flutter_module/widgets/stock_ticker/model/quot_item.dart';

class StockTickerCell extends StatelessWidget {
  final QuotItem? item;
  final Function(QuotItem? item)? onItemClick;

  StockTickerCell({this.item, this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onItemClick != null) onItemClick!(item);
      },
      child: Container(
        margin: EdgeInsets.only(top: 15, bottom: 12, left: 8, right: 8),
        child: Center(
          child: Text('${item?.price ?? ''}\n${item?.name ?? ''}',
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center),
        ),
        decoration: (item == null)
            ? null
            : BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
      ),
    );
  }
}
