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
import '../../helper/widgets/loading_helper.dart';
import '../../helper/widgets/text_form_filed_widget.dart';
import '../../streams/account_error.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  AccountErrorStreams accountStream = AccountErrorStreams();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  RxBool isClickText = false.obs;

  final _keyForm = GlobalKey<FormState>();

  RxString error = ''.obs;

  RxBool isLoading = false.obs;

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
                      const Text('Đăng nhập',
                          style: TextStyleConstants.textLoginStyle),
                      const SizedBox(height: 20),
                      TffEmailWidgetStream(
                        stream: accountStream.emailErrorStream,
                        controller: emailController,
                        labelText: 'Email',
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
                      const SizedBox(height: 10),
                      GestureDetector(onTap: () {
                        isClickText.value = true;
                        isLoading.value = true;
                        Future.delayed(
                          const Duration(milliseconds: 400),
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
                          'Chưa có tài khoản??',
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
                        onPressed: () {
                          ControllerApp.clickButtonLogin(
                            context,
                            accountStream,
                            emailController.text,
                            passwordController.text,
                            error,
                            isLoading,
                          );
                        },
                        title: 'Đăng nhập',
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
            Obx(() {
              return Container(
                child: isLoading.value ? loading() : null,
              );
            })
          ],
        ));
  }
}
