import 'package:flutter/material.dart';
import '../../../api/model/user_infmation.dart';

class FamilyUser extends InheritedWidget {
  final UserInformationAPI? userInformationAPI;

  const FamilyUser({
    super.key,
    required Widget child,
    this.userInformationAPI,
  }) : super(child: child);

  @override
  bool updateShouldNotify(FamilyUser oldWidget) {
    return userInformationAPI != oldWidget.userInformationAPI;
  }

  static FamilyUser? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FamilyUser>();
  }
}
