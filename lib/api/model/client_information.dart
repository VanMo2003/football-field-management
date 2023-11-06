class ClientInformation {
  String nameFootballField;
  String nameUser;
  String phoneNumber;
  String selectedDay;
  int numberYard;
  int timeSlot;
  double price;

  ClientInformation({
    required this.nameFootballField,
    required this.nameUser,
    required this.phoneNumber,
    required this.selectedDay,
    required this.numberYard,
    required this.timeSlot,
    required this.price,
  });

  factory ClientInformation.fromJson(Map<String, dynamic> json) {
    return ClientInformation(
      nameFootballField: json['nameFootballField'],
      nameUser: json['nameUser'],
      phoneNumber: json['phoneNumber'],
      selectedDay: json['selectedDay'],
      numberYard: json['numberYard'],
      timeSlot: json['timeSlot'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nameFootballField'] = nameFootballField;
    data['nameUser'] = nameUser;
    data['phoneNumber'] = phoneNumber;
    data['selectedDay'] = selectedDay;
    data['numberYard'] = numberYard;
    data['timeSlot'] = timeSlot;
    data['price'] = price;
    return data;
  }
}
