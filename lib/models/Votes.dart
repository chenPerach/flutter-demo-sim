import 'package:democracy_sim/models/Member.dart';

class Vote {
  int id;
  Member voter;
  String vote, reason;
  Vote({this.id, this.voter, this.reason, this.vote});

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
        id: json["id"],
        vote: json["vote"],
        voter: Member.fromJson(json["voter"]),
        reason: json["reason"]);
  }
}

class Votes {
  List<Vote> votes;
  Votes({this.votes});
  factory Votes.formJson(List<Map<String, dynamic>> json) {
    List<Vote> l;
    json.forEach((element) => l.add(Vote.fromJson(element)));
    return Votes(votes: l);
  }
}
