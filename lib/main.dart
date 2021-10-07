// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:harekrishnajapayagna/home.dart';
import 'package:harekrishnajapayagna/nav_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hare Krishna Japa Yagna',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Hare Krishna Japa Yagna'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<FirebaseApp> _firebaseApp;
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _otp = TextEditingController();
  TextEditingController _displayName = TextEditingController();

  bool isLoggedIn = false;
  String uid;
  String displayName;
  bool otpSent = false;
  String _verificationId;

  @override
  void initState() {
    super.initState();
    _firebaseApp = Firebase.initializeApp();
  }

  void _verifyOTP() async {
    final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: _otp.text);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (FirebaseAuth.instance.currentUser != null) {
        setState(() {
          isLoggedIn = true;
          uid = FirebaseAuth.instance.currentUser.uid;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _sendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneNumber.text,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: Duration(minutes: 1));
    setState(() {
      otpSent = true;
    });
  }

  void codeAutoRetrievalTimeout(String verificationID) {
    setState(() {
      _verificationId = verificationID;
      otpSent = true;
    });
  }

  void codeSent(String verificationId, [int a]) {
    setState(() {
      _verificationId = verificationId;
      otpSent = true;
    });
  }

  void verificationFailed(FirebaseAuthException exception) {
    print(exception.message);
    setState(() {
      isLoggedIn = false;
      otpSent = false;
    });
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
    if (FirebaseAuth.instance.currentUser != null) {
      setState(() {
        isLoggedIn = true;
        uid = FirebaseAuth.instance.currentUser.uid;
        displayName = FirebaseAuth.instance.currentUser.displayName;
      });
    } else {
      print('Failed to Sign In');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: _firebaseApp,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              return isLoggedIn
                  ? Scaffold(body: NavScreen())
                  : otpSent
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: _otp,
                              decoration: InputDecoration(
                                hintText: "Enter Your OTP",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: _verifyOTP, child: Text('Register'))
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextField(
                              controller: _phoneNumber,
                              decoration: InputDecoration(
                                hintText: "Enter Your Phone Number",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: _sendOTP, child: Text('Send OTP'))
                          ],
                        );
            }),
      ),
    );
  }
}
