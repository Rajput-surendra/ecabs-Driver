import 'package:flutter/material.dart';

class RowItem extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final IconData icon;

  RowItem(this.title, this.subtitle, this.icon);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: theme.textTheme.headline6!
                .copyWith(color: theme.hintColor, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(icon, color: theme.primaryColor),
              SizedBox(width: 10),
              Text(
                subtitle!,
                style: theme.textTheme.headline6!.copyWith(fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
