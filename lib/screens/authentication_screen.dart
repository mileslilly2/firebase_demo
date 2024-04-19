import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/rendering.dart';
import './happy_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), 
    builder: (context, snapshot) {
      if(!snapshot.hasData) {
        return SignInScreen(
          headerBuilder: (context, constraints, shrinkOffSet) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset('assets/logo.jpg'),
              
            );
          },
        );
      } else {
        return HappyScreen();
      }
    });
  }
}

