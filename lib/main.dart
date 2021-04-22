import 'package:democracy_sim/Widgets/Law/LawWidget.dart';
import 'package:democracy_sim/models/rule.dart';
import 'package:democracy_sim/services/push_notifications.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Page(body: Text("has error"));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}

class Page extends StatelessWidget {
  final Widget body;
  Page({@required this.body});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: this.body,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData.light(),
    );
  }
}

class HomePage extends StatelessWidget {
  PushNotificationsManager pushManager;
  HomePage() {
    pushManager = PushNotificationsManager();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("example rule list"),
      ),  
      body: ListView(
        children: [
          LawWidget(law: dummy_rule),
          LawWidget(law: dummy_rule),
          LawWidget(law: dummy_rule),
          LawWidget(law: dummy_rule),
          LawWidget(law: dummy_rule),
          
          

        ],
      ),
    );
  }
}
