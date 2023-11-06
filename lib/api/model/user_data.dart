class UserData {
  int? numberYard;
  int? timeSlot;

  UserData({this.numberYard, this.timeSlot});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      numberYard: json['numberYard'],
      timeSlot: json['timeSlot'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['numberYard'] = numberYard;
    data['timeSlot'] = timeSlot;
    return data;
  }
}
