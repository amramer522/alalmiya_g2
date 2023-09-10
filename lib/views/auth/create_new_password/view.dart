import 'package:alalmiya_g2/core/design/app_button.dart';
import 'package:alalmiya_g2/core/design/app_input.dart';
import 'package:flutter/material.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({Key? key}) : super(key: key);

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  bool isPasswordHidden = true;
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
              child: Form(
                key: formKey,
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
                    Text("أدخل كلمة المرور الجديدة"),
                    AppInput(
                      labelText: "كلمة المرور",
                      controller: passwordController,
                      icon: "assets/icons/password.png",
                      isPassword: true,
                      paddingBottom: 22,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return "كلمة المرور مطلوبه";
                        } else if (value.toString().length < 6) {
                          return "كلمة المرور ضعيفه";
                        }
                        return null;
                      },
                      paddingTop: 27,
                    ),
                    AppInput(
                      labelText: "كلمة المرور",
                      controller: confirmPasswordController,
                      icon: "assets/icons/password.png",
                      isPassword: true,
                      paddingBottom: 21,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return "تأكيد كلمة المرور مطلوبه";
                        } else if (value != passwordController.text) {
                          return "كلمتا المرور غير متطابقتين";
                        }
                        return null;
                      },
                    ),
                    AppButton(
                        onPress: () {
                          if (formKey.currentState!.validate()) {}
                        },
                        text: "تغيير كلمة المرور"),
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
          ),
        ],
      ),
    );
  }
}
