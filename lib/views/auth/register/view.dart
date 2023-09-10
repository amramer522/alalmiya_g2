import 'package:alalmiya_g2/core/design/app_button.dart';
import 'package:alalmiya_g2/core/logic/helper_methods.dart';
import 'package:alalmiya_g2/models/cities.dart';
import 'package:alalmiya_g2/views/sheets/cities.dart';
import 'package:flutter/material.dart';

import '../../../core/design/app_input.dart';
import '../confirm_code/view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  CityModel? selectedCity;

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
                  Text("يمكنك تسجيل حساب جديد الأن"),
                  AppInput(
                    labelText: "اسم المستخدم",
                    paddingTop: 27,
                    icon: "assets/icons/user_name.png",
                  ),
                  AppInput(
                    labelText: "رقم الجوال",
                    icon: "assets/icons/phone.png",
                    isPhone: true,
                  ),
                  StatefulBuilder(
                    builder: (context, setState) => GestureDetector(
                      onTap: () async {
                        var result = await showModalBottomSheet(
                          context: context,
                          builder: (context) => CitiesSheet(),
                        );
                        if (result != null) {
                          selectedCity = result;

                          // selectedCityText = result;
                          // selectedCityId = result[1];
                          setState(() {});
                          print("The result is ${selectedCity!.name}");
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AppInput(
                              labelText: selectedCity?.name ?? "المدينة",
                              isEnabled: false,
                              paddingBottom: 0,
                              icon: "assets/icons/city.png",
                            ),
                          ),
                          if (selectedCity != null)
                            IconButton(
                              onPressed: () {
                                selectedCity = null;
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.clear,
                                size: 24,
                                color: Colors.red,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  AppInput(
                    labelText: "كلمة المرور",
                    icon: "assets/icons/password.png",
                    isPassword: true,
                  ),
                  AppInput(
                    labelText: "كلمة المرور",
                    icon: "assets/icons/password.png",
                    isPassword: true,
                    paddingBottom: 22,
                  ),
                  AppButton(
                    text: "تسجيل",
                    onPress: () {
                      navigateTo(ConfirmCodeView(isActive: true));
                    },
                  ),
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
