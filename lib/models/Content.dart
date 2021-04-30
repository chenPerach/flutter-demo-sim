import 'package:democracy_sim/models/Member.dart';
import 'package:flutter/cupertino.dart';

abstract class Content {
  int id;
  String type;
  String legislator;
  Content({@required this.id, @required this.type, @required this.legislator});
  factory Content.fromJson(Map<String, dynamic> json) {
    switch (json["type"]) {
      case "ADD_MEMBER":
        return ContentAddMember.fromJson(json);
        break;
      default:
        return null;
    }
  }
}


class ContentAddMember extends Content {
  Member member;
  String reason;
  ContentAddMember(
      {this.reason,
      @required this.member,
      @required int id,
      @required String legislator})
      : super(id: id, type: "ADD_MEMBER", legislator: legislator);
  factory ContentAddMember.fromJson(Map<String, dynamic> json) {
    return ContentAddMember(
        member: Member.fromJson(json["member"]),
        id: json["id"],
        reason: json["reason"]);
  }
}