import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harekrishnajapayagna/home.dart';

class Profile extends StatelessWidget {
  ScrollController _scrollController;
  var top = 0.0;
  TextEditingController _name = TextEditingController();
  TextEditingController _profileurl = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    void _save() {
      var name = _name.text;
      var profileurl = _profileurl.text;
      var email = _email.text;
      var password = _password.text;
      FirebaseAuth.instance.currentUser.updateDisplayName(name);
      FirebaseAuth.instance.currentUser.updatePhotoURL(profileurl);
      FirebaseAuth.instance.currentUser.updateEmail(email);
      FirebaseAuth.instance.currentUser.updatePassword(password);
      FirebaseAuth.instance.currentUser.reload();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Tracker()),
      );
    }

    return Scaffold(
      body: Stack(children: [
        CustomScrollView(controller: _scrollController, slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: userTitle(
                        'Hare Krishna ${FirebaseAuth.instance.currentUser.phoneNumber}')),
                Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: userTitle('User Information')),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                TextField(
                  controller: _name,
                  decoration: InputDecoration(hintText: '        Name'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _profileurl,
                  decoration:
                      InputDecoration(hintText: '        Profile Image URL'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(hintText: '        Email'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _password,
                  decoration: InputDecoration(hintText: '        Password'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: _save, child: Text('Update')),
                Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: userTitle('User Settings')),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                userListFile('Logout', '', 4, context, logout),
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

  Widget userListFile(String title, String subtitle, int index,
      BuildContext context, Function function) {
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
