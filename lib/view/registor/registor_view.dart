import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../bloc/bloc_export.dart';
import '../../controller/controller.dart';
import '../../helper/constants/icons_constants.dart';
import '../../helper/constants/textstyle_constants.dart';
import '../../helper/constants/value_constants.dart';
import '../../helper/widgets/background_widget.dart';
import '../../helper/widgets/button_widget.dart';
import '../../helper/widgets/drop_down_helper.dart';
import '../../helper/widgets/loading_helper.dart';
import '../../helper/widgets/text_form_filed_widget.dart';
import '../../streams/account_error.dart';

class RegistorView extends StatefulWidget {
  const RegistorView({super.key});

  @override
  State<RegistorView> createState() => _RegistorViewState();
}

class _RegistorViewState extends State<RegistorView> {
  AccountErrorStreams accountStream = AccountErrorStreams();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  RxBool isClickText = false.obs;

  final _keyForm = GlobalKey<FormState>();

  RxString error = ''.obs;

  RxBool isLoading = false.obs;

  RxString textPermission = ''.obs;

  @override
  void dispose() {
    super.dispose();
    accountStream.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                      const Text('Đăng Ký',
                          style: TextStyleConstants.textLoginStyle),
                      const SizedBox(height: 20),
                      TffEmailWidgetStream(
                        controller: emailController,
                        labelText: 'Email',
                        stream: accountStream.emailErrorStream,
                      ),
                      const SizedBox(height: 20),
                      StreamBuilder(
                          stream: accountStream.passwordErrorStream,
                          builder: (context, snapshot) {
                            return Padding(
                              padding: ValuesConstants.padingTextFieldLogin,
                              child: TffPasswordWidget(
                                password: passwordController,
                                error: snapshot.hasData ? snapshot.data : null,
                              ),
                            );
                          }),
                      const SizedBox(height: 20),
                      Obx(() {
                        return customDropDrownButton(
                          textPermission.value,
                          (value) {
                            textPermission.value = value.toString();
                            return null;
                          },
                        );
                      }),
                      const SizedBox(height: 10),
                      GestureDetector(onTap: () {
                        debugPrint('click next to registor');
                        isClickText.value = true;
                        isLoading.value = true;
                        Future.delayed(
                          const Duration(milliseconds: 200),
                          () {
                            isClickText.value = false;
                            isLoading.value = false;
                            context
                                .read<BlocApp>()
                                .add(const LoginAndRegistorEvent());
                          },
                        );
                      }, child: Obx(() {
                        return Text(
                          'Đăng nhập',
                          style: TextStyle(
                            decoration: !isClickText.value
                                ? TextDecoration.none
                                : TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        );
                      })),
                      const SizedBox(height: 10),
                      ButtonWidget(
                        onPressed: () async {
                          debugPrint(textPermission.value);
                          ControllerApp.clickButtonRegistor(
                            context,
                            accountStream,
                            emailController.text,
                            passwordController.text,
                            textPermission.value == 'Manager' ? true : false,
                            error,
                            isLoading,
                          );
                        },
                        title: 'Nhập thông tin ->',
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Obx(
                          () => Text(
                            error.value,
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontStyle: FontStyle.italic,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => Container(
                child: isLoading.value ? loading() : null,
              ),
            )
          ],
        ));
  }
}
