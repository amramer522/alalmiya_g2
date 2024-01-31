import 'dart:io';

import 'package:alalmiya_g2/core/logic/helper_methods.dart';
import 'package:alalmiya_g2/views/auth/confirm_code/events.dart';
import 'package:alalmiya_g2/views/auth/confirm_code/states.dart';
import 'package:alalmiya_g2/views/auth/create_new_password/view.dart';
import 'package:alalmiya_g2/views/auth/login/view.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:circular_countdown_timer/countdown_text_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/design/app_button.dart';
import '../../../core/logic/dio_helper.dart';
import 'bloc.dart';

class ConfirmCodeView extends StatefulWidget {
  final bool isActive;
  final String phone;

  const ConfirmCodeView({Key? key, required this.phone, required this.isActive}) : super(key: key);

  @override
  State<ConfirmCodeView> createState() => _ConfirmCodeViewState();
}

class _ConfirmCodeViewState extends State<ConfirmCodeView> {
  @override
  Widget build(BuildContext context) {
    ConfirmCodeBloc bloc = BlocProvider.of(context);

    return Builder(builder: (context) {
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
                      widget.isActive ? "تفعيل الحساب" : "نسيت كلمة المرور",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text("أدخل الكود المكون من 4 أرقام المرسل علي رقم الجوال"),
                    Row(
                      children: [
                        Text(
                          "+${widget.phone}",
                          textDirection: TextDirection.ltr,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "تغيير رقم الجوال",
                              style: TextStyle(decoration: TextDecoration.underline),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 27,
                    ),
                    PinCodeTextField(
                      appContext: context,
                      length: 4,
                      controller: bloc.codeController,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(15),
                          fieldHeight: 60,
                          fieldWidth: 70,
                          inactiveColor: Color(0xffF3F3F3),
                          selectedColor: Theme.of(context).primaryColor),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 27,
                    ),
                    BlocBuilder(
                        bloc: bloc,
                        builder: (context, state) {
                          return AppButton(
                              isLoading: state is ConfirmCodeLoadingState,
                              onPress: () {
                                bloc.add(ConfirmCodeEvent(isActive: widget.isActive, phone: widget.phone));
                              },
                              text: "تأكيد الكود");
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "لم تستلم الكود ؟\nيمكنك إعادة إرسال الكود بعد",
                      textAlign: TextAlign.center,
                      style: TextStyle(height: 2),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    bloc.isTimerFinished
                        ? Center(
                            child: OutlinedButton(
                              onPressed: () async {
                                bloc.add(ResendCodeEvent(phone:widget.phone ));
                                bloc.isTimerFinished = false;
                                setState(() {});
                              },
                              child: Text("إعادة الإرسال"),
                            ),
                          )
                        : CircularCountDownTimer(
                            duration: 5,
                            initialDuration: 0,
                            height: 60,
                            width: 60,
                            ringColor: Theme.of(context).primaryColor,
                            fillColor: Color(0xffD8D8D8),
                            strokeWidth: 3,
                            onComplete: () {
                              bloc.isTimerFinished = true;
                              setState(() {});
                            },
                            isReverseAnimation: true,
                            textStyle: TextStyle(fontSize: 15, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                            textFormat: CountdownTextFormat.MM_SS,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "لديك حساب بالفعل ؟",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor),
                        ),
                        TextButton(onPressed: () {}, child: Text("تسجيل الدخول", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
