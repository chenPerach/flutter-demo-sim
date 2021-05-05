class Member {
  String id, name, phone, token;
  bool president, registered;
  DateTime joined;
  Member(
      {this.id,
      this.name,
      this.phone,
      this.token,
      this.president,
      this.joined,
      this.registered});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        token: json["token"],
        president: json["president"],
        joined: DateTime.parse(json["joined"]),
        registered: json["registered"]);
  }
}