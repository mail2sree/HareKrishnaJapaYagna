// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Tracker extends StatelessWidget {
  const Tracker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                decoration: InputDecoration(hintText: '      Date'),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(hintText: '      Rounds'),
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Submit'))
          ],
        ),
      ),
    );
  }
}
