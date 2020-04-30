class Admin {
  int adminID;
  String email;
  String password;

  Admin(this.email, this.password);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["Aemail"] = email;
    map["Apassword"] = password;

    if (adminID != null) {
      map["Aid"] = adminID;
    }
    return map;
  }

  Admin.fromMap(Map<String, dynamic> map) {
    this.adminID = map["Aid"];
    this.email = map["Aemail"];
    this.password = map["Apassword"];
  }
}
