import 'dart:io';

import 'package:alalmiya_g2/core/design/app_button.dart';
import 'package:alalmiya_g2/core/logic/cache_helper.dart';
import 'package:alalmiya_g2/core/logic/dio_helper.dart';
import 'package:alalmiya_g2/core/logic/helper_methods.dart';
import 'package:alalmiya_g2/main.dart';
import 'package:alalmiya_g2/views/auth/confirm_code/view.dart';
import 'package:alalmiya_g2/views/auth/login/bloc.dart';
import 'package:alalmiya_g2/views/auth/login/events.dart';
import 'package:alalmiya_g2/views/auth/login/states.dart';
import 'package:alalmiya_g2/views/home/view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/design/app_input.dart';
import '../forget_password/view.dart';
import '../register/view.dart';
import 'model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Builder(builder: (context) {
        LoginBloc controller = BlocProvider.of(context);
        return Container(
          color: Colors.white,
          child: Stack(
            children: [
              Image.asset(
                "assets/images/splash_bg.png",
                height: double.infinity,
                width: double.infinity,
                color: Color(0xff4C8613).withOpacity(.2),
                fit: BoxFit.fill,
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Form(
                    key: controller.formKey,
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 125,
                            width: 130,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          "مرحبا بك مرة أخرى",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text("يمكنك تسجيل الدخول الأن"),
                        SizedBox(
                          height: 27,
                        ),
                        AppInput(
                          labelText: "رقم الجوال",
                          controller: controller.phoneController,
                          isPhone: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "رقم الهاتف مطلوب ";
                            } else if (value.length < 9) {
                              return "يجب ان يكون رقم الهاتف ٩ ارقام";
                            }
                            return null;
                          },
                          icon: "assets/icons/phone.png",
                        ),
                        AppInput(
                          labelText: "كلمة المرور",
                          controller: controller.passwordController,
                          isPassword: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "كلمة المرور مطلوب ";
                            } else if (value.length < 7) {
                              return "كلمة المرور ضعيفه";
                            }
                            return null;
                          },
                          icon: "assets/icons/password.png",
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        GestureDetector(
                          onTap: () {
                            navigateTo(ForgetPasswordView());
                          },
                          child: Text(
                            "نسيت كلمة المرور ؟",
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(
                          height: 21,
                        ),
                        BlocBuilder(
                          bloc: controller,
                          builder: (context, state) => AppButton(
                            onPress: () {
                              controller.add(LoginEvent());
                            },
                            isLoading: state is LoginLoadingState,
                            text: "تسجيل الدخول",
                          ),
                        ),
                        SizedBox(
                          height: 48,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ليس لديك حساب ؟",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor),
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(RegisterView());
                                },
                                child: Text("تسجيل الأن", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
