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
          RuleW(
            law: dummy_rule,
          ),
          RuleW(
            law: dummy_rule,
          ),
          RuleW(
            law: dummy_rule,
          ),
          RuleW(
            law: dummy_rule,
          ),
          RuleW(
            law: dummy_rule,
          ),

        ],
      ),
    );
  }
}

class RuleW extends StatelessWidget {
  final Law law;
  RuleW({this.law});

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
                  "LAW #${law.id.toString()}",
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
                "${law.content.type.toLowerCase().replaceAll("_", " ")}: dan",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 5,),
            ExpansionTile(title: Text("details"),children: [
              ContentW(law)
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
          law.content.type.toLowerCase().replaceAll("_", " "),
          style: TextStyle(color: typeColor),
        ),
        SizedBox(
          width: 5,
        )
      ],
    ));
  }
}
class ContentW extends StatelessWidget {
  final Law law;
  ContentW(this.law);
  @override
  Widget build(BuildContext context) {
    switch (this.law.content.type) {
      case "ADD_MEMBER":
        return _member(law.content);
        break;
      default:
      return Container(child: Text("nothing here...."),);
    }
  }
  Widget _member(ContentAddMember content){
    return Table(columnWidths: <int,TableColumnWidth> {
      0: FlexColumnWidth(0.4),
      1: FlexColumnWidth(0.8)
    },
    children: [
      TableRow(children: [
        Container(child: _row_head("Legislator".toUpperCase()),padding: EdgeInsets.all(3)),
        Container(child: _table_content(this.law.legislator.name),padding: EdgeInsets.all(3)),
      ]),
      TableRow(children: [
        Container(child: _row_head("Date".toUpperCase()),padding: EdgeInsets.all(3),),
        Container(child: _table_content( DateFormat("yyyy/mm/dd kk:mm").format(this.law.timeStamp)),padding: EdgeInsets.all(3)),
      ]),
      TableRow(children: [
        Container(child: _row_head("Votes".toUpperCase()),padding: EdgeInsets.all(3),),
        Container(child: _table_content(""),padding: EdgeInsets.all(3)),
      ]),
      TableRow(children: [
        Container(child: _row_head("status".toUpperCase()),padding: EdgeInsets.all(3),),
        Container(child: _table_content(law.status.toLowerCase().replaceAll("_", " ")),padding: EdgeInsets.all(3)),

      ]),
      TableRow(children: [
        Container(child: _row_head("results in".toUpperCase()),padding: EdgeInsets.all(3),),
        Container(child: CountdownTimer(widgetBuilder: (context, time) {
          if(time == null) return Text("time has passed");
          return _table_content("${time.hours}h ${time.min}m ${time.sec}s");
        } ,endTime: law.timeStamp.add(Duration(days: 1)).millisecondsSinceEpoch),padding: EdgeInsets.all(3)),
      ]),
    ],);

  }
  Widget _row_head(String text){
    return Text(text,style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w400,fontSize: 17),);
  }
  Widget _table_content(String text){
    return Text(text,style:  TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 17),);
  }
}

