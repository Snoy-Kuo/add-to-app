import 'package:flutter/material.dart';

class MenuCell extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final Function()? onItemClick;

  MenuCell({this.icon, this.label, this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onItemClick != null) onItemClick!();
      },
      child: Container(
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).backgroundColor),
              child: Icon(
                icon,
                color: Theme.of(context).indicatorColor,
                size: 23,
                semanticLabel: label ?? '',
              ),
            ),
            SizedBox(height: 5),
            Text(
              label ?? '',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
