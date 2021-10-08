// ignore_for_file: avoid_unnecessary_containers

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Tracker extends StatefulWidget {
  @override
  State<Tracker> createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  TextEditingController _date;

  TextEditingController _rounds;

  DatabaseReference _ref;

  @override
  void initState() {
    super.initState();
    _date = TextEditingController();
    _rounds = TextEditingController();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('${FirebaseAuth.instance.currentUser.displayName}')
        .child('${_date.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Text(
                'Hare Krishna ${FirebaseAuth.instance.currentUser.displayName}',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              child: Image.network(
                'https://raw.githubusercontent.com/mail2sree/hkm/master/MY-100.jpeg',
              ),
            ),
            Container(
              child: Text(
                'Japa Tracker',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              child: TextField(
                controller: _date,
                decoration: InputDecoration(hintText: '      Date'),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextField(
                controller: _rounds,
                decoration: InputDecoration(hintText: '      Rounds'),
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(onPressed: saveRounds, child: Text('Submit'))
          ],
        ),
      ),
    );
  }

  void saveRounds() {
    String date = _date.text;
    String rounds = _rounds.text;
    Map<String, String> round = {
      'date': date,
      'rounds': rounds,
    };
    _ref.push().set(round);
  }
}
