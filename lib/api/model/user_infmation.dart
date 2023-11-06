class UserInformationAPI {
  String? email;
  bool? permission;
  String? nameUser;
  String? phoneNumber;

  UserInformationAPI(
      {this.email, this.permission, this.nameUser, this.phoneNumber});

  factory UserInformationAPI.fromJson(Map<String, dynamic> json) {
    return UserInformationAPI(
      email: json['email'],
      permission: json['permission'],
      nameUser: json['nameUser'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['permission'] = permission;
    data['nameUser'] = nameUser;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
