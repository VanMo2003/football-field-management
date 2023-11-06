import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import '../../helper/constants/icons_constants.dart';
import '../../helper/constants/textstyle_constants.dart';
import '../../helper/widgets/background_widget.dart';
import '../../helper/widgets/loading_helper.dart';
import '../../streams/manage_error.dart';
import '../../streams/user_error.dart';
import 'widget_information.dart';

class EnterInformationView extends StatefulWidget {
  const EnterInformationView(
      {super.key, required this.email, required this.permission});
  final bool permission;
  final String email;

  @override
  State<EnterInformationView> createState() => _EnterInformationViewState();
}

class _EnterInformationViewState extends State<EnterInformationView> {
  ManageErrorStreams manageStream = ManageErrorStreams();
  UserErrorStreams userStream = UserErrorStreams();

  final TextEditingController nameManageController = TextEditingController();

  final TextEditingController nameFootballFieldController =
      TextEditingController();

  final TextEditingController totalYardsController = TextEditingController();

  final TextEditingController nameUserController = TextEditingController();

  final TextEditingController numberPhoneController = TextEditingController();

  RxBool isClickText = false.obs;

  final _keyForm = GlobalKey<FormState>();

  RxBool isLoading = false.obs;

  @override
  void dispose() {
    super.dispose();
    manageStream.dispose();
    userStream.dispose();
    nameManageController.dispose();
    nameFootballFieldController.dispose();
    totalYardsController.dispose();
    nameUserController.dispose();
    numberPhoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _keyForm,
        child: Stack(
          children: [
            Scaffold(
              body: BackgroundWidget(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(IconsConstants.iconLogin),
                      const Text(
                        'Nhập Thông Tin',
                        style: TextStyleConstants.textLoginStyle,
                      ),
                      Text(widget.permission ? 'chủ sân' : 'người dùng'),
                      const SizedBox(height: 20),
                      if (widget.permission) ...[
                        EnterInformationWidget.manage(
                          manageStream,
                          nameManageController,
                          nameFootballFieldController,
                          totalYardsController,
                          () {
                            ControllerApp.clickButtonInformationManage(
                              context,
                              widget.email,
                              nameManageController.text,
                              nameFootballFieldController.text,
                              totalYardsController.text,
                              manageStream,
                              widget.permission,
                              isLoading,
                            );
                          },
                        ),
                      ],
                      if (!widget.permission) ...[
                        EnterInformationWidget.user(
                          userStream,
                          nameUserController,
                          numberPhoneController,
                          () {
                            ControllerApp.clickButtonInformationUser(
                              context,
                              widget.email,
                              nameUserController.text,
                              numberPhoneController.text,
                              userStream,
                              widget.permission,
                              isLoading,
                            );
                          },
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
            Obx(() {
              return Container(
                child: isLoading.value ? loading() : null,
              );
            })
          ],
        ));
  }
}
