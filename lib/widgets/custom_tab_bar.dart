import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomTabBar({Key key, this.icons, this.selectedIndex, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.blue, width: 3.0))),
      tabs: icons
          .asMap()
          .map((i, e) => MapEntry(
                i,
                Tab(
                  icon: Icon(e, color: i==selectedIndex ? Colors.blue : Colors.black45,),
                ),
              ))
          .values
          .toList(),
      onTap: onTap,
    );
  }
}
