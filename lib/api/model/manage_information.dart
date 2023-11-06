class ManageInformationAPI {
  String email;
  bool permission;
  String nameFootballField;
  String nameManage;
  int totalYards;

  ManageInformationAPI({
    required this.email,
    required this.permission,
    required this.nameFootballField,
    required this.nameManage,
    required this.totalYards,
  });

  factory ManageInformationAPI.fromJson(Map<String, dynamic> json) {
    return ManageInformationAPI(
      email: json['email'],
      permission: json['permission'],
      nameFootballField: json['nameFootballField'],
      nameManage: json['nameManage'],
      totalYards: json['totalYards'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['permission'] = permission;
    data['nameFootballField'] = nameFootballField;
    data['nameManage'] = nameManage;
    data['totalYards'] = totalYards;
    return data;
  }
}
