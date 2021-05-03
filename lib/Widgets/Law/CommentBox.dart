import 'dart:math';

import 'package:democracy_sim/models/rule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  final Law law;
  Comments({this.law});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: min(40*law.votes.votes.length.toDouble(),125),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: [
                // Container(width: 100,height: 1,color: Colors.grey,),
                Container(width: 100,height: 2,),
                CommentBox(
                  data: law.votes.votes[index].reason,
                  name: law.votes.votes[index].voter.name,
                  vote: law.votes.votes[index].vote,
                ),
                Container(width: 100,height: 2,),
                // Container(width: 100,height: 1,color: Colors.grey,),
              ],
            ),
          );
        },
        itemCount: law.votes.votes.length,
      ),
    );
  }
}

class CommentBox extends StatelessWidget {
  final String name, data, vote;
  CommentBox({this.data, this.name, this.vote});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _iconByVote(),
          Container(width: 10,height: 5,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
              ),
              SizedBox(height: 1,),
              Text(data.length > 40 ? data.substring(0, 40) + "..." : data)
            ],
          )
        ],
      ),
    );
  }

  Icon _iconByVote() {
    switch (vote) {
      case "AGAINST":
        return Icon(Icons.thumb_down,color: Colors.red,);
      case "FOR":
        return Icon(Icons.thumb_up,color: Colors.green);
      case "ABSTAIN":
        return Icon( Icons.thumbs_up_down,color:Colors.purple) ;

      default:
    }
  }
}
