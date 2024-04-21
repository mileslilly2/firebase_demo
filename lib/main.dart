import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/authentication_screen.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

// Entry point of the application



Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    GoogleProvider(clientId: 'AIzaSyBrZ037rmKXF2s1OYC89iHas6WygDsMg2w'),
  ]);

  FirebaseMessaging.onBackgroundMessage(
    _firebaseBackGroundMessageReceived);
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: AuthenticationScreen(),
    );
  }


}

  Future<void> _firebaseBackGroundMessageReceived(
      RemoteMessage message) async {
     print('Notification received in background: ${message.notification?.title}');
     print('Notification received in background: ${message.notification?.body}');
  }
