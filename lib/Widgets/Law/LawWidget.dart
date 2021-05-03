import 'dart:math';

import 'package:democracy_sim/Widgets/Law/CommentBox.dart';
import 'package:democracy_sim/models/Content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:democracy_sim/models/rule.dart';
import 'package:intl/intl.dart';
class LawWidget extends StatelessWidget {
  final Law law;
  LawWidget({this.law});

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
                "${_getContentDescription()}",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 5,),
            ExpansionTile(title: Text("Details"),children: [
              _LawDetailTable(law: law)
            ],)
          ],
        ),
      ),
    );
  }
  IconData _getIcon(String type){
    switch (type) {
      case "FACT":
        return Icons.fact_check;
        break;
      case "ADD_MEMBER":
        return Icons.person;
        break;
      default:
    }
  }
  Widget getLawType() {
    Color typeColor = Color(0xD3863E00);
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(_getIcon(law.content.type), color: typeColor),
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

  String _getContentDescription(){
    switch (law.content.type) {
      case "FACT":
        return (law.content as ContentFact).description;
        break;
        case "ADD_MEMBER":
        return "add ${(law.content as ContentAddMember).member.name}";
      default:
        return "";
    }
  }
}

class _LawDetailTable extends StatelessWidget {
  final Law law;
  _LawDetailTable({this.law});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(columnWidths: <int,TableColumnWidth> {
          0: FlexColumnWidth(0.4),
          1: FlexColumnWidth(0.8)
        },
        children: [
          _TableRow(content: _MyContainer(child: _content(law.legislator.name)),title: "Legislator".toUpperCase()).get(),
          _TableRow(content: _MyContainer(child: _content(DateFormat("yyyy/mm/dd kk:mm").format(law.timeStamp))),title: "Date".toUpperCase()).get(),
          _TableRow(content: _MyContainer(child:  Comments(law: law)),title: "Votes".toUpperCase()).get(),
          _TableRow(content: _MyContainer(child: _content(law.status.toLowerCase().replaceAll("_"," "))),title: "Status".toUpperCase()).get(),
          _TableRow(content: _MyContainer(child: CountdownTimer(endTime: law.timeStamp.add(Duration(days: 1)).microsecondsSinceEpoch,widgetBuilder: (context, time) {
                  if(time == null) return Text("ended");
                  return _content("${time.hours}h ${time.min}m ${time.sec}s");
                },)),title: "Ends in".toUpperCase()).get(),
        ],
        ),
        SizedBox(height: 3,)
      ],
    );
  }
  Widget _content(String text){
    return Text(text,style:  TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 17),);
  }

}

class _TableRow {
  final String title;
  final Widget content;
  _TableRow({this.content,this.title});
  
  TableRow get() {
    return TableRow(
      children: [
        _myContainer(_head(title)),
        _myContainer(content)
      ]
    );
  }
  Widget _myContainer(Widget child){
    return Container(child: child,padding: EdgeInsets.all(3));
  }
  Widget _head(String text){
    return Text(text,style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w400,fontSize: 17),);
  }
  Widget _content(String text){
    return Text(text,style:  TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 17),);
  }
}
class _MyContainer extends StatelessWidget {
  final Widget child;
  _MyContainer({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(child: child,padding: EdgeInsets.all(3));
  }
}
