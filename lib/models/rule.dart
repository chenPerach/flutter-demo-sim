import 'package:democracy_sim/models/Content.dart';
import 'package:democracy_sim/models/Member.dart';
import 'package:democracy_sim/models/Votes.dart';

class Law {
  String id;
  Member legislator;
  String status;
  DateTime timeStamp;
  bool constitutional, anonymousLegislator;
  Content content;
  Votes votes;
  Law(
      {this.id,
      this.legislator,
      this.status,
      this.timeStamp,
      this.anonymousLegislator,
      this.constitutional,
      this.content,
      this.votes});

  factory Law.fromJson(Map<String, dynamic> json) {
    return Law(
        id: json["id"],
        legislator: Member.fromJson(json["legislator"]),
        status: json["status"],
        timeStamp: DateTime.parse(json["timestamp"]),
        constitutional: json["constitutional"],
        anonymousLegislator: json["constitutional"],
        votes: Votes.formJson(json["votes"]),
        content: Content.fromJson(json["content"]));
  }
}

Map<String, dynamic> dummy = {
  "id": "1",
  "legislator": {
    "id": "2",
    "name": "Amit Nave",
    "phone": "972544805278",
    "president": false,
    "registered": true,
    "joined": "2021-04-22T19:52:23.019+00:00"
  },
  "type":"FACT",
  "content": {"id": 3, "type": "FACT", "description": "שרבי השמין"},
  "votes": [
    {
      "id": 1,
      "voter": {
        "id": 2,
        "name": "Amit Nave",
        "phone": "972544805278",
        "president": false,
        "registered": true,
        "joined": "2021-04-22T19:52:23.019+00:00"
      },
      "vote": "FOR",
      "reason": "אחלה חוק ראשון"
    },{
      "id": 1,
      "voter": {
        "id": 2,
        "name": "Amit Nave",
        "phone": "972544805278",
        "president": false,
        "registered": true,
        "joined": "2021-04-22T19:52:23.019+00:00"
      },
      "vote": "AGAINST",
      "reason": "אחלה חוק ראשון"
    },
    {
      "id": 1,
      "voter": {
        "id": 2,
        "name": "Dan binnun",
        "phone": "972544805278",
        "president": false,
        "registered": true,
        "joined": "2021-04-22T19:52:23.019+00:00"
      },
      "vote": "FOR",
      "reason": "תרבותי"
    },
    {
      "id": 1,
      "voter": {
        "id": 2,
        "name": "Sharabi",
        "phone": "972544805278",
        "president": false,
        "registered": true,
        "joined": "2021-04-22T19:52:23.019+00:00"
      },
      "vote": "ABSTAIN",
      "reason": "ביקורת בונה"
    }
  ],
  "status": "CANCELED",
  "timestamp": "2021-04-22T21:57:34.055+00:00",
  "constitutional": true,
  "anonymousLegislator": false,
  "fakeName": "",
  "contentString": "שרבי השמין"
};
Law dummy_rule = Law.fromJson(dummy);
