import 'package:democracy_sim/models/rule.dart';
import 'package:democracy_sim/services/push_notifications.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

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
          RuleW(
            rule: dummy_rule,
          ),
          RuleW(
            rule: dummy_rule,
          ),
          RuleW(
            rule: dummy_rule,
          ),
          RuleW(
            rule: dummy_rule,
          ),
          RuleW(
            rule: dummy_rule,
          ),

        ],
      ),
    );
  }
}

class RuleW extends StatelessWidget {
  final Law rule;
  RuleW({this.rule});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "LAW #${rule.id.toString()}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500]),
                ),
                getLawType()
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "${rule.content.type.toLowerCase().replaceAll("_", " ")}: dan",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 5,),
            ExpansionTile(title: Text("details"),children: [

            ],)
          ],
        ),
      ),
    );
  }

  Widget getLawType() {
    Color typeColor = Color(0xD3863E00);
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.person, color: typeColor),
        SizedBox(
          width: 5,
        ),
        Text(
          rule.content.type.toLowerCase().replaceAll("_", " "),
          style: TextStyle(color: typeColor),
        ),
        SizedBox(
          width: 5,
        )
      ],
    ));
  }
}
