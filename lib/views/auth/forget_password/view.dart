import 'package:alalmiya_g2/core/design/app_input.dart';
import 'package:alalmiya_g2/core/logic/helper_methods.dart';
import 'package:flutter/material.dart';
import '../../../core/design/app_button.dart';
import '../confirm_code/view.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  bool isPasswordHidden = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                    "نسيت كلمة المرور",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text("أدخل رقم الجوال المرتبط بحسابك"),
                  Form(
                    key: formKey,
                    child: AppInput(
                      labelText: "رقم الجوال",
                      icon: "assets/icons/phone.png",
                      validator:(value) {
                        if (value!.isEmpty) {
                          return "رقم الهاتف مطلوب ";
                        } else if (value.length < 9) {
                          return "يجب ان يكون رقم الهاتف ٩ ارقام";
                        }
                        return null;
                      },
                      isPhone: true,
                      paddingBottom: 21,
                      paddingTop: 27,
                    ),
                  ),
                  AppButton(
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          navigateTo(ConfirmCodeView(isActive: false));
                        }
                      },
                      text: "تأكيد رقم الجوال"),
                  SizedBox(
                    height: 48,
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
  }
}
