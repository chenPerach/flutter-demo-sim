import 'package:democracy_sim/models/Member.dart';
import 'package:flutter/cupertino.dart';

abstract class Content {
  int id;
  String type;
  // Member legislator;
  Content({@required this.id, @required this.type});
  factory Content.fromJson(Map<String, dynamic> json) {
    print("here2");
    switch (json["type"]) {
      case "ADD_MEMBER":
        print("creating member contnet");
        return ContentAddMember.fromJson(json);
        break;
      case "FACT":
        print("creating fact contnet");
        return ContentFact.fromJson(json);
        break;
      default:
        return null;
    }
  }
}

class ContentFact extends Content {
  String description;
  ContentFact(
      {@required this.description,
      @required int id})
      : super(id: id, type: "FACT");
  factory ContentFact.fromJson(Map<String, dynamic> json) {
    return ContentFact(
        description: json["description"],
        id: json["id"],
        );
  }
}
class ContentAddMember extends Content {
  Member member;
  String reason;
  ContentAddMember(
      {this.reason,
      @required this.member,
      @required int id})
      : super(id: id, type: "ADD_MEMBER");
  factory ContentAddMember.fromJson(Map<String, dynamic> json) {
    return ContentAddMember(
        member: Member.fromJson(json["member"]),
        id: json["id"],
        reason: json["reason"],
        );
  }
}