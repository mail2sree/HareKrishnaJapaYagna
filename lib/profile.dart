import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  ScrollController _scrollController;
  var top = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        CustomScrollView(controller: _scrollController, slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: userTitle('Hare Krishna Guest')),
                Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: userTitle('User Bag')),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Theme.of(context).splashColor,
                    child: ListTile(
                      onTap: () {},
                      title: Text('Whishlist'),
                      leading: Icon(Icons.card_giftcard_sharp),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Theme.of(context).splashColor,
                    child: ListTile(
                      onTap: () => {},
                      title: Text('Cart'),
                      leading: Icon(Icons.shopping_bag_rounded),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: userTitle('User Information')),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                userListFile('Email', 'Email Sub', 0, context),
                userListFile('Phone Number', '4555', 1, context),
                userListFile(
                    'Shipping Address', 'Shipping Address', 2, context),
                userListFile('Joined Date', 'date', 3, context),
                Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: userTitle('User Settings')),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                userListFile('Logout', '', 4, context),
              ],
            ),
          ),
        ]),
      ]),
    );
  }

  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 200.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 160.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down

        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down

        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          heroTag: "btn1",
          onPressed: () {},
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  List<IconData> _userTileIcons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app_rounded
  ];

  Widget userListFile(
      String title, String subtitle, int index, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap: () {},
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(_userTileIcons[index]),
        ),
      ),
    );
  }

  Widget userTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }
}
