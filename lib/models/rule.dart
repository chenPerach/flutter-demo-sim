import 'package:flutter/cupertino.dart';

class Law{
  int id;
  Member legislator;
  String status;
  DateTime timeStamp;
  bool constitutional,anonymousLegislator;
  Content content;
  Law({this.id,this.legislator,this.status,this.timeStamp,this.anonymousLegislator,this.constitutional,this.content});

  factory Law.fromJson(Map<String,dynamic> json){
    return Law(
      id: json["id"],
      legislator: Member.fromJson(json["legislator"]),
      status: json["status"],
      timeStamp: DateTime.parse(json["timestamp"]),
      content: Content.fromJson(json["content"]),
      constitutional: json["constitutional"],
      anonymousLegislator: json["constitutional"]
    );
  }
}
class Member{
  int id;
  String name,phone,token;
  bool president,registered;
  DateTime joined;
  Member({this.id,this.name,this.phone,this.token,this.president,this.joined,this.registered});
  
  factory Member.fromJson(Map<String,dynamic> json){
    return Member(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      token: json["token"],
      president: json["president"],
      joined: DateTime.parse(json["joined"]),
      registered: json["registered"]
    );
  }
}
abstract class Content{
  int id;
  String type;
  String legislator;
  Content({@required this.id,@required this.type,@required this.legislator});
  factory Content.fromJson(Map<String,dynamic> json){
    switch (json["type"]) {
      case "ADD_MEMBER":
        return ContentAddMember.fromJson(json);
        break;
      default:
        return null;
    }
  }
}

class ContentAddMember extends Content{
  Member member;
  String reason;
  ContentAddMember({ this.reason,@required this.member,@required int id,@required String legislator}):
    super(id: id,type: "ADD_MEMBER",legislator: legislator);
  factory ContentAddMember.fromJson(Map<String,dynamic> json){
    return ContentAddMember(
      member: Member.fromJson(json["member"]),
      id: json["id"],
      reason: json["reason"]      
    );
  }
}

Map<String,dynamic> dummy = {
    "id": 3,
    "legislator": {
        "id": 3,
        "name": "חן פרח",
        "phone": "972544805273",
        "token": null,
        "president": false,
        "registered": false,
        "joined": "2021-04-17T22:33:01.967+00:00"
    },
    "content": {
        "id": 2,
        "type": "ADD_MEMBER",
        "member": {
            "id": 3,
            "name": "חן פרח",
            "phone": "972544805273",
            "token": null,
            "president": false,
            "registered": false,
            "joined": "2021-04-17T22:33:01.967+00:00"
        },
        "reason": "אני חן ואני מגניב"
    },
    "status": "UNDER_VOTE",
    "timestamp": "2021-04-22T22:33:02.018+00:00",
    "constitutional": false,
    "anonymousLegislator": false
};
Law dummy_rule = Law.fromJson(dummy);