class UserModel {
  String? id;
  String? email;
  bool? emailVerified;
  bool? banned;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.email,
      this.emailVerified,
      this.banned,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['_id'];
      email = json['email'];
      emailVerified = json['emailVerified'];
      banned = json['banned'];
      createdAt = json['createdAt'];
      updatedAt = json['updatedAt'];
    } catch (e) {
      // print("User Model");
      // print(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // id no, ya va en la request
    data['email'] = email;
    // emailVerified no
    // createdAt no
    // updatedAt no

    return data;
  }

  String getDisplayName() {
    return email == null ? "" : email!.substring(0, email!.indexOf("@"));
  }
}
