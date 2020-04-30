class Traveler {
  int alID;
  String email;
  String password;
  String name;
  String language;

  Traveler(this.email, this.password, this.name, this.language);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["Alemail"] = email;
    map["Alpassword"] = password;
    map["Alname"] = name;
    map["AlLang"] = language;

    if (alID != null) {
      map["Alid"] = alID;
    }
    return map;
  }

  Traveler.fromMap(Map<String, dynamic> map) {
    this.alID = map["Alid"];
    this.email = map["Alemail"];
    this.password = map["Alpassword"];
    this.name = map["Alname"];
    this.language = map["AlLang"];
  }
  void travelerfromList(List<Map<String, dynamic>> travelers) {
    Map traveler = travelers[0];
    Traveler.fromMap(traveler);
  }
}
