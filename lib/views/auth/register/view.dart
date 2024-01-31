import 'package:alalmiya_g2/core/design/app_button.dart';
import 'package:alalmiya_g2/core/logic/dio_helper.dart';
import 'package:alalmiya_g2/core/logic/helper_methods.dart';
import 'package:alalmiya_g2/views/auth/register/cubit.dart';
import 'package:alalmiya_g2/views/auth/register/states.dart';
import 'package:alalmiya_g2/views/sheets/cities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/design/app_input.dart';
import '../confirm_code/view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Builder(builder: (context) {
        RegisterCubit cubit = BlocProvider.of(context);
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
                    key: cubit.formKey,
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
                          controller: cubit.fullNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "User name must be at least 3 digits";
                            }
                            return null;
                          },
                          paddingTop: 27,
                          icon: "assets/icons/user_name.png",
                        ),
                        AppInput(
                          labelText: "رقم الجوال",
                          icon: "assets/icons/phone.png",
                          controller: cubit.phoneController,
                          isPhone: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "رقم الهاتف مطلوب ";
                            } else if (value.length < 9) {
                              return "يجب ان يكون رقم الهاتف ٩ ارقام";
                            }
                            return null;
                          },
                        ),
                        StatefulBuilder(
                          builder: (context, setState) => GestureDetector(
                            onTap: () async {
                              var result = await showModalBottomSheet(
                                context: context,
                                builder: (context) => CitiesSheet(),
                              );
                              if (result != null) {
                                cubit.selectedCity = result;
                                setState(() {});
                                print("The result is ${cubit.selectedCity!.name}");
                              }
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: AbsorbPointer(
                                    absorbing: true,
                                    child: AppInput(
                                      labelText: cubit.selectedCity?.name ?? "المدينة",
                                      paddingBottom: 0,
                                      validator: (value) {
                                        if (cubit.selectedCity == null) {
                                          return "You must select your city";
                                        }
                                        return null;
                                      },
                                      icon: "assets/icons/city.png",
                                    ),
                                  ),
                                ),
                                if (cubit.selectedCity != null)
                                  IconButton(
                                    onPressed: () {
                                      cubit.selectedCity = null;
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
                          controller: cubit.passwordController,
                          icon: "assets/icons/password.png",
                          isPassword: true,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "كلمة المرور مطلوبه";
                            } else if (value.toString().length < 6) {
                              return "كلمة المرور ضعيفه";
                            }
                            return null;
                          },
                        ),
                        AppInput(
                          labelText: "كلمة المرور",
                          controller: cubit.confirmPasswordController,
                          icon: "assets/icons/password.png",
                          isPassword: true,
                          paddingBottom: 22,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "تأكيد كلمة المرور مطلوبه";
                            } else if (value != cubit.passwordController.text) {
                              return "كلمتا المرور غير متطابقتين";
                            }
                            return null;
                          },
                        ),
                        BlocBuilder(
                          bloc: cubit,
                          builder: (context, state) => AppButton(
                            text: "تسجيل",
                            isLoading: state is RegisterLoadingState,
                            onPress: () {
                              cubit.register();
                            },
                          ),
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
              ),
            ],
          ),
        );
      }),
    );
  }
}
