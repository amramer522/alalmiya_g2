import 'dart:io';

import 'package:alalmiya_g2/views/auth/login/events.dart';
import 'package:alalmiya_g2/views/auth/login/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/cache_helper.dart';
import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../../home/view.dart';
import 'model.dart';

class LoginBloc  extends Bloc<LoginEvents,LoginStates>
{

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController(text: "55001122334455");
  final passwordController = TextEditingController(text: "123456789");

  // bool isLoading = false;

  LoginBloc():super(LoginStates()){
    on<LoginEvent> (_login);
  }

  void _login(LoginEvent event,Emitter<LoginStates> emit) async {
    if (formKey.currentState!.validate()) {
      // isLoading = true;
      // setState(() {});
      emit(LoginLoadingState());
      final response = await DioHelper().sendData("login", data: {
        "phone": phoneController.text,
        "password": passwordController.text,
        "type": Platform.operatingSystem,
        "device_token": "test",
        "user_type": "client",
      });
      if (response.isSuccess) {
        final model = UserData.fromJson(response.response!.data);
        // if(model.model.isActive)
        //   {
        await CacheHelper.saveUserData(model.model);
        showMessage(response.message, type: MessageType.success);
        navigateTo(HomeView());
        // }else
        //   {
        //     showMessage("برجاء تفعيل الحساب", type: MessageType.warning);
        //
        //     navigateTo(ConfirmCodeView(phone: phoneController.text, isActive: true));
        //   }

        emit(LoginSuccessState());
      } else {
        showMessage(response.message);
        emit(LoginFailedState());
      }

      // isLoading = false;
      // setState(() {});
    }
  }
}
