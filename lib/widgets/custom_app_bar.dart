import 'package:flutter/material.dart';
import 'package:harekrishnajapayagna/widgets/custom_tab_bar.dart';

class CustomAppBar extends StatelessWidget {
  final List<IconData> icon;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomAppBar({Key key, this.icon, this.selectedIndex, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 65.0,
      decoration: BoxDecoration(color: Colors.white, boxShadow: const [
        BoxShadow(color: Colors.black12, offset: Offset(0, 2), blurRadius: 4.0)
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text('HKMBooks',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.2)),
          ),
          Container(
            height: double.infinity,
            width: 600.0,
            child: CustomTabBar(
              icons: icon,
              selectedIndex: selectedIndex,
              onTap: onTap,
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                width: 12.0,
              ),
              Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                    iconSize: 30.0,
                    color: Colors.black,
                  )),
              Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.person),
                    iconSize: 30.0,
                    color: Colors.black,
                  )),
            ],
          ))
        ],
      ),
    );
  }
}
