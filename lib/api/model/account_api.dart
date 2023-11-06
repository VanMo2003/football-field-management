class AccountAPI {
  String email;
  String password;
  bool? permission = false;

  AccountAPI({required this.email, required this.password, this.permission});

  factory AccountAPI.fromJson(Map<String, dynamic> json) {
    return AccountAPI(
      email: json['email'],
      password: json['password'],
      permission: json['permission'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['password'] = password;
    data['permission'] = permission;
    return data;
  }
}
